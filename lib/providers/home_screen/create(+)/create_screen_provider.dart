import 'package:flutter/material.dart';
import 'package:BrossScrum/resources/model/assignee_model.dart';
import 'package:BrossScrum/resources/model/parent_model.dart';
import 'package:BrossScrum/resources/model/team_model.dart';
import 'package:BrossScrum/resources/model/work_type_model.dart';
import 'package:BrossScrum/resources/model/sprint_model.dart';

import '../../../resources/model/report_model.dart'; // ← added

class CreateProvider extends ChangeNotifier {
  WorkType _selectedWorkType = WorkType.epic;
  String _summary = '';
  String _description = '';
  TeamModel? _teamModel;
  AssigneeModel? _assignee;
  ReportModel? _report;
  DateTime? _startDate;
  DateTime? _dueDate;
  int? _storyPoints;
  Color? _issueColor;
  SprintModel? _sprintModel;          // ← changed from String?
  bool _flagged = false;
  String? _labels;
  ParentModel? _parent;
  String? _reporter;
  bool _showMore = false;

  String _selectedApp = 'app1';
  final List<String> _appList = ['app1', 'app2'];

  final TextEditingController _labelsController = TextEditingController();
  TextEditingController get labelsController => _labelsController;

  CreateProvider() {
    _labelsController.addListener(() {
      _labels = _labelsController.text;
    });
  }

  @override
  void dispose() {
    _labelsController.dispose();
    super.dispose();
  }

  // Getters
  WorkType get selectedWorkType => _selectedWorkType;
  String get summary => _summary;
  String get description => _description;
  String get team => _teamModel?.name ?? 'None';
  TeamModel? get teamModel => _teamModel;
  AssigneeModel? get assignee => _assignee;
  ReportModel? get report => _report;
  DateTime? get startDate => _startDate;
  DateTime? get dueDate => _dueDate;
  int? get storyPoints => _storyPoints;
  Color? get issueColor => _issueColor;
  String get sprint => _sprintModel?.name ?? 'None'; // ← changed
  SprintModel? get sprintModel => _sprintModel;       // ← added
  bool get flagged => _flagged;
  String? get labels => _labels;
  ParentModel? get parent => _parent;
  String? get reporter => _reporter;
  bool get showMore => _showMore;
  String get selectedApp => _selectedApp;
  List<String> get appList => _appList;

  // WorkType options from model
  List<WorkTypeOption> get workTypeOptions => WorkTypeOption.all;

  WorkTypeOption get selectedWorkTypeOption =>
      WorkTypeOption.all.firstWhere((o) => o.type == _selectedWorkType);

  void setApp(String appName) { _selectedApp = appName; notifyListeners(); }
  void setWorkType(WorkType type) { _selectedWorkType = type; notifyListeners(); }
  void setSummary(String value) { _summary = value; notifyListeners(); }
  void setDescription(String value) { _description = value; notifyListeners(); }
  void setTeam(TeamModel? value) { _teamModel = value; notifyListeners(); }
  void setAssignee(AssigneeModel? value) { _assignee = value; notifyListeners(); }
  void setReport(ReportModel? value) { _report = value; notifyListeners(); }
  void setStartDate(DateTime? value) { _startDate = value; notifyListeners(); }
  void setDueDate(DateTime? value) { _dueDate = value; notifyListeners(); }
  void setStoryPoints(int? value) { _storyPoints = value; notifyListeners(); }
  void setIssueColor(Color? value) { _issueColor = value; notifyListeners(); }
  void setSprint(SprintModel? value) { _sprintModel = value; notifyListeners(); } // ← changed
  void toggleFlagged() { _flagged = !_flagged; notifyListeners(); }
  void setLabels(String? value) { _labels = value; notifyListeners(); }
  void setParent(ParentModel? value) { _parent = value; notifyListeners(); }
  void setReporter(String? value) { _reporter = value; notifyListeners(); }
  void toggleShowMore() { _showMore = !_showMore; notifyListeners(); }

  bool get canCreate => _summary.trim().isNotEmpty && _reporter != null;
}