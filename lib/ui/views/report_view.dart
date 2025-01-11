import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:rmts/ui/views/pdf_viewer.dart';

class ReportsView extends StatefulWidget {
  @override
  _ReportsViewState createState() => _ReportsViewState();
}

class _ReportsViewState extends State<ReportsView> {
  late Future<List<Reference>> _reportsFuture;

  @override
  void initState() {
    super.initState();
    _reportsFuture = _fetchReports();
  }

  // Fetch all PDF files from the 'reports' folder in Firebase Storage
  Future<List<Reference>> _fetchReports() async {
    final storageRef = FirebaseStorage.instance.ref().child('reports');
    final ListResult result = await storageRef.listAll();
    return result.items; // Returns the list of file references
  }

  // Navigate to the PDF Viewer Page
  void _openPDF(String downloadUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFViewerPage(pdfUrl: downloadUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
      ),
      body: FutureBuilder<List<Reference>>(
        future: _reportsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching reports'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No reports available'));
          } else {
            final reports = snapshot.data!;
            return ListView.builder(
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final fileRef = reports[index];
                return FutureBuilder<String>(
                  future: fileRef.getDownloadURL(),
                  builder: (context, urlSnapshot) {
                    if (urlSnapshot.connectionState == ConnectionState.waiting) {
                      return ListTile(
                        title: Text(fileRef.name),
                        subtitle: Text('Loading URL...'),
                      );
                    } else if (urlSnapshot.hasError) {
                      return ListTile(
                        title: Text(fileRef.name),
                        subtitle: Text('Error loading URL'),
                      );
                    } else {
                      final downloadUrl = urlSnapshot.data!;
                      return ListTile(
                        title: Text(fileRef.name),
                        subtitle: Text('Tap to view'),
                        trailing: Icon(Icons.picture_as_pdf),
                        onTap: () => _openPDF(downloadUrl),
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
