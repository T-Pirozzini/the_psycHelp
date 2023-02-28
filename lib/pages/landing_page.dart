import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:the_psychelp/pages/home_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeIn(
              animate: true,
              delay: const Duration(milliseconds: 1000),
              duration: const Duration(seconds: 1),
              child: const Text(
                'Welcome',
                style: TextStyle(fontFamily: 'VarelaRound', fontSize: 64),
              ),
            ),
            FadeIn(
              animate: true,
              delay: const Duration(milliseconds: 1500),
              duration: const Duration(seconds: 1),
              child: Image.asset('assets/images/psycHelp-logo.png'),
            ),
            const SizedBox(height: 20.0),
            FadeIn(
              animate: true,
              delay: const Duration(milliseconds: 2000),
              duration: const Duration(seconds: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const HomePage();
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      foregroundColor: Colors.white,
                      minimumSize: const Size(150, 40),
                    ),
                    child: const Text('Login', style: TextStyle(fontSize: 18)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const HomePage();
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      foregroundColor: Colors.white,
                      minimumSize: const Size(150, 40),
                    ),
                    child:
                        const Text('Register', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
