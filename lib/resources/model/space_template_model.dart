import 'package:flutter/material.dart';

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