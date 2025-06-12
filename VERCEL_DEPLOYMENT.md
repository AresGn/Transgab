# Guide de Déploiement Vercel

## Configuration du Projet

Ce projet utilise une structure monorepo avec :
- Frontend React dans `src/frontend/`
- Backend Express dans `src/backend/`
- Dépendances centralisées dans le `package.json` racine

## Fichiers de Configuration

### vercel.json
- Configure le répertoire de sortie sur `build`
- Définit la commande de build : `npm run build`
- Configure les routes pour SPA

### Scripts de Build
1. `prebuild` : Nettoie les node_modules dupliqués
2. `build:frontend` : Build React dans src/frontend/build
3. `build:backend` : Placeholder pour le backend
4. `build:copy` : Copie src/frontend/build vers ./build
5. `build:vercel` : Script optimisé pour Vercel (frontend + copy)
6. `postbuild` : Validation du build avec scripts/validate-build.js

## Variables d'Environnement Vercel

Assurez-vous de configurer ces variables dans Vercel :
- `NODE_ENV=production`
- Toutes les variables de votre fichier .env

## Résolution des Problèmes

### Erreur "No Output Directory named 'build' found"
✅ Résolu par la création du script `build:copy`

### Erreur "Could not find a required file. Name: index.js"
✅ Résolu par la correction du .vercelignore (suppression de src/frontend/src)

### Warning Tailwind CSS content configuration
✅ Résolu par la mise à jour de tailwind.config.js

### Node_modules dupliqués
✅ Résolu par le script `clean:frontend-modules`

## Commandes Utiles

```bash
# Test du build local
npm run build

# Nettoyage des modules dupliqués
npm run clean:frontend-modules

# Build complet avec nettoyage
npm run prebuild && npm run build
```
