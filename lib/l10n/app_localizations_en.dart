// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World';

  @override
  String get homeTitle => 'Home';

  @override
  String get favorites => 'Favorites';

  @override
  String get settings => 'Settings';

  @override
  String get settingsSubtitle => 'Personalization';

  @override
  String get appTitle => 'Curio News';

  @override
  String get appSubtitle => 'Latest news';

  @override
  String get appDescription =>
      'Your modern news app to stay informed in real-time about world events.';

  @override
  String get featuredBadge => '🔥 FEATURED';

  @override
  String get latestNews => 'Latest news';

  @override
  String get latestNewsSubtitle => 'Stay informed in real time';

  @override
  String get seeAll => 'See all';

  @override
  String get readMore => 'Read more';

  @override
  String get noArticles => 'No articles';

  @override
  String get noArticlesMessage => 'No articles are available at the moment';

  @override
  String get error => 'Oops!';

  @override
  String get retry => 'Retry';

  @override
  String get loading => 'Loading...';

  @override
  String get language => 'Language';

  @override
  String get about => 'About';
}
