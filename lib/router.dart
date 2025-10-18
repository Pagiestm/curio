import 'package:curio/l10n/app_localizations.dart';
import 'package:curio/presentation/screens/home_screen.dart';
import 'package:curio/presentation/screens/search_screen.dart';
import 'package:curio/presentation/screens/settings_screen.dart';
import 'package:curio/presentation/screens/article_details_screen.dart';
import 'package:curio/domain/entities/article.dart';
import 'package:curio/presentation/viewmodels/article_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final GoRoute homeRoute = GoRoute(
  path: '/',
  name: 'home',
  builder: (context, __) => HomeScreen(),
);

final GoRoute searchRoute = GoRoute(
  path: '/search',
  name: 'search',
  builder: (context, __) => SearchScreen(),
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

final GoRoute articleDetailsRoute = GoRoute(
  path: '/article',
  name: 'article_details',
  builder: (context, state) {
    if (state.extra == null || state.extra is! Article) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/');
      });
      return const SizedBox.shrink();
    }
    final article = state.extra as Article;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ArticleDetailsViewModel>().setArticle(article);
    });

    return const ArticleDetailsScreen();
  },
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
            currentIndex:
                {
                  '/': 0,
                  '/search': 1,
                  '/favorites': 2,
                  '/settings': 3,
                }[state.fullPath] ??
                0,
            onTap: (index) {
              if (index == 0) {
                context.go('/');
              }
              if (index == 1) {
                context.go('/search');
              }
              if (index == 2) {
                context.go('/favorites');
              }
              if (index == 3) {
                context.go('/settings');
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: l10n.homeTitle,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.search),
                label: l10n.search,
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
      routes: [
        homeRoute,
        favoritesRoute,
        settingsRoute,
        searchRoute,
        articleDetailsRoute,
      ],
    ),
  ],
);
