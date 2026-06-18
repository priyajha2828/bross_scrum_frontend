// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../providers/home_screen/all_work/all_work_provider.dart';
// import '../../../resources/color/custom_color.dart';
// import '../../../resources/painter/custom_painter.dart';
// import '../../../routes/app_route.dart';
// import 'filters_screen.dart';
// import 'search_work_screen.dart';
//
// class AllWorkScreen extends StatelessWidget {
//   const AllWorkScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<AllWorkProvider>(context);
//
//     return Scaffold(
//       backgroundColor: CustomColor.bg_color(context),
//       appBar: AppBar(
//         backgroundColor: CustomColor.appbar(context),
//         elevation: 0,
//         leading: Padding(
//           padding: const EdgeInsets.all(10),
//           child: CircleAvatar(
//             backgroundColor: CustomColor.profileAvatarPurple,
//             child: const Text(
//               'PJ',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 13,
//               ),
//             ),
//           ),
//         ),
//         title: Text(
//           'All work',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//             color: CustomColor.textPrimary(context),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search, color: CustomColor.textPrimary(context)),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => const SearchWorkScreen(),
//                 ),
//               );
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.add, color: CustomColor.textPrimary(context)),
//             onPressed: () {
//               Navigator.pushNamed(context, AppRoute.createscreen);
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // ── Filter + View Toggle Row ──
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
//             child: Row(
//               children: [
//                 // Filter selector pill
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const FiltersScreen(),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 14, vertical: 10),
//                       decoration: BoxDecoration(
//                         color: CustomColor.card_bg(context),
//                         borderRadius: BorderRadius.circular(24),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Container(
//                             width: 26,
//                             height: 26,
//                             decoration: BoxDecoration(
//                               color: provider.selectedFilter.iconBg,
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             child: Icon(
//                               provider.selectedFilter.icon,
//                               size: 16,
//                               color: provider.selectedFilter.iconColor,
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           Flexible(
//                             child: Text(
//                               provider.selectedFilter.name,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: CustomColor.textPrimary(context),
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 4),
//                           Icon(
//                             Icons.keyboard_arrow_down,
//                             size: 18,
//                             color: CustomColor.textMutedLabel(context),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(width: 8),
//
//                 // List view toggle
//                 _ViewToggleButton(
//                   icon: Icons.format_list_bulleted,
//                   isSelected: provider.isListView,
//                   onTap: () {
//                     if (!provider.isListView) provider.toggleView();
//                   },
//                 ),
//
//                 const SizedBox(width: 8),
//
//                 // Grid view toggle
//                 _ViewToggleButton(
//                   icon: Icons.grid_view,
//                   isSelected: !provider.isListView,
//                   onTap: () {
//                     if (provider.isListView) provider.toggleView();
//                   },
//                 ),
//               ],
//             ),
//           ),
//
//           // ── Empty State ──
//           Expanded(
//             child: Center(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       width: 180,
//                       height: 180,
//                       child: CustomPaint(
//                         painter: ConfettiPartyPainter(),
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     Text(
//                       'No work assigned… Nice!',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700,
//                         color: CustomColor.textPrimary(context),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       "When you're assigned new work items, they'll appear here",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: CustomColor.textMutedLabel(context),
//                         height: 1.4,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, AppRoute.createscreen);
//                       },
//                       child: Text(
//                         'Create issue',
//                         style: TextStyle(
//                           color: CustomColor.actionBlueText(context),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _ViewToggleButton extends StatelessWidget {
//   final IconData icon;
//   final bool isSelected;
//   final VoidCallback onTap;
//
//   const _ViewToggleButton({
//     required this.icon,
//     required this.isSelected,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 42,
//         height: 42,
//         decoration: BoxDecoration(
//           color: isSelected
//               ? CustomColor.chipSelectedBg(context)
//               : CustomColor.card_bg(context),
//           borderRadius: BorderRadius.circular(21),
//         ),
//         child: Icon(
//           icon,
//           size: 20,
//           color: isSelected
//               ? CustomColor.chipSelectedText(context)
//               : CustomColor.textMutedLabel(context),
//         ),
//       ),
//     );
//   }
// }