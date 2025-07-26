import 'package:flutter/material.dart';
import 'package:news_reader/Services/api_service.dart';
import 'package:news_reader/models/article_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsListPage extends StatefulWidget {
  final String category;
  const NewsListPage({super.key, required this.category});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  late Future<List<Article>> _articlesFuture;

  @override
  void initState() {
    super.initState();
    _articlesFuture = NewsService().fetchNewsByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.toUpperCase()),
      ),
      body: FutureBuilder<List<Article>>(
        future: _articlesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final articles = snapshot.data!;
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
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
          );
        },
      ),
    );
  }
}
