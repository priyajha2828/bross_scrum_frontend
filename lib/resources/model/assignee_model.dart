import 'package:flutter/material.dart';
import '../../../../resources/color/custom_color.dart';

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

