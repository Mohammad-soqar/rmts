import 'package:flutter/material.dart';
import 'package:rmts/data/models/enums/glove_status.dart';
import 'package:rmts/data/models/glove.dart';
import 'package:rmts/data/repositories/glove_repository.dart';

class GloveViewModel extends ChangeNotifier {
  final GloveRepository _gloveRepository;
  Glove? _currentGlove; // Store fetched glove data
  GloveStatus _selectedStatus = GloveStatus.idle;
  bool _isLoading = false;
  String? errorMessage;
  GloveStatus get selectedStatus => _selectedStatus;
  GloveViewModel(this._gloveRepository);

  Glove? get currentGlove => _currentGlove; // Getter for UI
  bool get isLoading => _isLoading;

  void setSelectedStatus(GloveStatus newStatus) {
    _selectedStatus = newStatus;
    notifyListeners();
  }

  Future<void> fetchGlove(String gloveId) async {
    _setLoading(true);

    try {
      _currentGlove = await _gloveRepository.fetchGlove(gloveId);
      _clearError();
    } catch (e) {
      _setError('Failed to fetch glove: ${e.toString()}');
      print('Failed to fetch glove: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addGlove(Glove glove) async {
    _setLoading(true);

    try {
      await _gloveRepository.addGlove(glove);
      _clearError();
    } catch (e) {
      _setError('Failed to add glove: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateGlove(Glove glove) async {
    _setLoading(true);

    try {
      await _gloveRepository.updateGlove(glove);
      _clearError();
    } catch (e) {
      _setError('Failed to update glove: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    errorMessage = null;
    notifyListeners();
  }
}
