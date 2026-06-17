import 'package:flutter/material.dart';

enum WorkType { epic, story, task, bug }

class WorkTypeOption {
  final WorkType type;
  final String label;
  final String description;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;

  const WorkTypeOption({
    required this.type,
    required this.label,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });

  static const List<WorkTypeOption> all = [
    WorkTypeOption(
      type: WorkType.epic,
      label: 'Epic',
      description: 'Epics track collections of related bugs, stories, and tasks.',
      icon: Icons.bolt,
      iconColor: Color(0xFFB554E0),
      iconBg: Color(0xFFF3E8FF),
    ),
    WorkTypeOption(
      type: WorkType.story,
      label: 'Story',
      description: 'Stories track functionality or features expressed as user goals.',
      icon: Icons.bookmark_border,
      iconColor: Color(0xFF16A34A),
      iconBg: Color(0xFFDCFCE7),
    ),
    WorkTypeOption(
      type: WorkType.task,
      label: 'Task',
      description: 'Tasks track small, distinct pieces of work.',
      icon: Icons.check_circle_outline,
      iconColor: Color(0xFF2563EB),
      iconBg: Color(0xFFDBEAFE),
    ),
    WorkTypeOption(
      type: WorkType.bug,
      label: 'Bug',
      description: 'Bugs track problems or errors in your project.',
      icon: Icons.bug_report_outlined,
      iconColor: Color(0xFFDC2626),
      iconBg: Color(0xFFFEE2E2),
    ),
  ];
}