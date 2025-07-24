import 'package:flutter/material.dart';

TextStyle bookTitleStyle(BuildContext context) => TextStyle(
  color: Theme.of(context).brightness == Brightness.dark
      ? const Color.fromARGB(255, 0, 0, 0)
      : Colors.black87,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

TextStyle bookAuthorStyle(BuildContext context) => TextStyle(
  color: Theme.of(context).brightness == Brightness.dark
      ? const Color.fromARGB(179, 0, 0, 0)
      : Colors.black54,
  fontSize: 13,
  fontStyle: FontStyle.italic,
);

TextStyle bookDescriptionStyle(BuildContext context) => TextStyle(
  color: Theme.of(context).brightness == Brightness.dark
      ? const Color.fromARGB(153, 0, 0, 0)
      : Colors.black54,
  fontSize: 12,
);
