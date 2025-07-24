import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // Pulsing glow controller
  late final AnimationController _glowCtrl = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2), // duration of the glow animation
  )..repeat(reverse: true); // loops the animation


// called when the screen is first loaded 
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds:5), // animation screen runs for 5 seconds and then goes to homescreen
    () {
      Navigator.pushReplacementNamed(context, AppRoutes.home); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // keep transparent to let Lottie fill entire view
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // lottie anination asset
          Lottie.asset(
            'assets/splash_animation.json',
            fit: BoxFit.cover,
          ),

          // title
          Center(
            child: AnimatedBuilder( 
              animation: _glowCtrl,
              builder: (_, __) {
                final glow = 6 + 8 * _glowCtrl.value; 
                return Text(
                  'Mystic Echoes',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        color: Colors.white.withOpacity(0.9),
                        blurRadius: glow,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _glowCtrl.dispose();
    super.dispose();
  }  
}
