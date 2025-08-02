import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(MyIPMDebug());
}

class MyIPMDebug extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IPM Debug',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomePage(), // ← langsung tampilkan home_page.dart
    );
  }
}
