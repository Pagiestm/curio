import 'package:flutter/material.dart';
import 'package:curio/config/theme/index.dart';
import 'package:curio/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/article.dart';

class CompactArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback? onTap;

  const CompactArticleCard({
    super.key,
    required this.article,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: onTap ?? () => context.go('/article', extra: article),
      child: Container(
        height: 120,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Thumbnail with fixed aspect ratio and loading/error handling
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: SizedBox(
                width: 120,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: article.urlImage.isNotEmpty
                      ? Image.network(
                          article.urlImage,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: AppColors.grey100,
                              child: const Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppColors.grey100,
                              child: Center(
                                child: Icon(
                                  Icons.broken_image,
                                  color: AppColors.grey400,
                                  size: 36,
                                ),
                              ),
                            );
                          },
                        )
                      : Container(
                          color: AppColors.grey100,
                          child: Center(
                            child: Icon(
                              Icons.article_outlined,
                              color: AppColors.grey400,
                              size: 36,
                            ),
                          ),
                        ),
                ),
              ),
            ),

            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Category chip
                    if (article.category.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          article.category.toUpperCase(),
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    const SizedBox(height: 6),

                    // Title
                    Text(
                      article.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Read more indicator
                    Row(
                      children: [
                        Text(
                          l10n.readMore,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward,
                          size: 12,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}