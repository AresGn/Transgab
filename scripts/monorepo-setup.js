#!/usr/bin/env node

/**
 * Script de configuration du monorepo
 * Train Reservation Gabon
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Couleurs pour les logs
const colors = {
  reset: '\x1b[0m',
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  cyan: '\x1b[36m'
};

function log(message, color = colors.reset) {
  console.log(`${color}${message}${colors.reset}`);
}

function checkNodeModules() {
  log('\n🔍 Vérification des node_modules...', colors.blue);
  
  const paths = [
    'node_modules',
    'src/frontend/node_modules',
    'src/backend/node_modules'
  ];
  
  paths.forEach(p => {
    if (fs.existsSync(p)) {
      log(`✅ ${p} existe`, colors.green);
    } else {
      log(`❌ ${p} manquant`, colors.red);
    }
  });
}

function installDependencies() {
  log('\n📦 Installation des dépendances...', colors.blue);
  
  try {
    log('🔄 Installation des dépendances racine...', colors.yellow);
    execSync('npm install', { stdio: 'inherit' });
    
    log('🔄 Installation des dépendances frontend...', colors.yellow);
    execSync('cd src/frontend && npm install', { stdio: 'inherit' });
    
    log('🔄 Installation des dépendances backend...', colors.yellow);
    execSync('cd src/backend && npm install', { stdio: 'inherit' });
    
    log('✅ Toutes les dépendances installées !', colors.green);
  } catch (error) {
    log('❌ Erreur lors de l\'installation des dépendances', colors.red);
    console.error(error.message);
    process.exit(1);
  }
}

function cleanNodeModules() {
  log('\n🧹 Nettoyage des node_modules...', colors.blue);
  
  try {
    execSync('npm run clean', { stdio: 'inherit' });
    log('✅ Nettoyage terminé !', colors.green);
  } catch (error) {
    log('❌ Erreur lors du nettoyage', colors.red);
    console.error(error.message);
  }
}

function showStatus() {
  log('\n📊 Statut du monorepo:', colors.blue);
  
  // Vérifier les package.json
  const packageFiles = [
    'package.json',
    'src/frontend/package.json',
    'src/backend/package.json'
  ];
  
  packageFiles.forEach(file => {
    if (fs.existsSync(file)) {
      const pkg = JSON.parse(fs.readFileSync(file, 'utf8'));
      log(`📄 ${file}: ${pkg.name}@${pkg.version}`, colors.cyan);
    } else {
      log(`❌ ${file} manquant`, colors.red);
    }
  });
  
  checkNodeModules();
}

function main() {
  const command = process.argv[2];
  
  log('🚂 Train Reservation Gabon - Gestion Monorepo', colors.blue);
  log('=' .repeat(50), colors.blue);
  
  switch (command) {
    case 'install':
      installDependencies();
      break;
    case 'clean':
      cleanNodeModules();
      break;
    case 'status':
      showStatus();
      break;
    case 'setup':
      cleanNodeModules();
      installDependencies();
      showStatus();
      break;
    default:
      log('\n📖 Commandes disponibles:', colors.cyan);
      log('  npm run monorepo:install  - Installer toutes les dépendances', colors.cyan);
      log('  npm run monorepo:clean    - Nettoyer tous les node_modules', colors.cyan);
      log('  npm run monorepo:status   - Afficher le statut du monorepo', colors.cyan);
      log('  npm run monorepo:setup    - Configuration complète', colors.cyan);
      break;
  }
}

if (require.main === module) {
  main();
}

module.exports = { main };
