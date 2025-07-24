

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/book_model.dart';
import '../data/library_manager.dart';


class BookCard extends StatelessWidget {
  final BookModel book;
  final VoidCallback onTap;
  final VoidCallback onBookmark;
  final bool square;

  const BookCard({
    super.key,
    required this.book,
    required this.onTap,
    required this.onBookmark,
    this.square = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = square ? 120.0 : 140.0;
    final cardHeight = square ? 120.0 : 200.0;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: cardWidth,
        height: cardHeight,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // bg block
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            // Book title and author
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(book.author,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w400, fontSize: 12)),
                ],
              ),
            ),
            // Cover image
            Positioned(
              top: square ? -20 : 12,
              left: 12,
              right: 12,
              child: Hero(
  tag: book.assetPath,
  child: Image.asset(book.assetPath, height: 100),
),

            ),
            // Bookmark icon 
            if (!square)
  Positioned(
    top: 4,
    right: 4,
    child: ValueListenableBuilder<List<BookModel>>(
      valueListenable: LibraryManager.instance.books,
      builder: (_, list, __) {
        final saved = LibraryManager.instance.contains(book);
        return IconButton(
          icon: Icon(saved ? Icons.bookmark : Icons.bookmark_border),
          splashRadius: 20,
          onPressed: () {
            final nowSaved = LibraryManager.instance.toggle(book);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  nowSaved
                      ? 'Added "${book.title}"'
                      : 'Removed "${book.title}"',
                ),
              ),
            );
          },
        );
      },
    ),
  ),

          ],
        ),
      ),
    );
  }
}
