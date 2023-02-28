import 'package:flutter/material.dart';
import 'package:the_psychelp/pages/landing_page.dart';

void main() {
  runApp(const ThePsycHelp());
}

class ThePsycHelp extends StatelessWidget {
  const ThePsycHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The PsycHelp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const LandingPage(),
    );
  }
}


