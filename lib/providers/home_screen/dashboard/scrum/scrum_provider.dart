import 'package:flutter/material.dart';

class ScrumProvider extends ChangeNotifier {
  final String issueKey;
  final String initialTitle;

  String _title;
  String _status = 'To Do';
  String _description = '';
  String _issueType = 'Epic';
  String _assignee = 'Unassigned';
  String _project = 'app1';
  List<String> _labels = [];
  List<String> _comments = [];

  ScrumProvider({
    this.issueKey = '',
    this.initialTitle = '',
  }) : _title = initialTitle;

  String get title => _title;
  String get status => _status;
  String get description => _description;
  String get issueType => _issueType;
  String get assignee => _assignee;
  String get project => _project;
  List<String> get labels => List.unmodifiable(_labels);
  List<String> get comments => List.unmodifiable(_comments);

  void updateTitle(String text) {
    _title = text;
    notifyListeners();
  }

  void updateStatus(String newStatus) {
    _status = newStatus;
    notifyListeners();
  }

  void updateDescription(String text) {
    _description = text;
    notifyListeners();
  }

  void updateIssueType(String type) {
    _issueType = type;
    notifyListeners();
  }

  void updateAssignee(String name) {
    _assignee = name;
    notifyListeners();
  }

  void addLabel(String label) {
    if (!_labels.contains(label)) {
      _labels.add(label);
      notifyListeners();
    }
  }

  void removeLabel(String label) {
    _labels.remove(label);
    notifyListeners();
  }

  void addComment(String comment) {
    if (comment.trim().isNotEmpty) {
      _comments.add(comment.trim());
      notifyListeners();
    }
  }
}