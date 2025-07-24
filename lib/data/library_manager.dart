import 'package:flutter/material.dart';
import '../models/book_model.dart';


class LibraryManager {
  LibraryManager._private();
  static final LibraryManager instance = LibraryManager._private();

  final ValueNotifier<List<BookModel>> books = ValueNotifier<List<BookModel>>([]);

  void add(BookModel book) {
    if (!books.value.contains(book)) {
      books.value = [...books.value, book];
    }
  }

  void remove(BookModel book) {
    books.value = books.value.where((b) => b != book).toList();
  }

  void clear() => books.value = [];

  bool contains(BookModel b) => books.value.contains(b);


  bool toggle(BookModel b) {
    if (contains(b)) {
      remove(b);
      return false;
    } else {
      add(b);
      return true;
    }
  }

}
