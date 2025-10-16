import 'package:curio/data/datasources/article_remote_datasource.dart';
import 'package:curio/data/repositories/article_repository_impl.dart';
import 'package:curio/domain/repositories/article_repository.dart';
import 'package:curio/domain/services/article_service.dart';
import 'package:curio/presentation/viewmodels/article_viewmodel.dart';
import 'package:curio/presentation/viewmodels/settings_viewmodel.dart';
import 'package:curio/router.dart';
import 'package:curio/config/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Data Sources
        Provider<ArticleRemoteDataSource>(
          create: (_) => ArticleRemoteDataSourceImpl(http.Client()),
        ),
        // Repository
        ProxyProvider<ArticleRemoteDataSource, ArticleRepository>(
          update: (_, remoteDataSource, __) =>
              ArticleRepositoryImpl(remoteDataSource),
        ),
        // Domain Service
        ProxyProvider<ArticleRepository, ArticleService>(
          update: (_, repository, __) => ArticleService(repository),
        ),
        // ViewModels
        ChangeNotifierProvider(
          create: (c) => ArticleViewModel(c.read<ArticleService>()),
        ),
        ChangeNotifierProvider(
          create: (_) => SettingsViewModel(),
        ),
      ],
      child: Consumer<SettingsViewModel>(
        builder: (context, settingsViewModel, child) {
          return MaterialApp.router(
            title: 'Curio',
            locale: settingsViewModel.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: AppTheme.lightTheme,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
