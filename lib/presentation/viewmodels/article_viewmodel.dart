import 'package:curio/domain/entities/article.dart';
import 'package:curio/domain/services/article_service.dart';
import 'package:curio/presentation/viewmodels/settings_viewmodel.dart';
import 'package:flutter/foundation.dart';

class ArticleViewModel extends ChangeNotifier {
  final ArticleService _articleService;
  final SettingsViewModel _settingsViewModel;
  List<Article> _articles = [];
  bool _loading = false;
  String? _error;

  List<Article> get articles => _articles;
  bool get loading => _loading;
  String? get error => _error;

  ArticleViewModel(this._articleService, this._settingsViewModel) {
    _loadInitialData();
    _settingsViewModel.addListener(_onLocaleChanged);
  }

  void _onLocaleChanged() {
    // Recharger les articles lorsque la langue change
    getArticles();
  }

  @override
  void dispose() {
    _settingsViewModel.removeListener(_onLocaleChanged);
    super.dispose();
  }

  Future<void> fetchArticles() async {
    _loading = true;
    notifyListeners();

    _articles = await _articleService.getArticles(
      _settingsViewModel.locale.languageCode,
    );

    _loading = false;
    notifyListeners();
  }

  Future<void> _loadInitialData() async {
    _setLoading(true);
    try {
      _articles = await _articleService.getArticles(
        _settingsViewModel.locale.languageCode,
      );
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
    _articles = await _articleService.getArticles(
      _settingsViewModel.locale.languageCode,
    );
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
