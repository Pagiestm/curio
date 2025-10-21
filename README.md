# Curio 📱

Application mobile pour découvrir et gérer ses actualités favorites.

## 🎓 Contexte Scolaire

Ce projet a été réalisé dans le cadre d'un module de développement mobile Flutter. L'objectif était de créer une application respectant des contraintes techniques strictes tout en développant des compétences avancées en développement mobile.

### 📋 Contraintes Techniques Respectées

**Architecture obligatoire :**
- ✅ **Flutter** comme framework principal
- ✅ **Clean Architecture** (Domain, Data, Presentation)
- ✅ **MVVM** pattern
- ✅ Optimisation mobile (non Web)

**Communication :**
- ✅ **API REST** (GNews API)

**Fonctionnalités choisies (3 minimum) :**
- ✅ **Cache local** avec SQLite
- ✅ **Gestion d'erreurs robuste** avec retry automatique
- ✅ **Internationalisation (i18n)** - Français et Anglais
- ✅ **Navigation complexe** avec Go Router (routes nommées, guards)

### 🎯 Fonctionnalités Minimales Implémentées

- ✅ **4-5 écrans** avec navigation complexe (Accueil, Recherche, Détails, Favoris, Paramètres)
- ✅ **CRUD complet** sur les favoris d'articles
- ✅ **Recherche et filtrage** des articles par mots-clés
- ✅ **États de chargement/erreur** avec UI appropriée
- ✅ **Interface responsive** (portrait/paysage)

### 📊 Qualité du Code

- ✅ **Analyse statique** : `dart analyze` sans warnings
- ✅ **Formatage** : `dart format` automatique
- ✅ **CI/CD** : Workflows GitHub Actions
- ✅ **Clean Code** : Séparation claire des responsabilités

## 👥 Membres du Groupe

- **Développeurs** : Théotime Pagies & Lucas Bertaud

## 📋 Description du Projet

**Curio** est une application mobile Flutter qui permet aux utilisateurs de :

- 📰 **Découvrir les actualités** : Consulter les derniers articles depuis diverses sources
- � **Rechercher des articles** : Trouver des informations par mots-clés
- ❤️ **Gérer ses favoris** : Sauvegarder et organiser ses articles préférés avec un système de réactions émotionnelles
- 🌍 **Naviguer en multilingue** : Interface disponible en français et anglais
- 🌓 **Personnaliser l'expérience** : Choisir entre thème clair et sombre
- 💾 **Profiter d'une expérience fluide** : Cache local pour éviter les chargements répétés

## 🏗️ Architecture Technique Détaillée

### 🏛️ Clean Architecture Implémentée

```
lib/
├── config/           # ⚙️ Configuration (thèmes, logger, environnement)
├── data/            # 💾 Couche données - Implémentations concrètes
│   ├── datasources/ # 🔌 Sources de données (API, SQLite)
│   └── repositories/# 📦 Implémentations des repositories
├── domain/          # 🎯 Couche domaine - Règles métier
│   ├── entities/    # 📋 Entités métier (Article, Favorite)
│   ├── repositories/# 🔄 Interfaces des repositories
│   └── services/    # 🛠️ Services métier
└── presentation/    # 🎨 Couche présentation - UI/UX
    ├── screens/     # 📱 Écrans de l'application
    ├── viewmodels/  # 🎮 Logique de présentation (MVVM)
    └── widgets/     # 🧩 Composants réutilisables
```

### 🔧 Fonctionnalités Techniques Implémentées

#### 1. 📱 Cache Local avec SQLite
- **Base de données** : SQLite via `sqflite` package
- **Entités cachées** : Articles et favoris
- **Stratégie** : Cache-first avec fallback API
- **Optimisation** : Évite les appels répétés à l'API

#### 2. 🚨 Gestion d'Erreurs Robuste
- **Types d'erreurs** : Réseau, API, parsing, cache
- **UI d'erreur** : Écrans dédiés avec retry automatique
- **Logging** : Système de logs structuré
- **Recovery** : Tentatives automatiques de récupération

