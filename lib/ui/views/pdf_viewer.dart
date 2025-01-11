import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PDFViewerPage extends StatefulWidget {
  final String pdfUrl;

  PDFViewerPage({required this.pdfUrl});

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  String? localPath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _downloadPDF();
  }

  Future<void> _downloadPDF() async {
    try {
      // Get a temporary directory
      final tempDir = await getTemporaryDirectory();

      // Create the local file path
      final filePath = "${tempDir.path}/temp.pdf";

      // Download the PDF using Dio
      await Dio().download(widget.pdfUrl, filePath);

      // Update the state with the local path
      setState(() {
        localPath = filePath;
        isLoading = false;
      });
    } catch (e) {
      print("Error downloading PDF: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load the PDF')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Report'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : PDFView(
              filePath: localPath,
              fitPolicy: FitPolicy.BOTH,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: true,
              pageFling: true,
              onRender: (pages) {
                print('Rendered $pages pages');
              },
              onError: (error) {
                print('PDFView Error: $error');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error displaying PDF')),
                );
              },
              onPageError: (page, error) {
                print('Error on page $page: $error');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error on page $page')),
                );
              },
              onPageChanged: (page, total) {
                print('Page $page of $total');
              },
            ),
    );
  }
}
