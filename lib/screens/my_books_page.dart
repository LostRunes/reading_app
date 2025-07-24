

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/book_model.dart';
import '../widgets/book_row.dart';
import '../routes/app_routes.dart';
import '../widgets/book_search_delegate.dart';
import '../theme/text_styles.dart';


class MyBooksPage extends StatelessWidget {
  const MyBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final List<BookModel> books =
        ModalRoute.of(context)!.settings.arguments as List<BookModel>? ??
            const [];

    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 240, 230, 245), // bg colour
      appBar: AppBar(
        leadingWidth: 100,
        leading: Row(
          children: [
            IconButton( // back
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            IconButton( // home
              icon: const Icon(Icons.home_outlined),
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.home, (route) => false),
            ),
          ],
        ),
        title: Text('My Books',
            style:
                GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 20)),
        actions: [
          IconButton(
  icon: const Icon(Icons.search),
  onPressed: () => showSearch(
    context: context,
    delegate: BookSearchDelegate(books),
  ),
),

        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: books.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, index) => BookRow(book: books[index]),
      ),
    );
  }
}
