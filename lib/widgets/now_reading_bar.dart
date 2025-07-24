import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/reading_manager.dart';
import '../routes/app_routes.dart';
import '../models/book_model.dart';

class NowReadingBar extends StatelessWidget {
  const NowReadingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<BookModel?>(
      valueListenable: ReadingManager.instance.current,
      builder: (_, book, __) {
        if (book == null) return const SizedBox.shrink();

        final isDark = Theme.of(context).brightness == Brightness.dark;
        final bg = isDark ? Colors.grey.shade900 : Colors.white;
        final textCol = isDark ? Colors.white : Colors.black87;

        return Dismissible(
          key: const ValueKey('now_reading_bar'),
          direction: DismissDirection.endToStart, // swipe ➡️ to ⬅️
          onDismissed: (_) => ReadingManager.instance.clear(),
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 24),
            color: Colors.redAccent,
            child: const Icon(Icons.close, color: Colors.white, size: 28),
          ),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(
                context, AppRoutes.bookDetail, arguments: book),
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: const Offset(0, 2))
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(book.assetPath, width: 40, height: 56),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(book.title,
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: textCol),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        Text(book.author,
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: textCol.withOpacity(.7)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: LinearProgressIndicator(
                            value: .36,
                            minHeight: 4,
                            backgroundColor:
                                textCol.withOpacity(isDark ? 0.2 : 0.1),
                            valueColor: AlwaysStoppedAnimation(
                                Theme.of(context).primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.swipe_left, size: 18, color: Colors.grey),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
