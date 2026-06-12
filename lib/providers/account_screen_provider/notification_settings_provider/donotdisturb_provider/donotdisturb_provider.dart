import 'dart:async';

import 'package:flutter/material.dart';

class DndProvider extends ChangeNotifier {
  bool _isScheduleEnabled = true;
  final List<bool> _selectedDays = [false, true, true, true, true, true, false];
  String _startTime = '08:00';
  String _endTime = '19:00';

  DateTime? _snoozeUntil;
  Timer? _snoozeTimer;

  DateTime? get snoozeUntil => _snoozeUntil;
  bool get isSnoozed => _snoozeUntil != null && _snoozeUntil!.isAfter(DateTime.now());
  bool get isScheduleEnabled => _isScheduleEnabled;
  List<bool> get selectedDays => _selectedDays;
  String get startTime => _startTime;
  String get endTime => _endTime;

  void toggleSchedule(bool value) {
    _isScheduleEnabled = value;
    notifyListeners();
  }

  void toggleDay(int index) {
    _selectedDays[index] = !_selectedDays[index];
    notifyListeners();
  }

  void updateStartTime(String time) {
    _startTime = time;
    notifyListeners();
  }

  void updateEndTime(String time) {
    _endTime = time;
    notifyListeners();
  }
  void snoozeNotifications(Duration duration) {
    _snoozeUntil = DateTime.now().add(duration);
    notifyListeners();

    _snoozeTimer?.cancel();
    _snoozeTimer = Timer(duration, () {
      _snoozeUntil = null;
      notifyListeners();
    });
  }

  void turnOffSnooze() {
    _snoozeUntil = null;
    _snoozeTimer?.cancel();
    notifyListeners();
  }

  @override
  void dispose() {
    _snoozeTimer?.cancel();
    super.dispose();
  }
}