import 'package:curio/l10n/app_localizations.dart';
import 'package:curio/presentation/screens/home_screen.dart';
import 'package:curio/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRoute homeRoute = GoRoute(
  path: '/',
  name: 'home',
  builder: (context, __) =>
      HomeScreen(),
);

final GoRoute favoritesRoute = GoRoute(
  path: '/favorites',
  name: 'favorites',
  builder: (context, __) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.favorites)),
      body: const Center(child: Text('Favorites Screen')),
    );
  },
);

final GoRoute settingsRoute = GoRoute(
  path: '/settings',
  name: 'settings',
  builder: (context, __) => const SettingsScreen(),
);

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        final l10n = AppLocalizations.of(context)!;
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: {
              '/': 0,
              '/favorites': 1,
              '/settings': 2,
            }[state.fullPath]!,
            onTap: (index) {
              if (index == 0) {
                context.go('/');
              }
              if (index == 1) {
                context.go('/favorites');
              }
              if (index == 2) {
                context.go('/settings');
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: l10n.homeTitle,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.favorite),
                label: l10n.favorites,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: l10n.settings,
              ),
            ],
          ),
        );
      },
      routes: [homeRoute, favoritesRoute, settingsRoute],
    ),
  ],
);
