import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import '/viewmodels/reports_viewmodel.dart';
import 'package:provider/provider.dart';


class ReportsView extends StatefulWidget {
  const ReportsView({super.key});

  @override
  State<ReportsView> createState() => _ReportsViewState();
}

class _ReportsViewState extends State<ReportsView> {

@override
    void initState() {
    super.initState();
    // Fetch reports when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final reportsViewModel = Provider.of<ReportsViewModel>(context, listen: false);
      reportsViewModel.fetchReports();
    });
  }

   @override
  Widget build(BuildContext context) {
    final reportsViewModel = Provider.of<ReportsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
      ),
      body: reportsViewModel.isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading spinner
          : reportsViewModel.reports.isEmpty
              ? Center(child: Text('No reports available.')) // Show message if no reports
              : ListView.builder(
                  itemCount: reportsViewModel.reports.length,
                  itemBuilder: (context, index) {
                    final fileRef = reportsViewModel.reports[index];
                    return ListTile(
                      title: Text(fileRef.name), // Display the file name
                      subtitle: Text('Tap to view'),
                      trailing: Icon(Icons.picture_as_pdf),
                      onTap: () async {
                        // Fetch the file's download URL
                        final downloadUrl = await fileRef.getDownloadURL();
                        // Navigate to a PDF Viewer page or handle the file URL
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PDFViewerPage(pdfUrl: downloadUrl),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}

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
    _downloadAndSavePDF();
  }

  Future<void> _downloadAndSavePDF() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/temp.pdf';

      // Download PDF using Dio
      await Dio().download(widget.pdfUrl, filePath);

      setState(() {
        localPath = filePath;
        isLoading = false;
      });
    } catch (e) {
      print('Error downloading PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load the PDF')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : PDFView(
              filePath: localPath,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: true,
              pageFling: true,
              onError: (error) {
                print('PDFView Error: $error');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error displaying PDF')),
                );
              },
              onPageChanged: (page, total) {
                print('Page $page of $total');
              },
            ),
    );
  }
}