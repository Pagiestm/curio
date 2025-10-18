// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get helloWorld => 'Bonjour le monde';

  @override
  String get homeTitle => 'Accueil';

  @override
  String get favorites => 'Favoris';

  @override
  String get settings => 'Paramètres';

  @override
  String get settingsSubtitle => 'Personnalisation';

  @override
  String get appTitle => 'Curio News';

  @override
  String get appSubtitle => 'Les dernières actualités';

  @override
  String get appDescription =>
      'Votre application de news moderne pour rester informé en temps réel sur les actualités du monde entier.';

  @override
  String get featuredBadge => '🔥 À LA UNE';

  @override
  String get latestNews => 'Dernières nouvelles';

  @override
  String get latestNewsSubtitle => 'Restez informé en temps réel';

  @override
  String get seeAll => 'Voir tout';

  @override
  String get readMore => 'Lire plus';

  @override
  String get noArticles => 'Aucun article';

  @override
  String get noArticlesMessage =>
      'Aucun article n\'est disponible pour le moment';

  @override
  String get error => 'Oups !';

  @override
  String get retry => 'Réessayer';

  @override
  String get loading => 'Chargement...';

  @override
  String get language => 'Langue';

  @override
  String get about => 'À propos';

  @override
  String get summary => 'Résumé';
}
