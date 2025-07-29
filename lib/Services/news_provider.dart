import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../Services/api_service.dart';

class NewsProvider with ChangeNotifier {
  final NewsService _newsService = NewsService();

  List<Article> _articles = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchArticles(String category) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _articles = await _newsService.fetchNewsByCategory(category);
    } catch (e) {
      _errorMessage = 'Failed to load articles: $e';
    }

    _isLoading = false;
    notifyListeners();
  }
}
