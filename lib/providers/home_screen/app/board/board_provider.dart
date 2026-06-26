import 'package:flutter/material.dart';

class BoardTask {
  final String id;
  final String title;
  final String? subtitle;

  const BoardTask({required this.id, required this.title, this.subtitle});
}

class BoardColumn {
  final String id;
  final String title;
  final List<BoardTask> tasks;

  BoardColumn({required this.id, required this.title, required this.tasks});
  int get taskCount => tasks.length;
}

class BoardProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<BoardColumn> _column = [
    BoardColumn(id: 'todo', title: 'TO DO', tasks: []),
    BoardColumn(id: 'in_progress', title: "IN PROGRESS", tasks: []),
    BoardColumn(id: 'done', title: 'DONE', tasks: []),
  ];

  List<BoardColumn> get columns => _column;

  Future<void> refresh() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 400));

    _isLoading = false;
    notifyListeners();
  }

  void addColumn(String title) {
    _column = [
      ..._column,
      BoardColumn(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: title.toUpperCase(),
        tasks: [],
      ),
    ];
    notifyListeners();
  }
}
