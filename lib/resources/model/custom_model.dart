import 'package:flutter/material.dart';


class AssigneeModel {
  final String name;
  final String initials;
  final Color avatarColor;

  const AssigneeModel({
    required this.name,
    required this.initials,
    required this.avatarColor,
  });
}

enum FilterSection { starred, recent, default_ }

class FilterModel {
  final String name;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final FilterSection section;
  bool isStarred;

  FilterModel({
    required this.name,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.section,
    this.isStarred = false,
  });
}

class FilterOptionModel{
  final String label;
  final String? subtitle;
  final IconData? icon;
  final Color? iconBg;
  final Color? iconColor;
  final Color? badgeColor;
  final Color? badgeTextColor;

  const FilterOptionModel({
    required this.label,
    this.subtitle,
    this.icon,
    this.iconBg,
    this.iconColor,
    this.badgeColor,
    this.badgeTextColor
  });
}

enum SearchType {basic , jql , aiSearch}

class ParentModel {
  final String name;
  final String type;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;

  const ParentModel({
    required this.name,
    required this.type,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });
}

class ReportModel {
  final String name;
  final String initials;
  final Color avatarColor;

  const ReportModel({
    required this.name,
    required this.initials,
    required this.avatarColor,
  });
}
class SpaceTemplateModel {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;

  const SpaceTemplateModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
  });
}

class SprintModel {
  final String name;
  final String subtitle;
  final String type; // 'none' | 'active' | 'future'

  const SprintModel({
    required this.name,
    required this.subtitle,
    required this.type,
  });
}

class TeamModel {
  final String name;
  final String initials;
  final Color avatarColor;

  const TeamModel({
    required this.name,
    required this.initials,
    required this.avatarColor,
  });
}

class WatchersModel {
  final String name;
  final String initials;
  final Color avatarColor;

  const WatchersModel({
    required this.name,
    required this.initials,
    required this.avatarColor,
  });
}
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

class BoardModel{
  final String name;
  final String? subtitle;
  final Color iconBgColor;
  final Widget icon;
  final void Function(BuildContext context)? onTap;

  const BoardModel({
    required this.name,
    this.subtitle,
    required this.iconBgColor,
    required this.icon,
    this.onTap
});
}
