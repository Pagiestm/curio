import 'package:flutter/material.dart';
import 'package:curio/config/theme/index.dart';
import 'package:curio/l10n/app_localizations.dart';
import '../../../domain/entities/article.dart';

class ArticleDetailsContent extends StatelessWidget {
  final Article article;

  const ArticleDetailsContent({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre de l'article
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: AppColors.primary,
                      width: 4,
                    ),
                  ),
                ),
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  article.title,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                    letterSpacing: -1.2,
                    height: 1.1,
                    shadows: [
                      Shadow(
                        offset: const Offset(0, 1),
                        blurRadius: 2,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Catégorie et métadonnées
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  // Catégorie
                  if (article.category.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary,
                            AppColors.primaryLight,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        article.category.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),

                  // Date
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.grey100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _formatDate(article.publishedAt),
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Auteur
            if (article.author.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.2),
                            AppColors.primaryLight.withOpacity(0.2),
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        color: AppColors.primary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        article.author,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 24),

            // Séparateur
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AppColors.grey200,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Titre de la section résumé
            if (article.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  AppLocalizations.of(context)!.summary,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
              ),

            if (article.description.isNotEmpty)
              const SizedBox(height: 12),

            // Description en relief
            if (article.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    article.description,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                      height: 1.6,
                      letterSpacing: -0.1,
                    ),
                  ),
                ),
              ),

            if (article.description.isNotEmpty)
              const SizedBox(height: 32),

            // Contenu de l'article
            if (article.content.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _cleanContent(article.content),
                      style: TextStyle(
                        fontSize: 17,
                        color: AppColors.textPrimary,
                        height: 1.8,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.1,
                      ),
                    ),
                    
                    // Afficher un message si le contenu semble tronqué
                    if (_isTruncated(article.content))
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.grey50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.grey200,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: AppColors.textSecondary,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "Le contenu complet n'est pas disponible via l'API",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

            const SizedBox(height: 40),

            // Footer avec séparateur
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.grey200,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return "Aujourd'hui";
    } else if (difference.inDays == 1) {
      return "Hier";
    } else if (difference.inDays < 7) {
      return "Il y a ${difference.inDays} jours";
    } else {
      return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
    }
  }

  String _cleanContent(String content) {
    // Supprimer les marqueurs de troncature de NewsAPI comme "[+17712 chars]"
    final cleaned = content.replaceAll(RegExp(r'\[\+\d+ chars\]'), '');
    
    // Si le contenu est très court après nettoyage, on peut ajouter un message
    if (cleaned.trim().isEmpty) {
      return "Le contenu complet de cet article n'est pas disponible. Visitez la source pour lire l'article complet.";
    }
    
    return cleaned.trim();
  }

  bool _isTruncated(String content) {
    // Vérifier si le contenu contient le marqueur de troncature de NewsAPI
    return content.contains(RegExp(r'\[\+\d+ chars\]'));
  }
}