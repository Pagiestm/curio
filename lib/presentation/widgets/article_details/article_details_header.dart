import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:curio/config/theme/index.dart';
import '../../../domain/entities/article.dart';

class ArticleDetailsHeader extends StatelessWidget {
  final Article article;

  const ArticleDetailsHeader({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 350,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.textPrimary,
            size: 24,
          ),
          onPressed: () => context.go('/'),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(
              Icons.bookmark_border,
              color: AppColors.textPrimary,
              size: 24,
            ),
            onPressed: () {
              // TODO: Implémenter les favoris
            },
          ),
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
                        color: AppColors.grey100,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
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
                              AppColors.grey100,
                              AppColors.grey200,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.article_outlined,
                            color: AppColors.grey400,
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
                          AppColors.primary.withOpacity(0.1),
                          AppColors.primaryLight.withOpacity(0.1),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.article_outlined,
                        color: AppColors.grey400,
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
                      Colors.black.withOpacity(0.8),
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