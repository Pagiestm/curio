import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/settings_viewmodel.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/settings/index.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settingsVM = context.watch<SettingsViewModel>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SettingsHeader(),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Section Langue
                SettingsSectionHeader(title: l10n.language),
                const SizedBox(height: 12),
                LanguageSelectionCard(
                  selectedLanguageCode: settingsVM.locale.languageCode,
                  onLanguageChanged: settingsVM.changeLocale,
                ),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
