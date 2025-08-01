import 'package:flutter/material.dart';
import 'package:news_reader/Services/bookmark_provider.dart';
import 'package:news_reader/Services/news_provider.dart';
import 'package:news_reader/screens/home_page.dart';
import 'package:news_reader/widget/bottom_navigation.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NewsProvider()),
      ChangeNotifierProvider(create: (_) => BookmarkProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Reader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const BottomNavigationwidget(),
    );
  }
}
