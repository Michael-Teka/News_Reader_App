import 'package:flutter/material.dart';
import 'package:news_reader/Services/bookmark_provider.dart';
import 'package:news_reader/widget/wigdets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookmarkProvider>(context);
    final bookmarks = provider.bookmarks;

    return Scaffold(
      appBar: const AppBarWidget(
        title: "Bookmarks",
      ),
      body: bookmarks.isEmpty
          ? const Center(child: Text("No bookmarks yet."))
          : ListView.builder(
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                final article = bookmarks[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (article.urlToImage != null)
                      Image.network(article.urlToImage!, fit: BoxFit.cover),
                    ListTile(
                      title: Text(article.title),
                      subtitle: Text(article.source),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          provider.toggleBookmark(article);
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
            ),
    );
  }
}
