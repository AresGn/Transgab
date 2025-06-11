#!/usr/bin/env node

/**
 * Script de test de connexion à la base de données Neon
 * Train Reservation Gabon
 */

require('dotenv').config();
const { Pool } = require('pg');

// Configuration de la connexion
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : false
});

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
 * Teste la connexion de base
 */
async function testBasicConnection() {
  log('\n🔌 Test de connexion de base...', colors.blue);
  
  try {
    const client = await pool.connect();
    const result = await client.query('SELECT version()');
    
    log('✅ Connexion réussie!', colors.green);
    log(`📊 Version PostgreSQL: ${result.rows[0].version}`, colors.cyan);
    
    client.release();
    return true;
  } catch (error) {
    log('❌ Erreur de connexion:', colors.red);
    log(error.message, colors.red);
    return false;
  }
}

/**
 * Vérifie que les tables existent
 */
async function checkTables() {
  log('\n📋 Vérification des tables...', colors.blue);
  
  const expectedTables = [
    'users', 'stations', 'train_types', 'schedules', 
    'schedule_stops', 'bookings', 'passengers', 'payments', 'pricing'
  ];
  
  try {
    const client = await pool.connect();
    
    for (const table of expectedTables) {
      const result = await client.query(`
        SELECT EXISTS (
          SELECT FROM information_schema.tables 
          WHERE table_name = $1
        )
      `, [table]);
      
      if (result.rows[0].exists) {
        log(`✅ Table '${table}' existe`, colors.green);
      } else {
        log(`❌ Table '${table}' manquante`, colors.red);
      }
    }
    
    client.release();
    return true;
  } catch (error) {
    log('❌ Erreur lors de la vérification des tables:', colors.red);
    log(error.message, colors.red);
    return false;
  }
}

/**
 * Vérifie les données de base
 */
async function checkData() {
  log('\n📊 Vérification des données...', colors.blue);
  
  try {
    const client = await pool.connect();
    
    // Vérifier les gares
    const stationsResult = await client.query('SELECT COUNT(*) FROM stations');
    const stationsCount = parseInt(stationsResult.rows[0].count);
    
    if (stationsCount === 22) {
      log(`✅ Gares: ${stationsCount}/22 (complet)`, colors.green);
    } else {
      log(`⚠️  Gares: ${stationsCount}/22 (incomplet)`, colors.yellow);
    }
    
    // Vérifier les types de trains
    const trainTypesResult = await client.query('SELECT COUNT(*) FROM train_types');
    const trainTypesCount = parseInt(trainTypesResult.rows[0].count);
    
    if (trainTypesCount === 2) {
      log(`✅ Types de trains: ${trainTypesCount}/2 (complet)`, colors.green);
    } else {
      log(`⚠️  Types de trains: ${trainTypesCount}/2 (incomplet)`, colors.yellow);
    }
    
    // Vérifier les horaires
    const schedulesResult = await client.query('SELECT COUNT(*) FROM schedules');
    const schedulesCount = parseInt(schedulesResult.rows[0].count);
    
    if (schedulesCount === 8) {
      log(`✅ Horaires: ${schedulesCount}/8 (complet)`, colors.green);
    } else {
      log(`⚠️  Horaires: ${schedulesCount}/8 (incomplet)`, colors.yellow);
    }
    
    // Vérifier les tarifs
    const pricingResult = await client.query('SELECT COUNT(*) FROM pricing');
    const pricingCount = parseInt(pricingResult.rows[0].count);
    
    if (pricingCount >= 28) {
      log(`✅ Tarifs: ${pricingCount} configurés`, colors.green);
    } else {
      log(`⚠️  Tarifs: ${pricingCount} configurés (peut-être incomplet)`, colors.yellow);
    }
    
    client.release();
    return true;
  } catch (error) {
    log('❌ Erreur lors de la vérification des données:', colors.red);
    log(error.message, colors.red);
    return false;
  }
}

/**
 * Teste une requête complexe
 */
