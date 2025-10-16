import 'package:curio/l10n/app_localizations.dart';
import 'package:curio/presentation/screens/home_screen.dart';
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
      appBar: AppBar(title: const Text('Favorites')),
      body: const Center(child: Text('Favorites Screen')),
    );
  },
);

final GoRoute settingsRoute = GoRoute(
  path: '/settings',
  name: 'settings',
  builder: (_, __) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings Screen')),
    );
  },
);

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    ShellRoute(
      builder: (context, state, child) => Scaffold(
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
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
      routes: [homeRoute, favoritesRoute, settingsRoute],
    ),
  ],
);
