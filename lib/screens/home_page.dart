
import 'package:flutter/material.dart';
import 'package:news_reader/screens/news_list_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_reader/screens/search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, dynamic>> categories = const [
    {'name': 'Technology', 'value': 'technology', 'icon': Icons.memory, 'color': Colors.blue},
    {'name': 'Business', 'value': 'business', 'icon': Icons.business_center, 'color': Colors.green},
    {'name': 'Sports', 'value': 'sports', 'icon': Icons.sports_soccer, 'color': Colors.orange},
    {'name': 'Health', 'value': 'health', 'icon': Icons.health_and_safety, 'color': Colors.red},
    {'name': 'Science', 'value': 'science', 'icon': Icons.science, 'color': Colors.purple},
    {'name': 'Entertainment', 'value': 'entertainment', 'icon': Icons.movie, 'color': Colors.pink},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 82, 6, 92),
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
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello 👋',
              style: GoogleFonts.lato(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Browse news by category',
              style: GoogleFonts.lato(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NewsListPage(category: category['value']),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [category['color'].withOpacity(0.7), category['color']],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: category['color'].withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(category['icon'], size: 40, color: Colors.white),
                          const SizedBox(height: 12),
                          Text(
                            category['name'],
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
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
