import 'package:curio/domain/entities/favorite.dart';
import 'package:curio/domain/entities/article.dart';
import 'package:curio/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FavoriteCard extends StatelessWidget {
  final Favorite favorite;
  final VoidCallback onDelete;
  final Function(ReactionType) onReactionChange;

  const FavoriteCard({
    super.key,
    required this.favorite,
    required this.onDelete,
    required this.onReactionChange,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        // Convertir le Favorite en Article pour la navigation
        final article = Article(
          id: favorite.articleId,
          title: favorite.articleTitle,
          description: favorite.articleDescription,
          category: '', // Catégorie non disponible dans Favorite
          content: '', // Contenu non disponible dans Favorite
          urlImage: favorite.articleUrlImage,
          author: favorite.articleAuthor,
          publishedAt: favorite.articlePublishedAt,
          language: 'fr', // Langue par défaut pour les favoris
        );
        context.go('/article', extra: article);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 2,
        color: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                favorite.articleUrlImage,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: Icon(
                      Icons.image_not_supported,
                      size: 48,
                      color: theme.colorScheme.onSurface.withOpacity(0.3),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titre
                  Text(
                    favorite.articleTitle,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Description
                  Text(
                    favorite.articleDescription,
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),

                  // Auteur et date
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 16,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        favorite.articleAuthor.isNotEmpty
                            ? favorite.articleAuthor
                            : AppLocalizations.of(context)!.unknownAuthor,
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Actions (Réactions + Supprimer)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Sélecteur de réaction
                      Row(
                        children: ReactionType.values.map((reaction) {
                          final isSelected = favorite.reaction == reaction;
                          return GestureDetector(
                            onTap: () => onReactionChange(reaction),
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? theme.colorScheme.primaryContainer
                                    : theme.colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(8),
                                border: isSelected
                                    ? Border.all(
                                        color: theme.colorScheme.primary,
                                        width: 2,
                                      )
                                    : null,
                              ),
                              child: Text(
                                reaction.emoji,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      // Bouton supprimer
                      IconButton(
                        onPressed: onDelete,
                        icon: Icon(
                          Icons.delete_outline,
                          color: theme.colorScheme.error,
                        ),
                        tooltip: 'Supprimer',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ), // Fin du GestureDetector
    );
  }
}
