import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:curio/l10n/app_localizations.dart';
import '../viewmodels/article_viewmodel.dart';
import '../widgets/home/index.dart';
import '../widgets/common/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ArticleViewModel>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: vm.loading
          ? const LoadingView()
          : vm.error != null
              ? ErrorView(
                  error: vm.error!,
                  onRetry: () => vm.getArticles(),
                )
              : vm.articles.isEmpty
                  ? const EmptyView()
                  : RefreshIndicator(
                      onRefresh: () async => vm.getArticles(),
                      color: Theme.of(context).primaryColor,
                      child: CustomScrollView(
                        slivers: [
                          // Header avec gradient
                          const SliverToBoxAdapter(
                            child: HomeHeader(),
                          ),

                          // Article en vedette (premier article)
                          if (vm.articles.isNotEmpty)
                            SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  const SizedBox(height: 16),
                                  FeaturedArticleCard(
                                    article: vm.articles.first,
                                  ),
                                ],
                              ),
                            ),

                          // Section "Dernières nouvelles"
                          if (vm.articles.length > 1)
                            SliverToBoxAdapter(
                              child: SectionHeader(
                                title: l10n.latestNews,
                                subtitle: l10n.latestNewsSubtitle,
                              ),
                            ),

                          // Liste des autres articles
                          if (vm.articles.length > 1)
                            SliverPadding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    final article = vm.articles[index + 1];
                                    return CompactArticleCard(
                                      article: article,
                                    );
                                  },
                                  childCount: vm.articles.length - 1,
                                ),
                              ),
                            ),

                          // Espace en bas
                          const SliverToBoxAdapter(
                            child: SizedBox(height: 32),
                          ),
                        ],
                      ),
                    ),
    );
  }
}
