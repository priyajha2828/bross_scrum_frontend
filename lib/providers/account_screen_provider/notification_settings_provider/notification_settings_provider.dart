import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {

  bool _mentions = true;
  bool _watching = false;
  bool _assigned = false;
  bool _reported = false;
  bool _newWork = false;
  bool _approvalRequests = false;
  bool _dueOrOverdue = false;

  bool get mentions => _mentions;
  bool get watching => _watching;
  bool get assigned => _assigned;
  bool get reported => _reported;
  bool get newWork => _newWork;
  bool get approvalRequests => _approvalRequests;
  bool get dueOrOverdue => _dueOrOverdue;

  // Toggle Methods
  void toggleMentions(bool value) {
    _mentions = value;
    notifyListeners();
  }

  void toggleWatching(bool value) {
    _watching = value;
    notifyListeners();
  }

  void toggleAssigned(bool value) {
    _assigned = value;
    notifyListeners();
  }

  void toggleReported(bool value) {
    _reported = value;
    notifyListeners();
  }

  void toggleNewWork(bool value) {
    _newWork = value;
    notifyListeners();
  }

  void toggleApprovalRequests(bool value) {
    _approvalRequests = value;
    notifyListeners();
  }

  void toggleDueOrOverdue(bool value) {
    _dueOrOverdue = value;
    notifyListeners();
  }
}