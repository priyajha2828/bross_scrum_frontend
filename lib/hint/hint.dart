
// import 'package:flutter/material.dart';
// import 'package:BrossScrum/resources/color/custom_color.dart';
// import 'calendar_provider.dart';
//
// // ─────────────────────────────────────────────────────────────────────────────
// // 1. Filter chips row  (Status / Assignee / Priority / Type)
// // ─────────────────────────────────────────────────────────────────────────────
//
// class CalendarFilterRow extends StatelessWidget {
//   final List<CalendarFilter> filters;
//   final void Function(int) onToggle;
//
//   const CalendarFilterRow({
//     super.key,
//     required this.filters,
//     required this.onToggle,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         children: List.generate(filters.length, (i) {
//           final f = filters[i];
//           return Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: GestureDetector(
//               onTap: () => onToggle(i),
//               child: Container(
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
//                 decoration: BoxDecoration(
//                   color: CustomColor.card_bg(context),
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(
//                     color: f.isSelected
//                         ? const Color(0xFF2563EB)
//                         : CustomColor.dividerColor(context),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       f.label,
//                       style: TextStyle(
//                         color: f.isSelected
//                             ? const Color(0xFF2563EB)
//                             : CustomColor.textPrimary(context),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(width: 4),
//                     Icon(
//                       Icons.keyboard_arrow_down_rounded,
//                       size: 18,
//                       color: f.isSelected
//                           ? const Color(0xFF2563EB)
//                           : CustomColor.textMutedLabel(context),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────────
// // 2. Calendar card  (month header + day grid)
// // ─────────────────────────────────────────────────────────────────────────────
//
// class CalendarCard extends StatelessWidget {
//   final CalendarProvider provider;
//
//   const CalendarCard({super.key, required this.provider});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: CustomColor.card_bg(context),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         children: [
//           _CalendarHeader(provider: provider),
//           const SizedBox(height: 12),
//           _WeekdayRow(),
//           const SizedBox(height: 4),
//           _DayGrid(provider: provider),
//         ],
//       ),
//     );
//   }
// }
//
// // ── Month header ───────────────────────────────────────────────────────────────
//
// class _CalendarHeader extends StatelessWidget {
//   final CalendarProvider provider;
//   const _CalendarHeader({required this.provider});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         // Month + year dropdown
//         GestureDetector(
//           onTap: () {}, // TODO: month picker
//           child: Row(
//             children: [
//               Text(
//                 provider.focusedMonthLabel,
//                 style: TextStyle(
//                   color: CustomColor.textPrimary(context),
//                   fontSize: 15,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(width: 4),
//               Icon(Icons.arrow_drop_down,
//                   color: CustomColor.textMutedLabel(context), size: 20),
//             ],
//           ),
//         ),
//         const Spacer(),
//         // Today button
//         GestureDetector(
//           onTap: provider.goToToday,
//           child: const Text(
//             'Today',
//             style: TextStyle(
//               color: Color(0xFF2563EB),
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         const SizedBox(width: 16),
//         // Prev
//         GestureDetector(
//           onTap: provider.previousMonth,
//           child: Icon(Icons.chevron_left,
//               color: CustomColor.textPrimary(context), size: 22),
//         ),
//         const SizedBox(width: 8),
//         // Next
//         GestureDetector(
//           onTap: provider.nextMonth,
//           child: Icon(Icons.chevron_right,
//               color: CustomColor.textPrimary(context), size: 22),
//         ),
//       ],
//     );
//   }
// }
//
// // ── Weekday row ────────────────────────────────────────────────────────────────
//
// class _WeekdayRow extends StatelessWidget {
//   static const _days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: _days
//           .map(
//             (d) => Expanded(
//           child: Center(
//             child: Text(
//               d,
//               style: TextStyle(
//                 color: CustomColor.textMutedLabel(context),
//                 fontSize: 13,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ),
//       )
//           .toList(),
//     );
//   }
// }
//
// // ── Day grid ───────────────────────────────────────────────────────────────────
//
// class _DayGrid extends StatelessWidget {
//   final CalendarProvider provider;
//   const _DayGrid({required this.provider});
//
//   @override
//   Widget build(BuildContext context) {
//     final month = provider.focusedMonth;
//     final today = DateTime.now();
//     final selected = provider.selectedDay;
//
//     // First day of month
//     final firstDay = DateTime(month.year, month.month, 1);
//     // Weekday offset (0=Sun … 6=Sat)
//     final startOffset = firstDay.weekday % 7;
//     // Days in month
//     final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
//     // Days in previous month
//     final daysInPrevMonth = DateTime(month.year, month.month, 0).day;
//
//     // Build flat list of day cells
//     final cells = <_DayCell>[];
//
//     // Prev month trailing days
//     for (int i = startOffset - 1; i >= 0; i--) {
//       cells.add(_DayCell(
//         day: daysInPrevMonth - i,
//         isCurrentMonth: false,
//         date: DateTime(month.year, month.month - 1, daysInPrevMonth - i),
//       ));
//     }

//     // Current month days
//     for (int d = 1; d <= daysInMonth; d++) {
//       cells.add(_DayCell(
//         day: d,
//         isCurrentMonth: true,
//         date: DateTime(month.year, month.month, d),
//       ));
//     }
//
//     // Next month leading days — fill to complete grid rows
//     final remaining = (7 - (cells.length % 7)) % 7;
//     for (int d = 1; d <= remaining; d++) {
//       cells.add(_DayCell(
//         day: d,
//         isCurrentMonth: false,
//         date: DateTime(month.year, month.month + 1, d),
//       ));
//     }
//
//     // Build rows of 7
//     final rows = <Widget>[];
//     for (int i = 0; i < cells.length; i += 7) {
//       final week = cells.sublist(i, i + 7);
//       rows.add(
//         Row(
//           children: week.map((cell) {
//             final isToday = cell.date.year == today.year &&
//                 cell.date.month == today.month &&
//                 cell.date.day == today.day;
//             final isSelected = cell.date.year == selected.year &&
//                 cell.date.month == selected.month &&
//                 cell.date.day == selected.day;
//             final hasEvent = provider.hasEvents(cell.date);
//
//             return Expanded(
//               child: GestureDetector(
//                 onTap: () => provider.selectDay(cell.date),
//                 child: Container(
//                   height: 44,
//                   alignment: Alignment.center,
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       // Selected / today circle
//                       if (isSelected)
//                         Container(
//                           width: 36,
//                           height: 36,
//                           decoration: const BoxDecoration(
//                             color: Color(0xFF2563EB),
//                             shape: BoxShape.circle,
//                           ),
//                         )
//                       else if (isToday)
//                         Container(
//                           width: 36,
//                           height: 36,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                               color: CustomColor.textMutedLabel(context),
//                               width: 1.5,
//                             ),
//                           ),
//                         ),
//                       // Day number
//                       Text(
//                         '${cell.day}',
//                         style: TextStyle(
//                           color: isSelected
//                               ? Colors.white
//                               : cell.isCurrentMonth
//                               ? CustomColor.textPrimary(context)
//                               : CustomColor.textMutedLabel(context),
//                           fontSize: 14,
//                           fontWeight: isSelected || isToday
//                               ? FontWeight.w600
//                               : FontWeight.w400,
//                         ),
//                       ),
//                       // Event dot
//                       if (hasEvent && !isSelected)
//                         Positioned(
//                           bottom: 4,
//                           child: Container(
//                             width: 5,
//                             height: 5,
//                             decoration: const BoxDecoration(
//                               color: Color(0xFF2563EB),
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       );
//     }
//
//     return Column(children: rows);
//   }
// }
//
// class _DayCell {
//   final int day;
//   final bool isCurrentMonth;
//   final DateTime date;
//   const _DayCell(
//       {required this.day,
//         required this.isCurrentMonth,
//         required this.date});
// }

