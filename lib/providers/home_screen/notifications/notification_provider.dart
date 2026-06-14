import 'package:flutter/material.dart';

enum NotificationFilter { direct, unread }

class NotificationsProvider extends ChangeNotifier {
  NotificationFilter _selectedFilter = NotificationFilter.direct;
  NotificationFilter get selectedFilter => _selectedFilter;

  bool _isSnoozed = false;
  bool get isSnoozed => _isSnoozed;

  Duration? _activeSnoozeDuration;
  Duration? get activeSnoozeDuration => _activeSnoozeDuration;

  void setFilter(NotificationFilter filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  void clearFilters() {
    _selectedFilter = NotificationFilter.direct;
    notifyListeners();
  }

  void snoozeNotifications(Duration duration) {
    _isSnoozed = true;
    _activeSnoozeDuration = duration;
    notifyListeners();
  }

  void turnOffSnooze() {
    _isSnoozed = false;
    _activeSnoozeDuration = null;
    notifyListeners();
  }
}