import 'package:flutter/material.dart';
import 'package:news_reader/screens/bookmark_page.dart';
import 'package:news_reader/screens/home_page.dart';
import 'package:news_reader/screens/search_page.dart';
import 'package:news_reader/widget/wigdets.dart';

class BottomNavigationwidget extends StatefulWidget {
  const BottomNavigationwidget({super.key});

  @override
  State<BottomNavigationwidget> createState() => _BottomNavigationwidgetState();
}

class _BottomNavigationwidgetState extends State<BottomNavigationwidget> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    SearchPage(),
    BookmarkPage(),
  ];
  final List<Color> backgroundColors = [
    Colors.green, // Home
    Colors.yellow, // Search
    Colors.red, // Bookmark
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        // selectedItemColor: Colors.white,
        // unselectedItemColor: Colors.grey[400],
        // backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.yellow,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
            backgroundColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
