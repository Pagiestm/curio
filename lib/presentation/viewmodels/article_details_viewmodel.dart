import 'package:flutter/material.dart';
import '../../../domain/entities/article.dart';

class ArticleDetailsViewModel extends ChangeNotifier {
  Article? _article;

  Article? get article => _article;

  void setArticle(Article article) {
    _article = article;
    notifyListeners();
  }
}
