import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final PageController _controller = PageController();
  int currentPage = 0;

  List<Map<String, String>> pages = [
    {
      "title": "Welcome",
      "description": "Welcome to our app"
    },
    {
      "title": "Fast",
      "description": "Experience fast performance"
    },
    {
      "title": "Secure",
      "description": "Your data is safe"
    },
  ];

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: pages.length,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  pages[index]["title"]!,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 20),
                Text(
                  pages[index]["description"]!,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                if (index == pages.length - 1)
                  ElevatedButton(
                    onPressed: _finishOnboarding,
                    child: Text("Get Started"),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}