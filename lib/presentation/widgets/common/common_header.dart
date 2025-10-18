import 'package:curio/config/theme/index.dart';
import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class CommonHeader extends StatelessWidget {
  const CommonHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // subtitle by route localizationString? subtitle;
    String? subtitle;
    final routeName = ModalRoute.of(context)?.settings.name;
    switch (routeName) {
      case 'home':
        subtitle = l10n.homeSubtitle;
        break;
      case 'search':
        subtitle = l10n.searchSubtitle;
        break;
      // Add more cases for other routes as needed
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo et titre style journal
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 28,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [AppColors.primary, AppColors.primaryLight],
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Curio',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.onSurface,
                          letterSpacing: -1.5,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      subtitle?.toUpperCase() ?? '',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Date badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _getWeekday(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatDate(),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getWeekday() {
    final now = DateTime.now();
    final weekdays = ['LUN', 'MAR', 'MER', 'JEU', 'VEN', 'SAM', 'DIM'];
    return weekdays[now.weekday - 1];
  }

  String _formatDate() {
    final now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
  }
}
