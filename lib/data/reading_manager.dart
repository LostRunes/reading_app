import 'package:flutter/material.dart';
import '../models/book_model.dart';

class ReadingManager {
  ReadingManager._();
  static final ReadingManager instance = ReadingManager._();

  
  final ValueNotifier<BookModel?> current = ValueNotifier<BookModel?>(null);

  void start(BookModel book) => current.value = book;
  void clear() => current.value = null;
}
