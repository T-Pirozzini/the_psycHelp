import 'package:flutter/material.dart';
import 'package:the_psychelp/pages/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
