import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/book_model.dart';
import '../widgets/book_row.dart';
import '../routes/app_routes.dart';

class BookSearchDelegate extends SearchDelegate<BookModel?> {
  
  final List<BookModel> source;

  BookSearchDelegate(this.source)
      : super(searchFieldLabel: 'Search by title or author');

  
  @override
  ThemeData appBarTheme(BuildContext context) =>
      Theme.of(context).copyWith(textTheme: GoogleFonts.nunitoTextTheme());
  

  @override
  List<Widget> buildActions(BuildContext context) => [
        if (query.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => query = '',
          ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  
  List<BookModel> _results() => source
      .where((b) =>
          b.title.toLowerCase().contains(query.toLowerCase()) ||
          b.author.toLowerCase().contains(query.toLowerCase()))
      .toList();

  @override
  Widget buildResults(BuildContext context) =>
      _buildList(context, _results());

  @override
  Widget buildSuggestions(BuildContext context) =>
      _buildList(context, _results());

  
   
  Widget _buildList(BuildContext context, List<BookModel> list) {
    final empty = Center(
      child: Text(
        'No matches',
        style: GoogleFonts.nunito(fontSize: 16),
      ),
    );

    
    return Container(
  color: const Color.fromARGB(255, 209, 225, 232),  
  child: list.isEmpty
      ? empty
      : ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: list.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) => GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.bookDetail,
                arguments: list[i],
              );
              close(context, list[i]);
            },
            child: BookRow(book: list[i]),
          ),
        ),
);

  }
}