#### 3. 🌍 Internationalisation (i18n)
- **Langues supportées** : Français 🇫🇷 et Anglais 🇬🇧
- **Framework** : `flutter_localizations` + `intl`
- **Fichiers ARB** : `app_fr.arb`, `app_en.arb`
- **Génération** : `flutter gen-l10n` automatique

#### 4. 🧭 Navigation Complexe avec Go Router
- **Router** : `go_router` pour routing déclaratif
- **Routes nommées** : Navigation type-safe
- **Guards** : Protection des routes sensibles
- **Transitions** : Animations fluides entre écrans

## 🔧 Technologies Utilisées

- **Framework** : Flutter 3.35.6
- **Langage** : Dart 3.9.2
- **Base de données** : SQLite (via sqflite)
- **Gestion d'état** : Provider
- **API HTTP** : http package
- **Internationalisation** : flutter_localizations + intl
- **Variables d'environnement** : flutter_dotenv
- **Logging** : logging package
- **CI/CD** : GitHub Actions

## 🌐 API Utilisée

L'application utilise **GNews API** pour récupérer les actualités :

- **Base URL** : `https://gnews.io/`
- **Endpoints utilisés** :
  - `top-headlines` : Articles principaux
  - `search` : Recherche par mots-clés
- **Paramètres** : country, q (query), apiKey
- **Documentation** : [GNews API Docs](https://docs.gnews.io/)

### ⚙️ Configuration API

1. Créer un compte sur [GNews](https://gnews.io/)
2. Obtenir une clé API
3. Créer un fichier `.env` à la racine du projet :
   ```
   GNEWS_API_TOKEN=votre_clé_api_ici
   ```

## 🚀 Installation et Configuration

### Prérequis

- Flutter 3.35.6 ou supérieur
- Dart 3.9.2 ou supérieur
- Android Studio / VS Code avec extensions Flutter
- JDK 11+ (pour Android)

### Installation

1. **Cloner le repository**
   ```bash
   git clone https://github.com/Pagiestm/curio.git
   cd curio
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Configurer l'environnement**
   ```bash
   cp .env.example .env
   # Éditer .env avec votre clé API GNews
   ```

4. **Générer les fichiers de localisation**
   ```bash
   flutter gen-l10n
   ```

5. **Lancer l'application**
   ```bash
   flutter run
   ```

### 🔧 Scripts Disponibles

- `flutter analyze` : Analyse statique du code
- `dart format lib/` : Formatage automatique du code
- `flutter test` : Exécution des tests (si présents)

## 🔄 Workflows CI/CD

L'application utilise GitHub Actions pour l'intégration continue :

### 📋 Workflow Principal (`.github/workflows/flutter-ci.yml`)

**Déclencheurs** :
- Push sur la branche `develop`
- Pull requests vers `develop`

**Étapes** :
1. **Checkout** : Récupération du code
2. **Setup Flutter** : Installation de Flutter 3.35.6
3. **Analytics** : Désactivation des analytics Flutter
4. **Création .env** : Fichier temporaire pour les tests CI
5. **Dependencies** : Installation des packages
6. **Analyze** : Analyse statique du code
7. **Format** : Vérification du formatage

### 🎯 Qualité du Code

- **Analyse statique** : `flutter analyze` - vérification des erreurs et warnings
- **Formatage** : `dart format` - style de code cohérent
- **Linting** : flutter_lints - règles de qualité du code

## 📱 Fonctionnalités Détaillées

### 🏠 Écran d'accueil
- Articles principaux en vedette
- Navigation par catégories
- Interface Material Design 3

### 🔍 Recherche
- Recherche en temps réel
- Filtres par date/source
- Historique des recherches

### ❤️ Favoris
- Sauvegarde d'articles
- Système de réactions émotionnelles
- Organisation par catégories

### ⚙️ Paramètres
- Changement de thème (clair/sombre)
- Sélection de langue (Français/Anglais)

## 🎨 Design System

### Couleurs
- **Primaire** : Bordeaux (#722F37)
- **Accent** : Rouge (#F44336)
- **Neutres** : Palette de gris moderne

### Typographie
- Police système avec optimisation Material Design
- Hiérarchie claire des tailles et poids

### Composants
- Cards avec ombres douces
- Boutons arrondis cohérents
- Animations fluides

## 🏆 Défis Techniques & Solutions

### 🔍 Problèmes Rencontrés

1. **🤖 Migration Flutter 3.9** : API `withOpacity` dépréciée
   - **Solution** : Migration vers `withValues(alpha: ...)` + CI pour validation

2. **🎨 Cohérence des couleurs** : Couleurs violettes hardcodées dans le thème
   - **Solution** : Palette unifiée avec `AppColors` (bordeaux/rouge)

3. **⚡ Performance du cache** : Appels API répétés
   - **Solution** : Stratégie cache-first avec SQLite

4. **🌐 CI/CD complexe** : Variables d'environnement en CI
   - **Solution** : Création automatique de `.env` factice

5. **🔄 Gestion d'état complexe** : Synchronisation UI/ données
   - **Solution** : Provider + MVVM pattern

### 📈 Compétences Acquises

- **🏗️ Clean Architecture** : Structuration robuste des applications
- **💾 SQLite/Flutter** : Persistence de données mobile
- **🌐 APIs REST** : Communication client-serveur
- **🎨 Material Design 3** : UI/UX moderne et responsive
- **🔄 CI/CD** : Automatisation qualité et déploiement
- **🛠️ Debugging avancé** : Outils Flutter pour optimisation

## 🎯 Évaluation des Contraintes

| Contrainte | Status | Implémentation |
|------------|--------|----------------|
| Flutter | ✅ | Framework principal |
| Clean Architecture | ✅ | 3 couches séparées |
| MVVM | ✅ | ViewModels + Provider |
| API REST | ✅ | GNews API |
| Cache SQLite | ✅ | Articles + favoris |
| Gestion erreurs | ✅ | Retry + UI d'erreur |
| i18n (2 langues) | ✅ | FR + EN |
| Navigation complexe | ✅ | Go Router |
| 4-5 écrans | ✅ | 5 écrans principaux |
| CRUD complet | ✅ | Favoris |
| Recherche/filtrage | ✅ | Par mots-clés |
| États loading/erreur | ✅ | UI complète |
| Responsive | ✅ | Portrait/paysage |
| dart analyze | ✅ | 0 warnings |
| GitHub README | ✅ | Documentation complète |

## � Points Forts du Projet

- **📚 Architecture scalable** : Facilite les évolutions futures
- **🔧 Code maintenable** : Séparation claire des responsabilités
- **🎨 UI/UX moderne** : Material Design 3 cohérent
- **⚡ Performance optimisée** : Cache + lazy loading
- **🛡️ Robustesse** : Gestion d'erreurs complète
- **🌍 Accessibilité** : Multilingue + thèmes
- **🔄 CI/CD automatisé** : Qualité garantie

## 🎓 Conclusion Pédagogique

Ce projet démontre l'application pratique des concepts avancés de développement mobile Flutter dans un contexte éducatif. Il valide la maîtrise des patterns architecturaux modernes et des bonnes pratiques de développement.

**🎯 Objectifs pédagogiques atteints :**
- ✅ Compréhension de Clean Architecture
- ✅ Maîtrise des APIs REST
- ✅ Gestion d'état avancée
- ✅ Qualité et maintenabilité du code
- ✅ CI/CD et automatisation
- ✅ UX/UI moderne et accessible

**💡 Apprentissages clés :**
- L'importance de l'architecture pour la scalabilité
- La robustesse apportée par la gestion d'erreurs
- L'impact de l'internationalisation sur l'adoption
- La valeur de l'automatisation pour la qualité

---

## 📄 Licence

**Projet éducatif** - Réalisé dans le cadre d'un module de développement mobile Flutter.

**Note :** Ce projet utilise l'API GNews. Veuillez respecter leurs conditions d'utilisation et obtenir votre propre clé API pour le développement.

---
