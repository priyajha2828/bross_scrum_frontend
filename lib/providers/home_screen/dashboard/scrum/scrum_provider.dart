
import 'package:flutter/material.dart';
import '../../../../resources/model/custom_model.dart';

class ScrumProvider extends ChangeNotifier {
  final String issueKey;
  final String initialTitle;
  final TextEditingController labelsController = TextEditingController();
  final TextEditingController storyPointsController = TextEditingController();
List<String> _watchers = ["Priya jha"];

  String _title;
  String _status = 'To Do';
  String _description = '';
  String _issueType = 'Epic';
  AssigneeModel? _assignee;
  String _project = 'app1';
  List<String> _labels = [];
  List<String> _comments = [];
  TeamModel? _teamModel;
  DateTime? _dueDate;
  DateTime? _startDate;
  SprintModel? _sprintModel;
  int? _storyPoints;
  String _reporter = 'Project Admin';
  String? _atlassianProject;
  DateTime _createdAt = DateTime.now();
  DateTime _updatedAt = DateTime.now();
  bool _commentsNewestFirst = true;

  ScrumProvider({
    this.issueKey = '',
    this.initialTitle = '',
  }) : _title = initialTitle;

  String get title => _title;
  String get status => _status;
  String get description => _description;
  String get issueType => _issueType;
  AssigneeModel? get assignee => _assignee;
  String get project => _project;
  List<String> get labels => List.unmodifiable(_labels);
  List<String> get comments => _commentsNewestFirst
      ? _comments.reversed.toList()
      : List.unmodifiable(_comments);
  TeamModel? get teamModel => _teamModel;
  String? get team => _teamModel?.name;
  DateTime? get dueDate => _dueDate;
  DateTime? get startDate => _startDate;
  SprintModel? get sprintModel => _sprintModel;
  String? get sprint => _sprintModel?.name;
  int? get storyPoints => _storyPoints;
  String get reporter => _reporter;
  String? get atlassianProject => _atlassianProject;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;
  bool get commentsNewestFirst => _commentsNewestFirst;
  List<String> get watchers => List.unmodifiable(_watchers);

  @override
  void dispose() {
    labelsController.dispose();
    storyPointsController.dispose();
    super.dispose();
  }

  void addLabelFromController() {
    final text = labelsController.text.trim();
    if (text.isNotEmpty && !_labels.contains(text)) {
      _labels.add(text);
      labelsController.clear();
      _touch();
    }
  }

  void updateTitle(String text) { _title = text; _touch(); }
  void updateStatus(String newStatus) { _status = newStatus; _touch(); }
  void updateDescription(String text) { _description = text; _touch(); }
  void updateIssueType(String type) { _issueType = type; _touch(); }
  void setAssignee(AssigneeModel? assignee) { _assignee = assignee; _touch(); }

  void setTeam(TeamModel? team) { _teamModel = team; _touch(); }
  void setDueDate(DateTime? date) { _dueDate = date; _touch(); }
  void setStartDate(DateTime? date) { _startDate = date; _touch(); }

  void setSprint(SprintModel? sprint) {
    _sprintModel = sprint;
    _touch();
  }

  void updateStoryPointsFromController() {
    final val = int.tryParse(storyPointsController.text.trim());
    _storyPoints = val;
    _touch();
  }
void updateWatchers(List<String> list){
    _watchers = List<String>.from(list);
    _touch();
}

void addWatcher(String name){
    if(!_watchers.contains(name)){
      _watchers.add(name);
      _touch();
    }
}
void removeWatcher(String name){
    _watchers.remove(name);
    _touch();
}
  void addLabel(String label) {
    if (!_labels.contains(label)) { _labels.add(label); _touch(); }
  }

  void removeLabel(String label) { _labels.remove(label); _touch(); }

  void addComment(String comment) {
    if (comment.trim().isNotEmpty) { _comments.add(comment.trim()); _touch(); }
  }

  void updateAssignee(String name) {
    _assignee = name == 'Unassigned' || name == 'Automatic'
        ? null
        : AssigneeModel(
      name: name,
      initials: _computeInitials(name),
      avatarColor: _generateAvatarColor(name),
    );
    _touch();
  }

  void updateReporter(String name) { _reporter = name; _touch(); }
  void updateAtlassianProject(String? project) { _atlassianProject = project; _touch(); }

  void toggleCommentOrder() {
    _commentsNewestFirst = !_commentsNewestFirst;
    notifyListeners();
  }

  String _computeInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    if (parts.isNotEmpty && parts[0].isNotEmpty) return parts[0][0].toUpperCase();
    return '?';
  }

  Color _generateAvatarColor(String name) {
    const colors = [
      Color(0xFF5B21B6),
      Color(0xFF2563EB),
      Color(0xFF16A34A),
      Color(0xFFDC2626),
      Color(0xFFD97706),
      Color(0xFF0891B2),
    ];
    return colors[name.hashCode.abs() % colors.length];
  }

  void _touch() {
    _updatedAt = DateTime.now();
    notifyListeners();
  }
}