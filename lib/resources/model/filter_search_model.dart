import 'package:flutter/material.dart';

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