import 'package:flutter/material.dart';
import 'package:shopify/root.dart';

void main() {
  runApp(const Shopify());
}

class Shopify extends StatelessWidget {
  const Shopify({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Root(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "Inter",
        useMaterial3: true,
      ),
    );
  }
}
