import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/book_model.dart';
import '../data/library_manager.dart';
import '../routes/app_routes.dart';
import '../data/reading_manager.dart';
import 'pdf_reader_page.dart';


class BookDetailPage extends StatelessWidget {
  const BookDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Expect BookModel via Navigator arguments
    final book = ModalRoute.of(context)!.settings.arguments as BookModel;
     final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final headline = GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 20);
    final subtitle = GoogleFonts.nunito(fontWeight: FontWeight.w400, fontSize: 14);

    return Scaffold(
      extendBodyBehindAppBar: true, // so gradient can fill under status bar
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
        actions: [
          // reactive bookmark
          ValueListenableBuilder<List<BookModel>>(
            valueListenable: LibraryManager.instance.books,
            builder: (_, list, __) {
              final saved = LibraryManager.instance.contains(book);
              return IconButton(
                icon: Icon(saved ? Icons.bookmark : Icons.bookmark_border),
                onPressed: () => LibraryManager.instance.toggle(book),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // ── TOP GRADIENT BACKGROUND ──
           Container(
          height: MediaQuery.of(context).size.height * .47,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [
                      // Deeper tint for dark mode
                      Theme.of(context).primaryColor.withOpacity(0.25),
                      Theme.of(context).primaryColor.withOpacity(0.10),
                    ]
                  : [
                      // Softer tint for light mode
                      Theme.of(context).primaryColor.withOpacity(0.15),
                      Theme.of(context).primaryColor.withOpacity(0.05),
                    ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
          // ── CONTENT ──
          Column(
            children: [
              const SizedBox(height: kToolbarHeight + 32),
              // Cover image
              Hero(
                tag: book.assetPath,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(book.assetPath, height: 200),
                ),
              ),
              const SizedBox(height: 20),
              Text(book.title, style: headline),
              Text(book.author, style: subtitle),
              const SizedBox(height: 16),
              // Info pill
              Container(
  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
  margin: const EdgeInsets.symmetric(horizontal: 40),
  decoration: BoxDecoration(
    color: Theme.of(context).primaryColor.withOpacity(.1),
    borderRadius: BorderRadius.circular(20),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(children: [
        Text(book.categoryValue,
            style: headline.copyWith(fontSize: 14)),
        Text(book.category, style: subtitle),
      ]),
      Column(children: [
        Text(book.chapters.toString(),
            style: headline.copyWith(fontSize: 14)),
        Text('Chapters', style: subtitle),
      ]),
    ],
  ),
),
            ],
          ),
          // ── DRAGGABLE SHEET ──
          DraggableScrollableSheet(
            initialChildSize: .38,
            minChildSize: .38,
            maxChildSize: .85,
            builder: (ctx, scrollCtrl) => Container(
  decoration: BoxDecoration(
    color: isDark ? Colors.grey.shade900 : Colors.white,   // ← NEW
    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
  ),
  child: Column(
    children: [
      const SizedBox(height: 6),
      Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(2)),
      ),
      const SizedBox(height: 10),
      Expanded(
        child: ListView(
          controller: scrollCtrl,
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
          children: [
            Text(
              'Description',
              style: headline.copyWith(
                fontSize: 16,
                color: isDark ? Colors.white : Colors.black,  // ← NEW
              ),
            ),
            const SizedBox(height: 8),
            Text(book.description,
     style: subtitle.copyWith(
       color: isDark ? Colors.white70 : Colors.black87,
     )),
          ],
        ),
      ),
    ],
  ),
)
          ),
          // ── START READING BUTTON ──
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
    ReadingManager.instance.start(book); // keep your now‑reading bar
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PdfReaderPage(pdfAssetPath: book.pdfAssetPath),
      ),
    );
  },
                  child: const Text('Start Reading',
                      style:
                          TextStyle(fontSize: 18, 
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          ),
                          ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
