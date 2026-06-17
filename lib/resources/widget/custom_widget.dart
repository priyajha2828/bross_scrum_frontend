// import 'package:flutter/material.dart';
//
//
// class PopupMenuHeaderWidget extends PopupMenuWidget<String> {
//   final Widget child;
//   final double customHeight;
//
//   const PopupMenuHeaderWidget({
//     super.key,
//     required this.child,
//     this.customHeight = 40.0,
//   });
//
//   @override
//   double get height => customHeight;
//
//   @override
//   bool represents(String? value) => false;
//
//   @override
//   State<PopupMenuHeaderWidget> createState() => _PopupMenuHeaderWidgetState();
// }
//
// class _PopupMenuHeaderWidgetState extends State<PopupMenuHeaderWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }