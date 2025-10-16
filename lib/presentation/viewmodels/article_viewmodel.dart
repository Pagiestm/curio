import 'package:curio/domain/entities/article.dart';
import 'package:curio/domain/services/article_service.dart';
import 'package:flutter/foundation.dart';

class ArticleViewModel extends ChangeNotifier {
  final ArticleService _articleService;
  List<Article> _articles = [];
  bool _loading = false;
  String? _error;

  List<Article> get articles => _articles;
  bool get loading => _loading;
  String? get error => _error;

  ArticleViewModel(this._articleService) {
    _loadInitialData();
  }

  Future<void> fetchArticles() async {
    _loading = true;
    notifyListeners();

    _articles = await _articleService.getArticles();

    _loading = false;
    notifyListeners();
  }

  Future<void> _loadInitialData() async {
    _setLoading(true);
    try {
      _articles = await _articleService.getArticles();
    } catch (e) {
      _setError('Erreur de chargement: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _update(Future<void> Function() action) async {
    _setLoading(true);
    _clearError();
    try {
      await action();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getArticles() async => _update(() async {
    _articles = await _articleService.getArticles();
  });

  void _setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }
}
