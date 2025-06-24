import 'package:flutter/material.dart';

class GloveStatusViewModel extends ChangeNotifier {
  DateTime? lastSynced;

  void updateSyncTime() {
    lastSynced = DateTime.now();
    notifyListeners();
  }

  String? get formattedSyncTime {
    if (lastSynced == null) return null;
    return '${lastSynced!.hour.toString().padLeft(2, '0')}:${lastSynced!.minute.toString().padLeft(2, '0')} '
           '${lastSynced!.day.toString().padLeft(2, '0')}/${lastSynced!.month.toString().padLeft(2, '0')}/${lastSynced!.year}';
  }
}
