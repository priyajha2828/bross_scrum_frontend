import 'package:flutter/material.dart';

class SummaryPageProvider extends ChangeNotifier{
  bool _isLoading = false;
  SummaryStats _stats = SummaryStats.empty();

  bool get isLoading => _isLoading;
  SummaryStats get stats => _stats;

  int get maxPriorityCount {
    final values = _stats.priorityBreakdown.values;
    if (values.isEmpty) return 2;
    final max = values.reduce((a, b) => a > b ? a : b);
    return max < 2 ? 2 : max;
  }

  String get lastRefreshedLabel {
    final diff = DateTime.now().difference(_stats.lastRefreshed);
    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    return '${diff.inHours}h ago';
  }

  Future<void> refresh() async {
    _isLoading = true;
    notifyListeners();


    await Future.delayed(const Duration(milliseconds: 600));

    _stats = SummaryStats(
      completed: 0,
      updated: 0,
      created: 0,
      dueSoon: 0,
      totalWorkItems: 0,
      priorityBreakdown: {
        for (final p in Priority.values) p: 0,
      },
      lastRefreshed: DateTime.now(),
    );

    _isLoading = false;
    notifyListeners();
  }
}



enum Priority { highest, high, medium,low,lowest}

extension PriorityExt on Priority{
String get label {
  switch (this) {
    case Priority.highest: return 'Highest';
    case Priority.high:    return 'High';
    case Priority.medium:  return 'Medium';
    case Priority.low:     return 'Low';
    case Priority.lowest:  return 'Lowest';
  }
}

Color get color {
  switch (this) {
    case Priority.highest: return const Color(0xFFE53935);
    case Priority.high:    return const Color(0xFFEF5350);
    case Priority.medium:  return const Color(0xFFFF9800);
    case Priority.low:     return const Color(0xFF1E88E5);
    case Priority.lowest:  return const Color(0xFF1E88E5);
  }
}

IconData get icon {
  switch (this) {
    case Priority.highest: return Icons.keyboard_double_arrow_up_rounded;
    case Priority.high:    return Icons.keyboard_arrow_up_rounded;
    case Priority.medium:  return Icons.drag_handle_rounded;
    case Priority.low:     return Icons.keyboard_arrow_down_rounded;
    case Priority.lowest:  return Icons.keyboard_double_arrow_down_rounded;
  }
}
}

class SummaryStats {
  final int completed;
  final int updated;
  final int created;
  final int dueSoon;
  final int totalWorkItems;
  final Map<Priority, int> priorityBreakdown;
  final DateTime lastRefreshed;

  SummaryStats({
    required this.completed,
    required this.updated,
    required this.created,
    required this.dueSoon,
    required this.totalWorkItems,
    required this.priorityBreakdown,
    required this.lastRefreshed,
  });

  factory SummaryStats.empty() => SummaryStats(
    completed: 0,
    updated: 0,
    created: 0,
    dueSoon: 0,
    totalWorkItems: 0,
    priorityBreakdown: {
      for (final p in Priority.values) p: 0,
    },
    lastRefreshed: DateTime.now(),
  );
}


