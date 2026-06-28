import 'package:flutter/material.dart';



class CalenderFilter {
  final String label;
  bool isSelected;

  CalenderFilter({required this.label, this.isSelected = false});
}


class CalenderEvent {
  final String id;
  final String title;
  final DateTime date;
  final String? assignee;
  final String? priority;
  final String? type;

  const CalenderEvent({
    required this.id,
    required this.title,
    required this.date,
    this.assignee,
    this.priority,
    this.type,
  });
}

class DayCell {
  final int day;
  final bool isCurrentMonth;
  final DateTime date;
  const DayCell(
      {
        required this.day,
        required this.isCurrentMonth,
        required this.date
      });
}


class CalenderProvider extends ChangeNotifier {
  DateTime _focusedMonth = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  final List<CalenderFilter> filters = [
    CalenderFilter(label: 'Status'),
    CalenderFilter(label: 'Assignee'),
    CalenderFilter(label: 'Priority'),
    CalenderFilter(label: 'Type'),
  ];


  final List<CalenderEvent> _events = [];

  DateTime get focusedMonth => _focusedMonth;
  DateTime get selectedDay => _selectedDay;

  List<CalenderEvent> get eventsForSelectedDay => _events
      .where((e) =>
  e.date.year == _selectedDay.year &&
      e.date.month == _selectedDay.month &&
      e.date.day == _selectedDay.day)
      .toList();

  bool hasEvents(DateTime day) => _events.any((e) =>
  e.date.year == day.year &&
      e.date.month == day.month &&
      e.date.day == day.day);

  void selectDay(DateTime day) {
    _selectedDay = day;
    notifyListeners();
  }

  void previousMonth() {
    _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
    notifyListeners();
  }

  void nextMonth() {
    _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
    notifyListeners();
  }

  void goToToday() {
    _focusedMonth = DateTime.now();
    _selectedDay = DateTime.now();
    notifyListeners();
  }

  void toggleFilter(int index) {
    filters[index].isSelected = !filters[index].isSelected;
    notifyListeners();
  }

  String get focusedMonthLabel {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[_focusedMonth.month - 1]} ${_focusedMonth.year}';
  }
}
