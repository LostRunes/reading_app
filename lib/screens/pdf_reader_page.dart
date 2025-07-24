import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class PdfReaderPage extends StatefulWidget {
  final String pdfAssetPath; // 
  const PdfReaderPage({super.key, required this.pdfAssetPath});

  @override
  State<PdfReaderPage> createState() => _PdfReaderPageState();
}

class _PdfReaderPageState extends State<PdfReaderPage> {
  String? _tempPath; 
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    final bytes = await rootBundle.load(widget.pdfAssetPath);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/${widget.pdfAssetPath.split('/').last}'); // n e
    await file.writeAsBytes(bytes.buffer.asUint8List());
    if (mounted) {
      setState(() {
        _tempPath = file.path;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reading')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : PDFView(
              filePath: _tempPath!,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: true,
            ),
    );
  }
}
