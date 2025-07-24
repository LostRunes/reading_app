

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/book_model.dart';
import '../routes/app_routes.dart';
import '../theme/text_styles.dart';



class BookRow extends StatelessWidget {
  final BookModel book;

  const BookRow({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return InkWell(
    onTap: () => Navigator.pushNamed(
  context,
  AppRoutes.bookDetail,
  arguments: book,
),

      child: Row(
        children: [
          // COVER
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              book.assetPath, 
              width: 60,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          // TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(book.title,  style: bookTitleStyle(context)),
                const SizedBox(height: 4),
                Text(book.author, style: bookAuthorStyle(context)),
                Text(
                  book.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: bookDescriptionStyle(context),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
