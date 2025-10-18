import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/article_details/index.dart';
import '../widgets/common/index.dart';
import '../viewmodels/article_details_viewmodel.dart';

class ArticleDetailsScreen extends StatelessWidget {
  const ArticleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ArticleDetailsViewModel>();

    if (vm.article == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: const EmptyView(),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          ArticleDetailsHeader(article: vm.article!),
          ArticleDetailsContent(article: vm.article!),
        ],
      ),
    );
  }
}