import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/article.dart';
import '../favorites/add_to_favorite_button.dart';

class ArticleDetailsHeader extends StatelessWidget {
  final Article article;

  const ArticleDetailsHeader({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 350,
      pinned: true,
      stretch: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          shape: BoxShape.circle,
          boxShadow: Theme.of(context).brightness == Brightness.dark
              ? null
              : [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSurface,
            size: 24,
          ),
          onPressed: () => context.go('/'),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            shape: BoxShape.circle,
            boxShadow: Theme.of(context).brightness == Brightness.dark
                ? null
                : [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).shadowColor.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: AddToFavoriteButton(article: article),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Image de fond
            article.urlImage.isNotEmpty
                ? Image.network(
                    article.urlImage,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                            strokeWidth: 3,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                              Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHighest
                                  .withValues(alpha: 0.8),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.article_outlined,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                            size: 80,
                          ),
                        ),
                      );
                    },
                  )
                : Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.1),
                          Theme.of(
                            context,
                          ).colorScheme.primaryContainer.withValues(alpha: 0.1),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.article_outlined,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        size: 80,
                      ),
                    ),
                  ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.8),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
