#!/usr/bin/env node

/**
 * Script de configuration automatique pour Neon PostgreSQL
 * Train Reservation Gabon
 * 
 * Ce script remplace la commande psql pour une meilleure compatibilité Windows
 */

require('dotenv').config();
const { Pool } = require('pg');
const fs = require('fs');
const path = require('path');

// Couleurs pour les logs
const colors = {
  reset: '\x1b[0m',
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  cyan: '\x1b[36m'
};

/**
 * Affiche un message coloré
 */
function log(message, color = colors.reset) {
  console.log(`${color}${message}${colors.reset}`);
}

/**
 * Vérifie la configuration
 */
function checkConfiguration() {
  log('\n🔍 Vérification de la configuration...', colors.blue);
  
  if (!process.env.DATABASE_URL) {
    log('❌ ERROR: DATABASE_URL n\'est pas définie dans le fichier .env', colors.red);
    log('📝 Veuillez configurer votre chaîne de connexion Neon dans .env', colors.yellow);
    log('💡 Format: postgresql://username:password@host/database?sslmode=require', colors.cyan);
    process.exit(1);
  }
  
  log('✅ DATABASE_URL trouvée', colors.green);
  
  // Masquer le mot de passe dans l'affichage
  const maskedUrl = process.env.DATABASE_URL.replace(/:([^:@]+)@/, ':****@');
  log(`🔗 Connexion: ${maskedUrl}`, colors.cyan);
}

/**
 * Lit le fichier SQL de déploiement
 */
function readSqlFile() {
  const sqlPath = path.join(__dirname, '..', 'database', 'deploy_neon.sql');
  
  if (!fs.existsSync(sqlPath)) {
    log(`❌ ERROR: Fichier SQL non trouvé: ${sqlPath}`, colors.red);
    process.exit(1);
  }
  
  log('📄 Lecture du fichier deploy_neon.sql...', colors.blue);
  return fs.readFileSync(sqlPath, 'utf8');
}

/**
 * Exécute le déploiement
 */
async function deploySchema() {
  const pool = new Pool({
    connectionString: process.env.DATABASE_URL,
    ssl: { rejectUnauthorized: false }
  });

  try {
    log('\n🚀 Démarrage du déploiement...', colors.blue);
    
    // Test de connexion
    log('🔌 Test de connexion à Neon...', colors.yellow);
    const client = await pool.connect();
    
    log('✅ Connexion réussie !', colors.green);
    
    // Lecture et exécution du script SQL
    const sqlContent = readSqlFile();
    log('⚡ Exécution du script de déploiement...', colors.yellow);
    
    await client.query(sqlContent);
    
    log('✅ Schéma déployé avec succès !', colors.green);
    
    // Vérification des données
    log('\n📊 Vérification des données...', colors.blue);
    const result = await client.query(`
      SELECT 'Gares créées' as type, COUNT(*) as count FROM stations
      UNION ALL
      SELECT 'Types de trains' as type, COUNT(*) as count FROM train_types
      UNION ALL
      SELECT 'Horaires configurés' as type, COUNT(*) as count FROM schedules
      UNION ALL
      SELECT 'Tarifs configurés' as type, COUNT(*) as count FROM pricing;
    `);
    
    console.log('\n📈 Statistiques de déploiement:');
    result.rows.forEach(row => {
      log(`   ${row.type}: ${row.count}`, colors.cyan);
    });
    
    client.release();
    
    log('\n🎉 Déploiement terminé avec succès !', colors.green);
    log('💡 Vous pouvez maintenant tester avec: npm run test:neon', colors.cyan);
    
  } catch (error) {
    log('\n❌ ERREUR lors du déploiement:', colors.red);
    
    if (error.code === 'ENOTFOUND') {
      log('🌐 Problème de réseau - Vérifiez votre connexion internet', colors.yellow);
    } else if (error.code === '28P01') {
      log('🔐 Erreur d\'authentification - Vérifiez vos identifiants Neon', colors.yellow);
      log('💡 Assurez-vous que DATABASE_URL contient le bon username:password', colors.cyan);
    } else if (error.code === '3D000') {
      log('🗄️  Base de données non trouvée - Vérifiez le nom de la base', colors.yellow);
    } else {
      log(`🔍 Code d'erreur: ${error.code}`, colors.yellow);
      log(`📝 Message: ${error.message}`, colors.yellow);
    }
    
    log('\n🆘 Solutions possibles:', colors.cyan);
    log('1. Vérifiez que DATABASE_URL est correcte dans .env', colors.cyan);
    log('2. Connectez-vous à https://console.neon.tech/ pour vérifier vos identifiants', colors.cyan);
    log('3. Assurez-vous que votre projet Neon est actif', colors.cyan);
    
    process.exit(1);
  } finally {
    await pool.end();
  }
}

/**
 * Fonction principale
 */
async function main() {
  log('🚂 Train Reservation Gabon - Configuration Neon', colors.blue);
  log('=' .repeat(50), colors.blue);
  
  checkConfiguration();
  await deploySchema();
}

// Exécution
if (require.main === module) {
  main().catch(error => {
    log('\n💥 Erreur inattendue:', colors.red);
    console.error(error);
    process.exit(1);
  });
}

module.exports = { main };
