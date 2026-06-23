import 'package:flutter/material.dart';

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
class WatchersBottomSheet extends StatefulWidget {
  const WatchersBottomSheet({super.key});

  @override
  State<WatchersBottomSheet> createState() => _WatchersBottomSheetState();
}

class _WatchersBottomSheetState extends State<WatchersBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
