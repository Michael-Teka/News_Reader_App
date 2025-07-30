// lib/pages/search_page.dart
import 'package:flutter/material.dart';
import 'package:news_reader/Services/api_service.dart';
import 'package:news_reader/widget/wigdets.dart';
import '../models/article_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<Article> _results = [];
  bool _isLoading = false;
  String _error = '';

  void _searchArticles() async {
    final query = _controller.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final articles = await NewsService().searchArticles(query);
      setState(() {
        _results = articles;
      });
    } catch (e) {
      setState(() {
        _error = 'Something went wrong. Try again.';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color.fromARGB(255, 202, 200, 202),
      appBar: const AppBarWidget(
        title:  'Search News',
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onSubmitted: (_) => _searchArticles(),
              decoration: InputDecoration(
              
                hintText: 'Search by keyword...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchArticles,
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_error.isNotEmpty)
              Text(_error, style: const TextStyle(color: Colors.red))
            else if (_results.isEmpty)
              const Text('No results')
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    final article = _results[index];
                    return ListTile(
                      leading: article.urlToImage != null
                          ? Image.network(article.urlToImage!, width: 100, fit: BoxFit.cover)
                          : null,
                      title: Text(article.title),
                      subtitle: Text(article.source),
                      onTap: () async {
                        final url = Uri.parse(article.url);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        }
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
