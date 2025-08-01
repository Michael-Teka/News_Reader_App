import 'package:flutter/material.dart';
import 'package:news_reader/Services/bookmark_provider.dart';
import 'package:news_reader/Services/news_provider.dart';
import 'package:news_reader/widget/wigdets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsListPage extends StatefulWidget {
  final String category;
  const NewsListPage({super.key, required this.category});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<NewsProvider>(context, listen: false);
      provider.fetchArticles(widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);

    return Scaffold(
      appBar: AppBarWidget(
        title: widget.category,
      ),
      body: Consumer<NewsProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.errorMessage.isNotEmpty) {
            return Center(child: Text(provider.errorMessage));
          }
          return ListView.builder(
            itemCount: provider.articles.length,
            itemBuilder: (context, index) {
              final article = provider.articles[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (article.urlToImage != null)
                    Image.network(article.urlToImage!, fit: BoxFit.cover),
                  ListTile(
                    title: Text(article.title),
                    subtitle: Text(article.source),
                    trailing: IconButton(
                      icon: Icon(
                        bookmarkProvider.isBookmarked(article)
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                      ),
                      onPressed: () {
                        bookmarkProvider.toggleBookmark(article);
                      },
                    ),
                    onTap: () async {
                      final url = Uri.parse(article.url);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                    },
                  ),
                  const Divider(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
