import 'package:curio/presentation/viewmodels/search_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:curio/l10n/app_localizations.dart';
import '../widgets/search/index.dart';
import '../widgets/common/index.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SearchViewmodel>();
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: vm.loading
          ? const LoadingView()
          : vm.error != null
          ? ErrorView(
              error: vm.error!,
              onRetry: () => vm.getArticlesByKeyword(),
            )
          : RefreshIndicator(
              onRefresh: () async => vm.getArticlesByKeyword(),
              color: theme.colorScheme.primary,
              child: CustomScrollView(
                slivers: [
                  // Header avec gradient
                  const SliverToBoxAdapter(child: CommonHeader()),

                  // Barre de recherche
                  SliverToBoxAdapter(child: CustomSearchBar(vm: vm)),

                  // Espace entre la barre de recherche et les résultats
                  const SliverToBoxAdapter(child: SizedBox(height: 32)),

                  // Résultats de recherche
                  if (vm.articles.isNotEmpty)
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final article = vm.articles[index];
                          return CompactArticleCard(article: article);
                        }, childCount: vm.articles.length),
                      ),
                    ),

                  if (vm.articles.isEmpty &&
                      vm.searchKeyword != null &&
                      vm.searchLoading == false)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off_rounded,
                                size: 64,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(height: 24),
                              Text(
                                l10n.noResultsFound,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSurface,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                l10n.noResultsFoundDescription,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: theme.colorScheme.onSurface.withValues(
                                    alpha: 0.6,
                                  ),
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  // Espace en bas
                  const SliverToBoxAdapter(child: SizedBox(height: 32)),
                ],
              ),
            ),
    );
  }
}
