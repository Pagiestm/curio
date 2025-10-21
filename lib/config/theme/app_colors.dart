import 'package:flutter/material.dart';

class AppColors {
  // Couleur principale
  static const Color primary = Color(0xFF722F37); // Bordeaux foncé
  static const Color primaryLight = Color(0xFF9D4E50);
  static const Color primaryDark = Color(0xFF5C1A1F);

  // Couleurs secondaires
  static const Color secondary = Color(0xFF757575); // Gris moyen
  static const Color secondaryLight = Color(0xFF9E9E9E);
  static const Color secondaryDark = Color(0xFF424242);

  // Couleurs d'accent
  static const Color accent = Color(0xFFF44336); // Rouge clair
  static const Color accentLight = Color(0xFFEF5350);
  static const Color accentDark = Color(0xFFC62828);

  // Couleurs de statut
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = accent;
  static const Color info = primary;

  // Couleurs neutres
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFF9FAFB);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey600 = Color(0xFF4B5563);
  static const Color grey700 = Color(0xFF374151);
  static const Color grey800 = Color(0xFF1F2937);
  static const Color grey900 = Color(0xFF111827);

  // Backgrounds
  static const Color background = grey50;
  static const Color surface = white;
  static const Color surfaceVariant = grey100;

  // Borders
  static const Color border = grey200;
  static const Color borderLight = grey100;

  // Textes
  static const Color textPrimary = grey900;
  static const Color textSecondary = grey600;
  static const Color textTertiary = grey400;
  static const Color textOnPrimary = white;
  static const Color textOnSecondary = white;
}
