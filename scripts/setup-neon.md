# 🐘 Guide de Configuration Neon PostgreSQL

## 📋 Étapes de Configuration

### 1. Création du compte Neon

1. **Aller sur Neon Console**
   - Ouvrir https://console.neon.tech/app/projects
   - Créer un compte gratuit si nécessaire

2. **Créer un nouveau projet**
   - Cliquer sur "New Project"
   - Nom du projet : `train-reservation-gabon`
   - Région : `US East (Ohio)` ou la plus proche
   - PostgreSQL version : `15` (recommandée)

### 2. Configuration de la base de données

3. **Récupérer la chaîne de connexion**
   - Dans le dashboard Neon, aller dans "Connection Details"
   - Copier la "Connection string"
   - Format : `postgresql://username:password@ep-xxx.region.aws.neon.tech/dbname?sslmode=require`

4. **Configurer les variables d'environnement**
   ```bash
   # Copier le fichier d'exemple
   cp .env.example .env
   
   # Éditer .env et remplacer DATABASE_URL par votre vraie chaîne Neon
   nano .env
   ```

### 3. Déploiement du schéma

5. **Installer psql (si nécessaire)**
   ```bash
   # Windows (avec Chocolatey)
   choco install postgresql
   
   # macOS (avec Homebrew)
   brew install postgresql
   
   # Ubuntu/Debian
   sudo apt-get install postgresql-client
   ```

6. **Déployer le schéma complet**
   ```bash
   # Depuis la racine du projet
   psql "votre_database_url_neon" -f database/deploy_neon.sql
   ```

### 4. Vérification

7. **Tester la connexion**
   ```bash
   # Se connecter à la base
   psql "votre_database_url_neon"
   
   # Vérifier les tables créées
   \dt
   
   # Vérifier les données
   SELECT COUNT(*) FROM stations;
   SELECT COUNT(*) FROM train_types;
   SELECT COUNT(*) FROM schedules;
   SELECT COUNT(*) FROM pricing;
   ```

## 🔧 Exemple de Configuration

### Fichier .env (exemple)
```env
# Base de données Neon
DATABASE_URL=postgresql://alex:AbC123dEf@ep-cool-darkness-123456.us-east-1.aws.neon.tech/neondb?sslmode=require

# Autres variables...
NODE_ENV=development
PORT=5000
JWT_SECRET=your_jwt_secret_here
```

### Test de connexion Node.js
```javascript
// test-neon.js
const { Pool } = require('pg');

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: { rejectUnauthorized: false }
});

async function testConnection() {
  try {
    const client = await pool.connect();
    const result = await client.query('SELECT COUNT(*) FROM stations');
    console.log('✅ Connexion Neon réussie!');
    console.log(`📊 Nombre de gares: ${result.rows[0].count}`);
    client.release();
  } catch (err) {
    console.error('❌ Erreur de connexion:', err);
  }
}

testConnection();
```

## 📊 Données Déployées

Après le déploiement, votre base Neon contiendra :

- **22 gares** du réseau ferroviaire gabonais
- **2 types de trains** (Omnibus, TSA Express)
- **8 horaires** configurés (mer/jeu/sam)
- **28 tarifs** de base configurés

## 🔒 Sécurité

### Bonnes pratiques Neon
- ✅ Utiliser SSL (sslmode=require)
- ✅ Ne jamais commiter les vraies credentials
- ✅ Utiliser des variables d'environnement
- ✅ Limiter les connexions simultanées
- ✅ Surveiller l'usage (dashboard Neon)

### Limites du plan gratuit Neon
- **Stockage** : 512 MB
- **Connexions** : 100 simultanées
- **Compute** : 1 vCPU, 256 MB RAM
- **Branches** : 10 branches de base de données

## 🚨 Dépannage

### Erreurs courantes

1. **"connection refused"**
   - Vérifier la chaîne de connexion
   - Vérifier que SSL est activé

2. **"database does not exist"**
   - Utiliser le nom de base par défaut (généralement "neondb")
   - Créer la base si nécessaire

3. **"too many connections"**
   - Réduire DB_POOL_MAX dans .env
   - Fermer les connexions inutilisées

### Commandes utiles
```bash
# Tester la connexion
psql "votre_database_url" -c "SELECT version();"

# Lister les tables
psql "votre_database_url" -c "\dt"

# Voir les statistiques
psql "votre_database_url" -c "
SELECT 'Gares' as type, COUNT(*) FROM stations
UNION ALL
SELECT 'Trains', COUNT(*) FROM train_types
UNION ALL
SELECT 'Horaires', COUNT(*) FROM schedules;"
```

## 📞 Support

- **Documentation Neon** : https://neon.tech/docs
- **Discord Neon** : https://discord.gg/92vNTzKDGp
- **GitHub Issues** : Pour les problèmes spécifiques au projet

---

**🎉 Une fois configuré, votre équipe pourra travailler sur la même base de données cloud ! 🎉**
