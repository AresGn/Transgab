# 🔧 Guide de Configuration Neon - Résolution des Problèmes

## 🚨 Problème Identifié

Vous obtenez cette erreur car `psql` essaie de se connecter à PostgreSQL **local** au lieu de **Neon cloud**.

```
psql : erreur : connexion au serveur « localhost » (::1), port 5432 échouée : 
FATAL : authentification par mot de passe échouée pour l'utilisateur « Arès GNIMAGNON »
```

## ✅ Solution Étape par Étape

### **Étape 1 : Vérifier votre configuration Neon**

1. **Connectez-vous à Neon Console**
   - Allez sur https://console.neon.tech/
   - Connectez-vous avec votre compte

2. **Vérifiez votre projet**
   - Assurez-vous que votre projet "train-reservation-gabon" existe
   - Cliquez sur votre projet

3. **Copiez la vraie chaîne de connexion**
   - Dans le dashboard, cliquez sur "Connection Details"
   - Copiez la "Connection string" complète
   - Elle ressemble à : `postgresql://username:password@ep-xxx.region.aws.neon.tech/dbname?sslmode=require`

### **Étape 2 : Mettre à jour votre fichier .env**

1. **Ouvrez le fichier `.env`** dans votre éditeur
2. **Remplacez la ligne 25** par votre vraie chaîne de connexion Neon :

```env
# REMPLACEZ CETTE LIGNE :
DATABASE_URL=postgresql://train-reservation-gabon_owner:npg_cj8zi4lUOodr@ep-autumn-snow-a86gnu61-pooler.eastus2.azure.neon.tech/train-reservation-gabon?sslmode=require

# PAR VOTRE VRAIE CHAÎNE NEON :
DATABASE_URL=postgresql://VOTRE_USERNAME:VOTRE_PASSWORD@VOTRE_HOST/VOTRE_DB?sslmode=require
```

### **Étape 3 : Tester la connexion**

```bash
# Testez d'abord la connexion
npm run test:neon
```

Si ça fonctionne, vous verrez :
```
✅ Connexion réussie !
📊 Informations de la base de données...
```

### **Étape 4 : Déployer le schéma**

```bash
# Maintenant déployez le schéma complet
npm run setup:neon
```

Vous devriez voir :
```
🚀 Démarrage du déploiement...
✅ Connexion réussie !
✅ Schéma déployé avec succès !
📈 Statistiques de déploiement:
   Gares créées: 22
   Types de trains: 2
   Horaires configurés: 8
   Tarifs configurés: 14
```

## 🔍 Diagnostic des Erreurs Courantes

### **Erreur d'authentification (28P01)**
```
🔐 Erreur d'authentification - Vérifiez vos identifiants Neon
```
**Solution :** Vérifiez username:password dans DATABASE_URL

### **Base de données non trouvée (3D000)**
```
🗄️ Base de données non trouvée - Vérifiez le nom de la base
```
**Solution :** Vérifiez le nom de la base dans DATABASE_URL

### **Problème de réseau (ENOTFOUND)**
```
🌐 Problème de réseau - Vérifiez votre connexion internet
```
**Solution :** Vérifiez votre connexion internet et l'URL Neon

## 🆘 Si Ça Ne Fonctionne Toujours Pas

1. **Vérifiez que votre projet Neon est actif**
   - Connectez-vous à https://console.neon.tech/
   - Vérifiez que votre projet n'est pas en pause

2. **Créez un nouveau projet Neon si nécessaire**
   - Nom : `train-reservation-gabon`
   - Région : `US East (Ohio)` ou la plus proche
   - PostgreSQL version : `15`

3. **Testez manuellement avec psql (optionnel)**
   ```bash
   # Remplacez par votre vraie URL
   psql "postgresql://username:password@host/db?sslmode=require" -c "SELECT version();"
   ```

## 📞 Support

Si vous avez encore des problèmes :
1. Vérifiez que DATABASE_URL est correcte dans .env
2. Assurez-vous que votre projet Neon est actif
3. Contactez le support Neon si nécessaire

---

**🎉 Une fois configuré, votre base de données sera prête pour le développement !**