// // ─────────────────────────────────────────────────────────────────────────────
// // 3. Nothing scheduled card
// // ─────────────────────────────────────────────────────────────────────────────
//
// class NothingScheduledCard extends StatelessWidget {
//   const NothingScheduledCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
//       decoration: BoxDecoration(
//         color: CustomColor.card_bg(context),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         children: [
//           // Grey circle with blue checkmark
//           Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               color: CustomColor.isDark(context)
//                   ? const Color(0xFF374151)
//                   : const Color(0xFFE5E7EB),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(
//               Icons.check,
//               color: Color(0xFF2563EB),
//               size: 42,
//             ),
//           ),
//           const SizedBox(height: 20),
//           Text(
//             'Nothing scheduled yet',
//             style: TextStyle(
//               color: CustomColor.textPrimary(context),
//               fontSize: 17,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             "There aren't any work items due on this date",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: CustomColor.textMutedLabel(context),
//               fontSize: 14,
//               height: 1.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────────
// // 4. Event card  (shown when events exist on selected day)
// // ─────────────────────────────────────────────────────────────────────────────
//
// class CalendarEventCard extends StatelessWidget {
//   final CalendarEvent event;
//   const CalendarEventCard({super.key, required this.event});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: CustomColor.card_bg(context),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 4,
//             height: 40,
//             decoration: BoxDecoration(
//               color: const Color(0xFF2563EB),
//               borderRadius: BorderRadius.circular(2),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               event.title,
//               style: TextStyle(
//                 color: CustomColor.textPrimary(context),
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'calendar_provider.dart';
// import 'calendar_widgets.dart';
//
// class CalendarPageScreen extends StatelessWidget {
//   const CalendarPageScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<CalendarProvider>();
//     final events = provider.eventsForSelectedDay;
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(vertical: 16),
//       child: Column(
//         children: [
//           // ── Filter chips ──────────────────────────────────────────
//           CalendarFilterRow(
//             filters: provider.filters,
//             onToggle: provider.toggleFilter,
//           ),
//           const SizedBox(height: 16),
//
//           // ── Calendar card ──────────────────────────────────────────
//           CalendarCard(provider: provider),
//           const SizedBox(height: 16),
//
//           // ── Events or empty state ──────────────────────────────────
//           if (events.isEmpty)
//             const NothingScheduledCard()
//           else
//             ...events.map((e) => CalendarEventCard(event: e)),
//
//           const SizedBox(height: 24),
//         ],
//       ),
//     );
//   }
// }
//
