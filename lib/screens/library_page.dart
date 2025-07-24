import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/library_manager.dart';
import '../widgets/book_row.dart';
import '../models/book_model.dart';
import '../widgets/book_search_delegate.dart';
import '../theme/text_styles.dart';



enum SortOption { titleAsc, titleDesc, authorAsc, authorDesc }

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  
  bool hideShortBooks = false;
  SortOption sort = SortOption.titleAsc;
  String _chapterFilter = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 237, 214, 222), 
      appBar: AppBar(
        title: Text('Library', style: GoogleFonts.nunito(fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
  icon: const Icon(Icons.search),
  onPressed: () => showSearch(
    context: context,
    delegate: BookSearchDelegate(LibraryManager.instance.books.value),
  ),
),

          IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: _openFilterSheet,
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _openSortDialog,
          ),
        ],
      ),


      
      body: ValueListenableBuilder<List<BookModel>>(
        valueListenable: LibraryManager.instance.books,
        builder: (_, list, __) {
          // Apply filter
          var display = List<BookModel>.from(list);

if (_chapterFilter != 'all') {
  if (_chapterFilter == 'lt5') {
    display = display.where((b) => b.chapters < 5).toList();
  } else if (_chapterFilter == '5to10') {
    display = display.where((b) => b.chapters >= 5 && b.chapters <= 10).toList();
  } else if (_chapterFilter == 'gt10') {
    display = display.where((b) => b.chapters > 10).toList();
  }
}


          // sort working
          display.sort((a, b) {
            switch (sort) {
              case SortOption.titleAsc:
                return a.title.compareTo(b.title);
              case SortOption.titleDesc:
                return b.title.compareTo(a.title);
              case SortOption.authorAsc:
                return a.author.compareTo(b.author);
              case SortOption.authorDesc:
                return b.author.compareTo(a.author);
            }
          });

          if (display.isEmpty) {
            return Center(
              child: Text('No books yet',
                  style: GoogleFonts.nunito(fontSize: 16)),
            );
          }
return ListView.separated(
  padding: const EdgeInsets.all(16),
  itemCount: display.length,
  separatorBuilder: (_, __) => const SizedBox(height: 12),
  itemBuilder: (_, i) {
    final book = display[i];
    return Dismissible(
      key: ValueKey(book.title),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => LibraryManager.instance.remove(book),
      child: BookRow(book: book),
    );
  },
);

        },
      ),
    );
  }

  // fliter
  void _openFilterSheet() {
  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (context, setSheetState) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Filter by Chapters', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),

                RadioListTile<String>(
                  value: 'lt5',
                  groupValue: _chapterFilter,
                  onChanged: (val) => setSheetState(() => _chapterFilter = val!),
                  title: const Text('< 5 Chapters'),
                ),
                RadioListTile<String>(
                  value: '5to10',
                  groupValue: _chapterFilter,
                  onChanged: (val) => setSheetState(() => _chapterFilter = val!),
                  title: const Text('5 to 10 Chapters'),
                ),
                RadioListTile<String>(
                  value: 'gt10',
                  groupValue: _chapterFilter,
                  onChanged: (val) => setSheetState(() => _chapterFilter = val!),
                  title: const Text('> 10 Chapters'),
                ),
                RadioListTile<String>(
                  value: 'all',
                  groupValue: _chapterFilter,
                  onChanged: (val) => setSheetState(() => _chapterFilter = val!),
                  title: const Text('No Filter'),
                ),

                const SizedBox(height: 16),

                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {}); 
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Apply Filter'),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}


  // sort
  void _openSortDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sort by'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: SortOption.values.map((opt) {
            return RadioListTile<SortOption>(
              value: opt,
              groupValue: sort,
              title: Text(_labelFor(opt)),
              onChanged: (val) => setState(() => sort = val!),
            );
          }).toList(),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))
        ],
      ),
    );
  }

  String _labelFor(SortOption opt) {
    switch (opt) {
      case SortOption.titleAsc:
        return 'Title (A → Z)';
      case SortOption.titleDesc:
        return 'Title (Z → A)';
      case SortOption.authorAsc:
        return 'Author (A → Z)';
      case SortOption.authorDesc:
        return 'Author (Z → A)';
    }
  }
}
