
import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';
import 'screens/my_books_page.dart';
import 'screens/library_page.dart';
import 'screens/book_detail_page.dart';
import 'widgets/now_reading_bar.dart';




final themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.system);


void main() => runApp(const ReadingApp());

class ReadingApp extends StatelessWidget {
  const ReadingApp({super.key});

  @override
  Widget build(BuildContext context) {
     // ValueListenableBuilder > rebuild MaterialApp whenever themenotif flips
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, mode, __) {
        return
        
         MaterialApp(
          
           title: 'Mystic Echoes',
           debugShowCheckedModeBanner: false, // to remove the banner
  theme: AppTheme.light, // connected to app_theme in theme folder
  darkTheme: AppTheme.dark,
  themeMode: themeNotifier.value,  // Uses whatever mode themeNotifier gives
  initialRoute: AppRoutes.splash,
          routes: {
            AppRoutes.splash: (_) => const SplashScreen(),
            AppRoutes.home  : (_) => const HomeScreen(),
            AppRoutes.myBooks: (_) => const MyBooksPage(),
            AppRoutes.library: (_) => const LibraryPage(),
            AppRoutes.bookDetail: (_) => const BookDetailPage(),

          },

          // builder() lets us overlay widgets ABOVE every routed page
          // Here we pin NowReadingBar to the bottom, but child! is the
          // actual current page (Splash, Home, etc.).
          builder: (context, child) {
    return Stack(
      children: [
        child!, // this is the actual page, the current page
         Positioned(
        left: 0,  // the whole positioning of the bar
        right: 0,
        bottom: 0,                  // pin to bottom 
        height: 80,   // bar height
          child: NowReadingBar(), // floating bar on top
         ),
      ],
    );
  },
        );
      },
    );
  }
}
