import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../data/services/firebase_storage_service.dart';

class ReportsViewModel extends ChangeNotifier {
  final FirebaseStorageService _firebaseStorageService = FirebaseStorageService();
  List<Reference> _reports = [];
  bool _isLoading = false;
  String errorMessage ='';

  List<Reference> get reports => _reports;
  bool get isLoading => _isLoading;

  Future<void> fetchReports() async {
    _isLoading = true;
    notifyListeners();
    try {
      _reports = await _firebaseStorageService.fetchReports();
    } catch (e) {
      print('Error fetching reports: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}