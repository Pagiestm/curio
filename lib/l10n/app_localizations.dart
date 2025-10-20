import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// The conventional newborn programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Hello World'**
  String get helloWorld;

  /// Home page title
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// Label for the favorites section
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// Settings page title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Settings page subtitle
  ///
  /// In en, this message translates to:
  /// **'Personalization'**
  String get settingsSubtitle;

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Curio News'**
  String get appTitle;

  /// Home page subtitle
  ///
  /// In en, this message translates to:
  /// **'Latest news'**
  String get homeSubtitle;

  /// Search page subtitle
  ///
  /// In en, this message translates to:
  /// **'Search for news articles'**
  String get searchSubtitle;

  /// Favorites page subtitle
  ///
  /// In en, this message translates to:
  /// **'Your favorite articles'**
  String get favoriteSubtitle;

  /// Application description
  ///
  /// In en, this message translates to:
  /// **'Your modern news app to stay informed in real-time about world events.'**
  String get appDescription;

  /// Badge for featured article
  ///
  /// In en, this message translates to:
  /// **'🔥 FEATURED'**
  String get featuredBadge;

  /// Section title for latest news
  ///
  /// In en, this message translates to:
  /// **'Latest news'**
  String get latestNews;

  /// Subtitle for latest news section
  ///
  /// In en, this message translates to:
  /// **'Stay informed in real time'**
  String get latestNewsSubtitle;

  /// See all button text
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// Read more link text
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get readMore;

  /// No articles title
  ///
  /// In en, this message translates to:
  /// **'No articles'**
  String get noArticles;

  /// No articles message
  ///
  /// In en, this message translates to:
  /// **'No articles are available at the moment'**
  String get noArticlesMessage;

  /// Error title
  ///
  /// In en, this message translates to:
  /// **'Oops!'**
  String get error;

  /// Retry button text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Loading indicator text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Language section title
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// About section title
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Summary section title
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// Theme section title
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightTheme;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkTheme;

  /// Search section title
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Search bar hint text
  ///
  /// In en, this message translates to:
  /// **'Search articles...'**
  String get searchHint;

  /// No articles found message
  ///
  /// In en, this message translates to:
  /// **'No articles found'**
  String get noResultsFound;

  /// No results found detailed message
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find any articles matching your search. Try different keywords!'**
  String get noResultsFoundDescription;

  /// No favorites title
  ///
  /// In en, this message translates to:
  /// **'No favorites'**
  String get noFavoritesTitle;

  /// No favorites detailed message
  ///
  /// In en, this message translates to:
  /// **'You haven\'t added any articles to your favorites yet. Start exploring and save your favorite articles!'**
  String get noFavoritesDescription;

  /// Filter articles by reaction type in favorites section
  ///
  /// In en, this message translates to:
  /// **'Filter by Reaction'**
  String get filterByReaction;

  /// Sad reaction
  ///
  /// In en, this message translates to:
  /// **'Sad'**
  String get sad;

  /// Angry reaction
  ///
  /// In en, this message translates to:
  /// **'Angry'**
  String get angry;

  /// Happy reaction
  ///
  /// In en, this message translates to:
  /// **'Happy'**
  String get happy;

  /// Funny reaction
  ///
  /// In en, this message translates to:
  /// **'Funny'**
  String get funny;

  /// Tooltip for removing an article from favorites
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get removeFromFavorites;

  /// Title for choosing a reaction dialog
  ///
  /// In en, this message translates to:
  /// **'Choose a reaction'**
  String get chooseReaction;

  /// Label for articles with unknown author
  ///
  /// In en, this message translates to:
  /// **'Unknown Author'**
  String get unknownAuthor;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
