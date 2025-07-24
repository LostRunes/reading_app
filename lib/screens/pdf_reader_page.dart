import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_pdfview/flutter_pdfview.dart'; // this one is for showing pdfs
import 'package:path_provider/path_provider.dart'; // to get file location temp

// takes a pdf file-asset path and opens it for reading
class PdfReaderPage extends StatefulWidget {
  final String pdfAssetPath; // 
  const PdfReaderPage({super.key, required this.pdfAssetPath});

  @override
  State<PdfReaderPage> createState() => _PdfReaderPageState();
}

class _PdfReaderPageState extends State<PdfReaderPage> {
  String? _tempPath; // to store the path of the temp file
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    final bytes = await rootBundle.load(widget.pdfAssetPath); // loading as bytes
    final dir = await getTemporaryDirectory(); // temp directory
    final file = File('${dir.path}/${widget.pdfAssetPath.split('/').last}'); // temp file with same name
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
