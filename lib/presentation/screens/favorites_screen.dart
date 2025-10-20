import 'package:curio/presentation/viewmodels/favorite_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:curio/l10n/app_localizations.dart';
import '../widgets/common/index.dart';
import '../widgets/favorites/index.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoriteViewmodel>().loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FavoriteViewmodel>();
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: vm.loading
          ? const LoadingView()
          : vm.error != null
          ? ErrorView(error: vm.error!, onRetry: () => vm.loadFavorites())
          : RefreshIndicator(
              onRefresh: () async => vm.loadFavorites(),
              color: theme.colorScheme.primary,
              child: CustomScrollView(
                slivers: [
                  // Header avec gradient
                  const SliverToBoxAdapter(child: CommonHeader()),

                  // Filtres par réaction
                  SliverToBoxAdapter(
                    child: ReactionFilter(
                      selectedReaction: vm.filterReaction,
                      onReactionSelected: (reaction) {
                        vm.setFilterReaction(reaction);
                      },
                      onClearFilter: () {
                        vm.clearFilter();
                      },
                    ),
                  ),

                  // Espace
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),

                  // Liste des favoris
                  if (vm.favorites.isNotEmpty)
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final favorite = vm.favorites[index];
                          return FavoriteCard(
                            favorite: favorite,
                            onDelete: () {
                              vm.removeFavorite(favorite.id!);
                            },
                            onReactionChange: (newReaction) {
                              vm.updateFavoriteReaction(favorite, newReaction);
                            },
                          );
                        }, childCount: vm.favorites.length),
                      ),
                    ),

                  // Message vide
                  if (vm.favorites.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite_border_rounded,
                                size: 64,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(height: 24),
                              Text(
                                l10n.noFavoritesTitle,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSurface,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                l10n.noFavoritesDescription,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.6),
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
