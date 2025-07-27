import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_reader/Services/api_service.dart';
import 'package:news_reader/models/article_model.dart';
import 'package:news_reader/screens/news_list_page.dart';
import 'package:news_reader/screens/search_page.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Article> _recentArticles = [];

  final List<Map<String, dynamic>> categories = const [
    {'name': 'Technology', 'value': 'technology', 'icon': Icons.memory, 'color': Colors.blue},
    {'name': 'Business', 'value': 'business', 'icon': Icons.business_center, 'color': Colors.green},
    {'name': 'Sports', 'value': 'sports', 'icon': Icons.sports_soccer, 'color': Colors.orange},
    {'name': 'Health', 'value': 'health', 'icon': Icons.health_and_safety, 'color': Colors.red},
    {'name': 'Science', 'value': 'science', 'icon': Icons.science, 'color': Colors.purple},
    {'name': 'Entertainment', 'value': 'entertainment', 'icon': Icons.movie, 'color': Colors.pink},
  ];

  @override
  void initState() {
    super.initState();
    _fetchRecentNews();
  }

  void _fetchRecentNews() async {
    try {
      final recent = await NewsService().fetchNewsByCategory("general");
      setState(() {
        _recentArticles = recent.take(5).toList();
      });
    } catch (e) {
      debugPrint("Error loading recent news: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('🗞️ News Reader'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchPage()),
              );
            },
          ),
          const SizedBox(width: 4),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://avatars.githubusercontent.com/u/00000000?v=4', // Replace with your image
              ),
              radius: 16,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Browse by Category",
                style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              flex: 2,
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.7,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              NewsListPage(category: category['value']),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: category['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: category['color'], width: 1.2),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(category['icon'], color: category['color']),
                            const SizedBox(width: 8),
                            Text(category['name'],
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: category['color'],
                                )),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 2),
            Text("Recent Headlines",
                style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
              height: 180,
              child: _recentArticles.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _recentArticles.length,
                      itemBuilder: (context, index) {
                        final article = _recentArticles[index];
                        return GestureDetector(
                          onTap: () async {
                            final url = Uri.parse(article.url);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          },
                          child: Container(
                            width: 250,
                            margin: const EdgeInsets.only(right: 12),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  article.urlToImage != null
                                      ? Image.network(
                                          article.urlToImage!,
                                          height: 80,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => Container(
                                            height: 80,
                                            color: Colors.grey[300],
                                            alignment: Alignment.center,
                                            child: const Icon(Icons.broken_image),
                                          ),
                                        )
                                      : Container(
                                          height: 80,
                                          color: Colors.grey[300],
                                          alignment: Alignment.center,
                                          child: const Icon(Icons.image_not_supported),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      article.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.lato(fontSize: 14),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
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
