import 'package:flutter/material.dart';
import '../models/article_model.dart';

class BookmarkProvider with ChangeNotifier {
  final List<Article> _bookmarked = [];

  List<Article> get bookmarks => _bookmarked;

  void toggleBookmark(Article article) {
    final isBookmarked = _bookmarked.any((a) => a.url == article.url);
    if (isBookmarked) {
      _bookmarked.removeWhere((a) => a.url == article.url);
    } else {
      _bookmarked.add(article);
    }
    notifyListeners();
  }

  bool isBookmarked(Article article) {
    return _bookmarked.any((a) => a.url == article.url);
  }
}