async function testComplexQuery() {
  log('\n🔍 Test de requête complexe...', colors.blue);
  
  try {
    const client = await pool.connect();
    
    const result = await client.query(`
      SELECT 
        s.name as departure_station,
        s2.name as arrival_station,
        tt.display_name as train_type,
        sch.day_of_week,
        sch.departure_time
      FROM schedules sch
      JOIN stations s ON sch.departure_station_id = s.id
      JOIN stations s2 ON sch.arrival_station_id = s2.id
      JOIN train_types tt ON sch.train_type_id = tt.id
      WHERE sch.day_of_week = 'saturday'
      ORDER BY sch.departure_time
      LIMIT 5
    `);
    
    if (result.rows.length > 0) {
      log('✅ Requête complexe réussie!', colors.green);
      log('📋 Exemple d\'horaires du samedi:', colors.cyan);
      
      result.rows.forEach(row => {
        log(`   ${row.departure_time} - ${row.train_type}: ${row.departure_station} → ${row.arrival_station}`, colors.cyan);
      });
    } else {
      log('⚠️  Requête réussie mais aucun résultat', colors.yellow);
    }
    
    client.release();
    return true;
  } catch (error) {
    log('❌ Erreur lors de la requête complexe:', colors.red);
    log(error.message, colors.red);
    return false;
  }
}

/**
 * Affiche les informations de configuration
 */
function showConfig() {
  log('\n⚙️  Configuration actuelle:', colors.blue);
  
  const dbUrl = process.env.DATABASE_URL;
  if (dbUrl) {
    // Masquer le mot de passe pour la sécurité
    const maskedUrl = dbUrl.replace(/:([^:@]+)@/, ':****@');
    log(`📡 DATABASE_URL: ${maskedUrl}`, colors.cyan);
  } else {
    log('❌ DATABASE_URL non configurée', colors.red);
  }
  
  log(`🌍 NODE_ENV: ${process.env.NODE_ENV || 'non défini'}`, colors.cyan);
  log(`🔧 Pool min: ${process.env.DB_POOL_MIN || '1'}`, colors.cyan);
  log(`🔧 Pool max: ${process.env.DB_POOL_MAX || '5'}`, colors.cyan);
}

/**
 * Fonction principale
 */
async function main() {
  log('🚂 Test de connexion Neon - Train Reservation Gabon', colors.green);
  log('=' .repeat(60), colors.blue);
  
  showConfig();
  
  // Vérifier que DATABASE_URL est configurée
  if (!process.env.DATABASE_URL) {
    log('\n❌ DATABASE_URL non configurée dans .env', colors.red);
    log('💡 Copiez .env.example vers .env et configurez votre chaîne Neon', colors.yellow);
    process.exit(1);
  }
  
  let allTestsPassed = true;
  
  // Exécuter tous les tests
  allTestsPassed &= await testBasicConnection();
  allTestsPassed &= await checkTables();
  allTestsPassed &= await checkData();
  allTestsPassed &= await testComplexQuery();
  
  // Résumé final
  log('\n' + '=' .repeat(60), colors.blue);
  
  if (allTestsPassed) {
    log('🎉 Tous les tests sont passés! Base de données Neon prête.', colors.green);
    log('🚀 Vous pouvez maintenant lancer: npm run dev', colors.green);
  } else {
    log('⚠️  Certains tests ont échoué. Vérifiez la configuration.', colors.yellow);
    log('📖 Consultez scripts/setup-neon.md pour l\'aide', colors.yellow);
  }
  
  await pool.end();
}

// Gestion des erreurs non capturées
process.on('uncaughtException', (error) => {
  log('❌ Erreur non capturée:', colors.red);
  log(error.message, colors.red);
  process.exit(1);
});

process.on('unhandledRejection', (reason) => {
  log('❌ Promesse rejetée non gérée:', colors.red);
  log(reason, colors.red);
  process.exit(1);
});

// Lancer le script
if (require.main === module) {
  main().catch((error) => {
    log('❌ Erreur lors de l\'exécution:', colors.red);
    log(error.message, colors.red);
    process.exit(1);
  });
}

module.exports = { main };
