import 'package:flutter/material.dart';
// this was just a test file, not in use
class TestBgPage extends StatelessWidget {
  const TestBgPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final String bgPath =
        isDark ? 'assets/test_dark.jpg' : 'assets/test_light.jpg';

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(bgPath, fit: BoxFit.cover),
          Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              color: Colors.black26,
              child: Text(
                'Theme: ${isDark ? "Dark" : "Light"}',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
