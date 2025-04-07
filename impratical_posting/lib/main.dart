import 'package:flutter/material.dart';
import 'package:impratical_posting/dart/current_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Impratical Posting',
      theme: ThemeData.dark(),
      home: const CurrentPage(),
    );
  }
}
