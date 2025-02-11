import 'package:flutter/material.dart';
import 'package:rmts/data/models/enums/glove_status.dart';
import 'package:rmts/data/models/glove.dart';
import 'package:rmts/data/repositories/glove_repository.dart';

class GloveViewModel extends ChangeNotifier {
  final GloveRepository _gloveRepository;
  GloveStatus _selectedStatus = GloveStatus.idle;
  bool _isLoading = false;
  String? errorMessage;
  GloveStatus get selectedStatus => _selectedStatus;
  GloveViewModel(this._gloveRepository);

  bool get isLoading => _isLoading;

  void setSelectedStatus(GloveStatus newStatus) {
    _selectedStatus = newStatus;
    notifyListeners();
  }

  Future<Glove> fetchGlove(String gloveId) async {
    _setLoading(true);

    try {
      final glove = await _gloveRepository.fetchGlove(gloveId);
      _clearError();
      return glove;
    } catch (e) {
      _setError('Failed to fetch glove: ${e.toString()}');
      rethrow;
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
