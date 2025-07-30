import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_reader/models/article_model.dart';

class NewsService {
  final String _apiKey = '795ea6fa002649fabbaa6013e95a7a7f';
  final String _baseUrl = 'https://newsapi.org/v2';

  Future<List<Article>> fetchNewsByCategory(String category) async {
    final url = Uri.parse(
      '$_baseUrl/top-headlines?country=us&category=$category&apiKey=$_apiKey',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List articles = data['articles'];
      return articles.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
  Future<List<Article>> searchArticles(String query) async {
  final url = Uri.parse(
    '$_baseUrl/everything?q=$query&sortBy=publishedAt&apiKey=$_apiKey',
  );
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List articles = data['articles'];
    return articles.map((json) => Article.fromJson(json)).toList();
  } else {
    throw Exception('Failed to search articles');
  }
}

}
