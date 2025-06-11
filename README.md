# 🚂 Train Reservation Gabon

Système de réservation de tickets de train du Gabon - Structure unifiée Frontend + Backend

## 📋 Description

Application web complète pour la réservation de tickets de train sur le réseau ferroviaire gabonais (Transgabonais). Le système permet aux utilisateurs de rechercher, réserver et payer leurs billets de train en ligne.

### 🚆 Réseau ferroviaire couvert

- **22 gares** du réseau Transgabonais (Owendo → Franceville)
- **2 types de trains** : Omnibus et TSA Express
- **Horaires fixes** : Départs les mercredis, jeudis et samedis

## 🏗️ Architecture

### Structure unifiée
```
train-reservation-gabon/
├── src/
│   ├── frontend/          # Application React
│   ├── backend/           # API Node.js/Express
│   └── shared/            # Code partagé
├── database/              # Schémas et données SQL
├── tests/                 # Tests automatisés
├── docs/                  # Documentation
└── scripts/               # Scripts utilitaires
```

### Technologies utilisées

**Frontend:**
- React 18
- Tailwind CSS
- React Router
- Axios

**Backend:**
- Node.js
- Express.js
- PostgreSQL
- JWT Authentication

## 🚀 Installation et démarrage

### Prérequis
- Node.js >= 18.0.0
- npm >= 8.0.0
- PostgreSQL >= 13

### Installation

1. **Installer les dépendances**
```bash
npm run install:all
```

2. **Configurer la base de données Neon (cloud)**
```bash
# 1. Créer un compte sur https://console.neon.tech/
# 2. Créer un projet "train-reservation-gabon"
# 3. Copier la chaîne de connexion

# 4. Configurer les variables d'environnement
cp .env.example .env
# Éditer .env et remplacer DATABASE_URL par votre chaîne Neon

# 5. Déployer le schéma complet
npm run setup:neon

# 6. Tester la connexion
npm run test:neon
```

**Alternative locale (si vous préférez PostgreSQL local)**
```bash
# Créer la base de données PostgreSQL locale
createdb gabon_railway

# Exécuter les migrations
psql -d gabon_railway -f database/deploy_neon.sql
```

### Démarrage en développement

**Commande unique (recommandée):**
```bash
npm run dev
```

**Ou séparément:**
```bash
# Terminal 1 - Backend
npm run dev:backend

# Terminal 2 - Frontend  
npm run dev:frontend
```

### URLs de développement
- **Frontend:** http://localhost:3000
- **Backend API:** http://localhost:5000
- **API Documentation:** http://localhost:5000/api

## 🗄️ Base de données

### Tables principales
- `users` - Utilisateurs du système
- `stations` - 22 gares du réseau gabonais
- `train_types` - Types de trains (Omnibus, TSA Express)
- `schedules` - Horaires fixes
- `bookings` - Réservations
- `payments` - Paiements

### Données pré-chargées
- ✅ 22 gares du Transgabonais
- ✅ 2 types de trains configurés
- ✅ Horaires fixes (mer/jeu/sam)
- ✅ Tarifs de base

## 🧪 Tests

```bash
# Tous les tests
npm test

# Tests frontend uniquement
npm run test:frontend

# Tests backend uniquement
npm run test:backend
```

## 📦 Build et déploiement

```bash
# Build complet
npm run build

# Build frontend uniquement
npm run build:frontend

# Build backend uniquement
npm run build:backend
```

## 🛠️ Scripts disponibles

| Script | Description |
|--------|-------------|
| `npm run dev` | Démarre frontend + backend simultanément |
| `npm run dev:frontend` | Démarre uniquement le frontend React |
| `npm run dev:backend` | Démarre uniquement le backend Express |
| `npm run build` | Build complet du projet |
| `npm test` | Lance tous les tests |
| `npm run install:all` | Installe toutes les dépendances |
| `npm run clean` | Nettoie tous les node_modules |

## 🚆 Fonctionnalités

### ✅ Implémentées
- Structure de base complète
- Schéma de base de données
- Configuration des gares gabonaises
- Types de trains et horaires
- Scripts de développement

### 🔄 En cours
- Interface utilisateur React
- API REST backend
- Système d'authentification
- Moteur de recherche
- Processus de réservation
- Intégration paiements

### 📋 À venir
- Tests automatisés
- Documentation API
- Déploiement production
- Application mobile

## 🤝 Contribution

1. Fork le projet
2. Créer une branche feature (`git checkout -b feature/AmazingFeature`)
3. Commit les changements (`git commit -m 'Add AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

## 📞 Support

Pour toute question ou support, contactez l'équipe de développement.

---

**🚂 Train Reservation Gabon** - Facilitant les voyages ferroviaires au Gabon
