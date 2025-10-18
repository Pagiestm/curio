import 'package:flutter/material.dart';
import 'package:curio/config/theme/index.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/article.dart';

class FeaturedArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback? onTap;

  const FeaturedArticleCard({
    super.key,
    required this.article,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => context.go('/article', extra: article),
      child: Container(
        height: 400,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image with placeholder, fade-in and error handling
              AspectRatio(
                aspectRatio: 16 / 9,
                child: article.urlImage.isNotEmpty
                    ? Image.network(
                        article.urlImage,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: AppColors.grey200,
                            child: const Center(
                              child: SizedBox(
                                width: 36,
                                height: 36,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppColors.grey200,
                          child: Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 64,
                              color: AppColors.grey400,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        color: AppColors.grey200,
                        child: Center(
                          child: Icon(
                            Icons.article_outlined,
                            size: 64,
                            color: AppColors.grey400,
                          ),
                        ),
                      ),
              ),

              // Professional gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.7),
                    ],
                    stops: const [0.3, 0.6, 1.0],
                  ),
                ),
              ),

              // Content
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Category Badge
                      if (article.category.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            article.category.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      const SizedBox(height: 16),

                      // Title
                      Text(
                        article.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.25,
                          letterSpacing: -0.5,
                          shadows: [
                            Shadow(
                              color: Colors.black38,
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),

                      // Description
                      if (article.description.isNotEmpty)
                        Text(
                          article.description,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.95),
                            fontSize: 15,
                            height: 1.4,
                            fontWeight: FontWeight.w400,
                            shadows: const [
                              Shadow(
                                color: Colors.black26,
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
