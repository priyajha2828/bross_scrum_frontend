// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:BrossScrum/resources/color/custom_color.dart';
// import 'board_provider.dart';
// import 'board_widgets.dart';
//
// class BoardPageScreen extends StatefulWidget {
//   const BoardPageScreen({super.key});
//
//   @override
//   State<BoardPageScreen> createState() => _BoardPageScreenState();
// }
//
// class _BoardPageScreenState extends State<BoardPageScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<BoardProvider>().refresh();
//     });
//   }
//
//   void _showAddColumnDialog() {
//     final controller = TextEditingController();
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         backgroundColor: CustomColor.card_bg(context),
//         title: Text(
//           'New column',
//           style: TextStyle(color: CustomColor.textPrimary(context)),
//         ),
//         content: TextField(
//           controller: controller,
//           autofocus: true,
//           style: TextStyle(color: CustomColor.textPrimary(context)),
//           decoration: InputDecoration(
//             hintText: 'Column name',
//             hintStyle:
//             TextStyle(color: CustomColor.textMutedLabel(context)),
//             enabledBorder: UnderlineInputBorder(
//               borderSide:
//               BorderSide(color: CustomColor.dividerColor(context)),
//             ),
//             focusedBorder: const UnderlineInputBorder(
//               borderSide: BorderSide(color: Color(0xFF2563EB)),
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel',
//                 style:
//                 TextStyle(color: CustomColor.textMutedLabel(context))),
//           ),
//           TextButton(
//             onPressed: () {
//               if (controller.text.trim().isNotEmpty) {
//                 context
//                     .read<BoardProvider>()
//                     .addColumn(controller.text.trim());
//                 Navigator.pop(context);
//               }
//             },
//             child: const Text('Add',
//                 style: TextStyle(color: Color(0xFF2563EB))),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<BoardProvider>();
//
//     if (provider.isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ── Board columns ────────────────────────────────────────
//           ...provider.columns.map(
//                 (col) => BoardColumnCard(
//               column: col,
//               onMenuTap: () {
//                 // TODO: show column menu
//               },
//             ),
//           ),
//
//           // ── Add column button ────────────────────────────────────
//           AddColumnButton(onTap: _showAddColumnDialog),
//         ],
//       ),
//     );
//   }
// }
//
// //provider
// import 'package:flutter/material.dart';
//
// // ── Task model ─────────────────────────────────────────────────────────────────
//
// class BoardTask {
//   final String id;
//   final String title;
//   final String? subtitle;
//
//   const BoardTask({
//     required this.id,
//     required this.title,
//     this.subtitle,
//   });
// }
//
// // ── Column model ───────────────────────────────────────────────────────────────
//
// class BoardColumn {
//   final String id;
//   final String title;
//   final List<BoardTask> tasks;
//
//   BoardColumn({
//     required this.id,
//     required this.title,
//     required this.tasks,
//   });
//
//   int get taskCount => tasks.length;
// }
//
// // ── BoardProvider ──────────────────────────────────────────────────────────────
//
// class BoardProvider extends ChangeNotifier {
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   List<BoardColumn> _columns = [
//     BoardColumn(id: 'todo',        title: 'TO DO',       tasks: []),
//     BoardColumn(id: 'in_progress', title: 'IN PROGRESS', tasks: []),
//     BoardColumn(id: 'done',        title: 'DONE',        tasks: []),
//   ];
//
//   List<BoardColumn> get columns => _columns;
//
//   Future<void> refresh() async {
//     _isLoading = true;
//     notifyListeners();
//
//     // TODO: replace with real API call
//     await Future.delayed(const Duration(milliseconds: 400));
//
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   void addColumn(String title) {
//     _columns = [
//       ..._columns,
//       BoardColumn(
//         id: DateTime.now().millisecondsSinceEpoch.toString(),
//         title: title.toUpperCase(),
//         tasks: [],
//       ),
//     ];
//     notifyListeners();
//   }
// }
//
// //widgets
//
// import 'package:flutter/material.dart';
// import 'package:BrossScrum/resources/color/custom_color.dart';
// import 'board_provider.dart';
//
// // ─────────────────────────────────────────────────────────────────────────────
// // 1. Board column card  (TO DO / IN PROGRESS / DONE …)
// // ─────────────────────────────────────────────────────────────────────────────
//
// class BoardColumnCard extends StatelessWidget {
//   final BoardColumn column;
//   final VoidCallback? onMenuTap;
//
//   const BoardColumnCard({
//     super.key,
//     required this.column,
//     this.onMenuTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isEmpty = column.tasks.isEmpty;
//
//     return Container(
//       width: MediaQuery.of(context).size.width - 32,
//       margin: const EdgeInsets.only(right: 12),
//       decoration: BoxDecoration(
//         color: CustomColor.isDark(context)
//             ? const Color(0xFF1F2937)
//             : const Color(0xFFE8EAED),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ── Column header ─────────────────────────────────────────
//           Padding(
//             padding:
//             const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//             child: Row(
//               children: [
//                 Text(
//                   '${column.title}  ${column.taskCount}',
//                   style: TextStyle(
//                     color: CustomColor.textMutedLabel(context),
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     letterSpacing: 0.4,
//                   ),
//                 ),
//                 const Spacer(),
//                 GestureDetector(
//                   onTap: onMenuTap,
//                   child: Icon(
//                     Icons.more_vert,
//                     color: CustomColor.textMutedLabel(context),
//                     size: 20,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // ── Tasks or empty state ──────────────────────────────────
//           if (isEmpty && column.id == 'todo')
//             _EmptyBoardState(context: context)
//           else if (isEmpty)
//             const SizedBox(height: 300) // empty column placeholder
//           else
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               padding:
//               const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//               itemCount: column.tasks.length,
//               itemBuilder: (_, i) =>
//                   _TaskCard(task: column.tasks[i]),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────────
// // 2. Empty state  (only shown on TO DO column)
// // ─────────────────────────────────────────────────────────────────────────────
//
// class _EmptyBoardState extends StatelessWidget {
//   final BuildContext context;
//   const _EmptyBoardState({required this.context});
//
//   @override
//   Widget build(BuildContext ctx) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//       child: Column(
//         children: [
//           // Jira-style stacked bar illustration
//           _JiraIllustration(),
//           const SizedBox(height: 28),
//           Text(
//             'No work yet!',
//             style: TextStyle(
//               color: CustomColor.textPrimary(context),
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             "Your team's work will appear here when you start a sprint from the backlog.",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: CustomColor.textMutedLabel(context),
//               fontSize: 14,
//               height: 1.5,
//             ),
//           ),
//           const SizedBox(height: 24),
//           // View backlog button
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.list_alt_rounded,
//                   color: CustomColor.actionBlueText(context), size: 20),
//               const SizedBox(width: 8),
//               Text(
//                 'View backlog',
//                 style: TextStyle(
//                   color: CustomColor.actionBlueText(context),
//                   fontSize: 15,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//         ],
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────────
// // 3. Jira-style illustration  (blue + orange bars)
// // ─────────────────────────────────────────────────────────────────────────────
//
// class _JiraIllustration extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     const blue   = Color(0xFF2C6ECB);
//     const orange = Color(0xFFFF8B00);
//     const dark   = Color(0xFF2C4A7C);
//
//     return SizedBox(
//       width: 160,
//       height: 140,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           // vertical dark line
//           Positioned(
//             left: 78,
//             top: 10,
//             bottom: 10,
//             child: Container(width: 3, color: dark),
//           ),
//           // orange triangle (top)
//           Positioned(
//             top: 10,
//             left: 65,
//             child: CustomPaint(
//               size: const Size(30, 20),
//               painter: _TrianglePainter(color: orange),
//             ),
//           ),
//           // blue bar 1 (widest)
//           Positioned(
//             top: 30,
//             left: 10,
//             child: Container(
//               width: 140,
//               height: 28,
//               decoration: BoxDecoration(
//                 color: blue,
//                 borderRadius: BorderRadius.circular(3),
//               ),
//             ),
//           ),
//           // blue bar 2 (medium)
//           Positioned(
//             top: 68,
//             left: 40,
//             child: Container(
//               width: 90,
//               height: 24,
//               decoration: BoxDecoration(
//                 color: blue,
//                 borderRadius: BorderRadius.circular(3),
//               ),
//             ),
//           ),
//           // orange bar (middle)
//           Positioned(
//             top: 78,
//             left: 20,
//             child: Container(
//               width: 130,
//               height: 20,
//               decoration: BoxDecoration(
//                 color: orange,
//                 borderRadius: BorderRadius.circular(3),
//               ),
//             ),
//           ),
//           // blue bar 3 (narrow)
//           Positioned(
//             top: 104,
//             left: 30,
//             child: Container(
//               width: 80,
//               height: 24,
//               decoration: BoxDecoration(
//                 color: blue,
//                 borderRadius: BorderRadius.circular(3),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _TrianglePainter extends CustomPainter {
//   final Color color;
//   const _TrianglePainter({required this.color});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = color;
//     final path = Path()
//       ..moveTo(size.width / 2, size.height)
//       ..lineTo(0, 0)
//       ..lineTo(size.width, 0)
//       ..close();
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(_TrianglePainter old) => old.color != color;
// }
//
// // ─────────────────────────────────────────────────────────────────────────────
// // 4. Task card
// // ─────────────────────────────────────────────────────────────────────────────
//
// class _TaskCard extends StatelessWidget {
//   final BoardTask task;
//   const _TaskCard({required this.task});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: CustomColor.card_bg(context),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             task.title,
//             style: TextStyle(
//               color: CustomColor.textPrimary(context),
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           if (task.subtitle != null) ...[
//             const SizedBox(height: 4),
//             Text(
//               task.subtitle!,
//               style: TextStyle(
//                 color: CustomColor.textMutedLabel(context),
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────────
// // 5. Add column button
// // ─────────────────────────────────────────────────────────────────────────────
//
// class AddColumnButton extends StatelessWidget {
//   final VoidCallback onTap;
//   const AddColumnButton({super.key, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: MediaQuery.of(context).size.width - 32,
//         margin: const EdgeInsets.only(right: 12),
//         padding: const EdgeInsets.symmetric(vertical: 16),
//         decoration: BoxDecoration(
//           color: CustomColor.card_bg(context),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: CustomColor.dividerColor(context),
//           ),
//         ),
//         child: Center(
//           child: Text(
//             'Add column',
//             style: TextStyle(
//               color: CustomColor.actionBlueText(context),
//               fontSize: 15,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
