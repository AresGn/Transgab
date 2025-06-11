# 🚂 Train Reservation Gabon - Guide Monorepo

## 🎯 **Structure Consolidée**

Votre projet a été restructuré en **monorepo professionnel** avec une gestion unifiée des dépendances.

### **📁 Structure du Projet**

```
train-reservation-gabon/
├── 📦 package.json              # ✅ UNIQUE - Gère toutes les dépendances
├── 🔒 .gitignore               # ✅ UNIQUE - Optimisé pour monorepo
├── 📄 README.md                # Documentation principale
├── ⚙️  .env.example            # Variables d'environnement
├── 
├── 📂 src/
│   ├── 🎨 frontend/            # Application React
│   │   ├── 📦 package.json     # ✅ SIMPLIFIÉ - Juste les métadonnées
│   │   ├── 📂 src/
│   │   ├── 📂 public/
│   │   └── ⚙️  tailwind.config.js
│   │
│   ├── ⚙️  backend/            # API Express
│   │   ├── 📦 package.json     # ✅ SIMPLIFIÉ - Juste les métadonnées
│   │   ├── 📂 config/
│   │   ├── 📂 models/
│   │   ├── 📂 services/
│   │   └── 📂 utils/
│   │
│   └── 🔗 shared/              # Code partagé
│       ├── 📂 constants/
│       ├── 📂 types/
│       └── 📂 utils/
│
├── 🗄️  database/              # Scripts SQL
├── 🔧 scripts/                # Scripts utilitaires
└── 📋 tests/                  # Tests globaux
```

## ✅ **Problèmes Résolus**

### **1. Configuration Git** ✅
- ✅ Dépôt Git correctement configuré
- ✅ Premier commit créé avec succès
- ✅ Push vers GitHub en cours
- ✅ Suppression des dépôts Git imbriqués

### **2. Structure Monorepo** ✅
- ✅ **UN SEUL package.json** à la racine
- ✅ **UN SEUL .gitignore** optimisé
- ✅ Gestion unifiée des dépendances
- ✅ Scripts consolidés
- ✅ Configuration workspace

## 🚀 **Commandes Disponibles**

### **Développement**
```bash
# Démarrer frontend + backend simultanément
npm run dev

# Démarrer uniquement le frontend
npm run dev:frontend

# Démarrer uniquement le backend
npm run dev:backend
```

### **Build et Production**
```bash
# Build complet
npm run build

# Build frontend uniquement
npm run build:frontend

# Build backend uniquement
npm run build:backend

# Démarrer en production
npm start
```

### **Tests**
```bash
# Tous les tests
npm test

# Tests frontend uniquement
npm run test:frontend

# Tests backend uniquement
npm run test:backend
```

### **Gestion Monorepo** 🆕
```bash
# Configuration complète du monorepo
npm run monorepo:setup

# Installer toutes les dépendances
npm run monorepo:install

# Nettoyer tous les node_modules
npm run monorepo:clean

# Afficher le statut du monorepo
npm run monorepo:status
```

### **Base de Données**
```bash
# Tester la connexion Neon
npm run test:neon

# Déployer le schéma complet
npm run setup:neon
```

### **Qualité de Code**
```bash
# Linter complet
npm run lint

# Formatage du code
npm run format
```

## 🔧 **Installation et Configuration**

### **1. Installation Initiale**
```bash
# Cloner le projet
git clone https://github.com/AresGn/Transgab.git
cd train-reservation-gabon

# Configuration complète automatique
npm run monorepo:setup
```

### **2. Configuration Base de Données**
```bash
# Copier les variables d'environnement
cp .env.example .env

# Éditer .env avec vos identifiants Neon
# Puis déployer le schéma
npm run setup:neon
```

### **3. Démarrage Développement**
```bash
# Démarrer tout en une commande
npm run dev
```

## 📦 **Gestion des Dépendances**

### **✅ Nouvelle Approche (Monorepo)**
- **Toutes les dépendances** dans le package.json racine
- **Installation unique** : `npm install`
- **Gestion centralisée** des versions
- **Pas de conflits** entre frontend/backend

### **❌ Ancienne Approche (Supprimée)**
- ~~3 fichiers package.json séparés~~
- ~~Installations multiples~~
- ~~Gestion manuelle des versions~~
- ~~Conflits potentiels~~

## 🎯 **Avantages du Monorepo**

### **🔧 Développement**
- ✅ **Une seule commande** pour tout installer
- ✅ **Scripts unifiés** pour dev/build/test
- ✅ **Partage de code** facilité
- ✅ **Versions synchronisées**

### **🚀 Déploiement**
- ✅ **Build unifié** frontend + backend
- ✅ **Configuration centralisée**
- ✅ **CI/CD simplifié**

### **👥 Équipe**
- ✅ **Onboarding rapide** des nouveaux développeurs
- ✅ **Configuration cohérente** pour tous
- ✅ **Moins de confusion** sur les dépendances

## 🆘 **Dépannage**

### **Problème : node_modules manquants**
```bash
npm run monorepo:clean
npm run monorepo:install
```

### **Problème : Conflits de versions**
```bash
npm run clean
npm install
```

### **Problème : Scripts ne fonctionnent pas**
```bash
npm run monorepo:status
```

## 📞 **Support**

- **Documentation** : Voir README.md
- **Issues** : https://github.com/AresGn/Transgab/issues
- **Configuration Neon** : Voir GUIDE_CONFIGURATION_NEON.md

---

**🎉 Votre projet est maintenant configuré en monorepo professionnel ! 🎉**
