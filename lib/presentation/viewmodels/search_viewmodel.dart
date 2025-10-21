import 'package:curio/domain/entities/article.dart';
import 'package:curio/domain/services/article_service.dart';
import 'package:curio/presentation/viewmodels/settings_viewmodel.dart';
import 'package:flutter/foundation.dart';

class SearchViewmodel extends ChangeNotifier {
  final ArticleService _articleService;
  final SettingsViewModel _settingsViewModel;
  List<Article> _articles = [];
  String? _searchKeyword;
  bool _loading = false;
  bool _searchLoading = false;
  String? _error;

  List<Article> get articles => _articles;
  String? get searchKeyword => _searchKeyword;
  bool get loading => _loading;
  bool get searchLoading => _searchLoading;
  String? get error => _error;

  SearchViewmodel(this._articleService, this._settingsViewModel);

  Future<void> _update(Future<void> Function() action) async {
    _clearError();
    try {
      await action();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> setSearchKeyword(String keyword) async {
    if (keyword.isEmpty) {
      _articles = [];
      _searchKeyword = null;
      notifyListeners();
    } else {
      _setSearchLoading(true);
      _searchKeyword = keyword;
      await getArticlesByKeyword();
      _setSearchLoading(false);
    }
  }

  Future<void> getArticlesByKeyword() async => _update(() async {
    if (_searchKeyword != null) {
      _articles = await _articleService.getArticlesByKeyword(
        _searchKeyword!,
        _settingsViewModel.locale.languageCode,
      );
    }
  });

  Future<void> clearArticles() async => _update(() async {
    await _articleService.clearArticles();
    _articles = [];
  });

  void _setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void _setSearchLoading(bool loading) {
    _searchLoading = loading;
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
