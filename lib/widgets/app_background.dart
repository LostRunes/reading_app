import 'package:flutter/material.dart';
import '../theme/app_theme.dart';     

class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(isDark
              ? 'assets/bg_dark.jpg'
              : 'assets/bg_light.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
