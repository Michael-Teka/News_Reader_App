// lib/pages/home_page.dart
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, String>> categories = const [
    {'name': 'Technology', 'value': 'technology'},
    {'name': 'Business', 'value': 'business'},
    {'name': 'Sports', 'value': 'sports'},
    {'name': 'Health', 'value': 'health'},
    {'name': 'Science', 'value': 'science'},
    {'name': 'Entertainment', 'value': 'entertainment'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🗞️ News Reader'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SearchPage()));
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            title: Text(category['name']!),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NewsListPage(category: category['value']!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
