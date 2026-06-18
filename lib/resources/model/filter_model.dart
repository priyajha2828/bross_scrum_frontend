import 'package:flutter/material.dart';

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