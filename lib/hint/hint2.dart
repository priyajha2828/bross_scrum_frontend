// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'summary_provider.dart';
// import 'summary_widgets.dart';
//
// class SummaryPageScreen extends StatefulWidget {
//   const SummaryPageScreen({super.key});
//
//   @override
//   State<SummaryPageScreen> createState() => _SummaryPageScreenState();
// }
//
// class _SummaryPageScreenState extends State<SummaryPageScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // load on first render
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<SummaryProvider>().refresh();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<SummaryProvider>();
//
//     return RefreshIndicator(
//       onRefresh: provider.refresh,
//       child: SingleChildScrollView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // ── 4-card stats grid ────────────────────────────────────
//             SummaryStatsGrid(stats: provider.stats),
//             const SizedBox(height: 16),
//
//             // ── Status overview ──────────────────────────────────────
//             StatusOverviewCard(
//               stats: provider.stats,
//               isLoading: provider.isLoading,
//               lastRefreshedLabel: provider.lastRefreshedLabel,
//               onRefresh: provider.refresh,
//             ),
//             const SizedBox(height: 16),
//
//             // ── Priority breakdown ───────────────────────────────────
//             PriorityBreakdownCard(
//               stats: provider.stats,
//               maxCount: provider.maxPriorityCount,
//             ),
//             const SizedBox(height: 16),
//
//             // ── Feedback banner ──────────────────────────────────────
//             FeedbackBanner(
//               onTap: () {
//                 // TODO: open feedback link
//               },
//             ),
//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
//
// // ── Priority enum ──────────────────────────────────────────────────────────────
//
// enum Priority { highest, high, medium, low, lowest }
//
// extension PriorityExt on Priority {
//   String get label {
//     switch (this) {
//       case Priority.highest: return 'Highest';
//       case Priority.high:    return 'High';
//       case Priority.medium:  return 'Medium';
//       case Priority.low:     return 'Low';
//       case Priority.lowest:  return 'Lowest';
//     }
//   }
//
//   Color get color {
//     switch (this) {
//       case Priority.highest: return const Color(0xFFE53935);
//       case Priority.high:    return const Color(0xFFEF5350);
//       case Priority.medium:  return const Color(0xFFFF9800);
//       case Priority.low:     return const Color(0xFF1E88E5);
//       case Priority.lowest:  return const Color(0xFF1E88E5);
//     }
//   }
//
//   IconData get icon {
//     switch (this) {
//       case Priority.highest: return Icons.keyboard_double_arrow_up_rounded;
//       case Priority.high:    return Icons.keyboard_arrow_up_rounded;
//       case Priority.medium:  return Icons.drag_handle_rounded;
//       case Priority.low:     return Icons.keyboard_arrow_down_rounded;
//       case Priority.lowest:  return Icons.keyboard_double_arrow_down_rounded;
//     }
//   }
// }
//
// // ── Data model ─────────────────────────────────────────────────────────────────
//
// class SummaryStats {
//   final int completed;
//   final int updated;
//   final int created;
//   final int dueSoon;
//   final int totalWorkItems;
//   final Map<Priority, int> priorityBreakdown;
//   final DateTime lastRefreshed;
//
//   SummaryStats({
//     required this.completed,
//     required this.updated,
//     required this.created,
//     required this.dueSoon,
//     required this.totalWorkItems,
//     required this.priorityBreakdown,
//     required this.lastRefreshed,
//   });
//
//   factory SummaryStats.empty() => SummaryStats(
//     completed: 0,
//     updated: 0,
//     created: 0,
//     dueSoon: 0,
//     totalWorkItems: 0,
//     priorityBreakdown: {
//       for (final p in Priority.values) p: 0,
//     },
//     lastRefreshed: DateTime.now(),
//   );
// }

// // ── Provider ───────────────────────────────────────────────────────────────────
//
// class SummaryProvider extends ChangeNotifier {
//   bool _isLoading = false;
//   SummaryStats _stats = SummaryStats.empty();
//
//   bool get isLoading => _isLoading;
//   SummaryStats get stats => _stats;
//
//   int get maxPriorityCount {
//     final values = _stats.priorityBreakdown.values;
//     if (values.isEmpty) return 2;
//     final max = values.reduce((a, b) => a > b ? a : b);
//     return max < 2 ? 2 : max;
//   }
//
//   String get lastRefreshedLabel {
//     final diff = DateTime.now().difference(_stats.lastRefreshed);
//     if (diff.inSeconds < 60) return 'just now';
//     if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
//     return '${diff.inHours}h ago';
//   }
//
//   Future<void> refresh() async {
//     _isLoading = true;
//     notifyListeners();
//
//     // TODO: replace with real API call
//     await Future.delayed(const Duration(milliseconds: 600));
//
//     _stats = SummaryStats(
//       completed: 0,
//       updated: 0,
//       created: 0,
//       dueSoon: 0,
//       totalWorkItems: 0,
//       priorityBreakdown: {
//         for (final p in Priority.values) p: 0,
//       },
//       lastRefreshed: DateTime.now(),
//     );
//
//     _isLoading = false;
//     notifyListeners();
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'summary_provider.dart';
//
// // ─────────────────────────────────────────────────────────────────────────────
// // 1.  2×2 Stats grid
// // ─────────────────────────────────────────────────────────────────────────────
//
// class SummaryStatsGrid extends StatelessWidget {
//   final SummaryStats stats;
//   const SummaryStatsGrid({super.key, required this.stats});
//
//   @override
//   Widget build(BuildContext context) {
//     final items = [
//       _StatItem(
//         icon: Icons.check,
//         count: stats.completed,
//         label: 'completed',
//         sub: 'in the last 7 days 🎉',
//       ),
//       _StatItem(
//         icon: Icons.edit_outlined,
//         count: stats.updated,
//         label: 'updated',
//         sub: 'in the last 7 days',
//       ),
//       _StatItem(
//         icon: Icons.add,
//         count: stats.created,
//         label: 'created',
//         sub: 'in the last 7 days',
//       ),
//       _StatItem(
//         icon: Icons.calendar_today_outlined,
//         count: stats.dueSoon,
//         label: 'due soon',
//         sub: 'in the next 7 days',
//       ),
//     ];
//
//     return GridView.count(
//       crossAxisCount: 2,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       crossAxisSpacing: 12,
//       mainAxisSpacing: 12,
//       childAspectRatio: 1.55,
//       children: items.map((e) => _StatCard(item: e)).toList(),
//     );
//   }
// }

//  class _StatItem {
//   final IconData icon;
//   final int count;
//   final String label;
//   final String sub;
//   const _StatItem(
//       {required this.icon,
//         required this.count,
//         required this.label,
//         required this.sub});
// }

// class _StatCard extends StatelessWidget {
//   final _StatItem item;
//   const _StatCard({required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final iconBg = isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF0F0F0);
//     final cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
//     final primary = isDark ? Colors.white : Colors.black87;
//     final muted = isDark ? Colors.white38 : Colors.black38;
//
//     return Container(
//       decoration: BoxDecoration(
//         color: cardBg,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       padding: const EdgeInsets.all(14),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 34,
//             height: 34,
//             decoration:
//             BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(8)),
//             child: Icon(item.icon, size: 18, color: primary.withOpacity(0.6)),
//           ),
//           const SizedBox(height: 8),
//           RichText(
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                   text: '${item.count} ',
//                   style: TextStyle(
//                       color: primary,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 TextSpan(
//                   text: item.label,
//                   style: TextStyle(
//                       color: primary,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w400),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 2),
//           Text(item.sub,
//               style: TextStyle(color: muted, fontSize: 12)),
//         ],
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────────
// // 2.  Status overview card
// // ─────────────────────────────────────────────────────────────────────────────
//
// class StatusOverviewCard extends StatelessWidget {
//   final SummaryStats stats;
//   final bool isLoading;
//   final String lastRefreshedLabel;
//   final VoidCallback onRefresh;
//
//   const StatusOverviewCard({
//     super.key,
//     required this.stats,
//     required this.isLoading,
//     required this.lastRefreshedLabel,
//     required this.onRefresh,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
//     final primary = isDark ? Colors.white : Colors.black87;
//     final muted = isDark ? Colors.white38 : Colors.black45;
//
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//           color: cardBg, borderRadius: BorderRadius.circular(16)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Status overview',
//               style: TextStyle(
//                   color: primary,
//                   fontSize: 22,
//                   fontWeight: FontWeight.w400)),
//           const SizedBox(height: 4),
//           Text('in the last 14 days',
//               style: TextStyle(color: muted, fontSize: 14)),
//           const SizedBox(height: 48),
//
//           // centre count or loader
//           isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : Center(
//             child: Column(
//               children: [
//                 Text(
//                   '${stats.totalWorkItems}',
//                   style: TextStyle(
//                       color: primary,
//                       fontSize: 40,
//                       fontWeight: FontWeight.w300),
//                 ),
//                 const SizedBox(height: 4),
//                 Text('Total work items',
//                     style: TextStyle(color: muted, fontSize: 14)),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 32),
//
//           // refresh row
//           Align(
//             alignment: Alignment.centerRight,
//             child: GestureDetector(
//               onTap: onRefresh,
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Icon(Icons.sync_rounded,
//                       color: Color(0xFF1E88E5), size: 18),
//                   const SizedBox(width: 4),
//                   Text(lastRefreshedLabel,
//                       style: const TextStyle(
//                           color: Color(0xFF1E88E5), fontSize: 13)),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────────
// // 3.  Priority breakdown card
// // ─────────────────────────────────────────────────────────────────────────────
//
// class PriorityBreakdownCard extends StatelessWidget {
//   final SummaryStats stats;
//   final int maxCount;
//
//   const PriorityBreakdownCard(
//       {super.key, required this.stats, required this.maxCount});
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
//     final primary = isDark ? Colors.white : Colors.black87;
//     final muted = isDark ? Colors.white38 : Colors.black45;
//     final divColor = isDark ? Colors.white12 : Colors.black12;
//
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//           color: cardBg, borderRadius: BorderRadius.circular(16)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Priority breakdown',
//               style: TextStyle(
//                   color: primary,
//                   fontSize: 22,
//                   fontWeight: FontWeight.w400)),
//           const SizedBox(height: 4),
//           Text('in the last 14 days',
//               style: TextStyle(color: muted, fontSize: 14)),
//           const SizedBox(height: 24),
//
//           // bar chart
//           _PriorityBarChart(
//             breakdown: stats.priorityBreakdown,
//             maxCount: maxCount,
//             isDark: isDark,
//           ),
//
//           const SizedBox(height: 16),
//           Divider(color: divColor),
//           const SizedBox(height: 12),
//
//           // legend
//           _PriorityLegend(isDark: isDark),
//         ],
//       ),
//     );
//   }
// }

// // ── Bar chart ──────────────────────────────────────────────────────────────────
//
// class _PriorityBarChart extends StatelessWidget {
//   final Map<Priority, int> breakdown;
//   final int maxCount;
//   final bool isDark;
//
//   const _PriorityBarChart({
//     required this.breakdown,
//     required this.maxCount,
//     required this.isDark,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     const chartH = 120.0;
//     final labelColor = isDark ? Colors.white38 : Colors.black38;
//     final gridColor = isDark ? Colors.white12 : Colors.black12;
//
//     return SizedBox(
//       height: chartH + 36,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           // Y-axis
//           SizedBox(
//             width: 20,
//             height: chartH,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text('$maxCount',
//                     style: TextStyle(color: labelColor, fontSize: 11)),
//                 Text('${maxCount ~/ 2}',
//                     style: TextStyle(color: labelColor, fontSize: 11)),
//                 Text('0',
//                     style: TextStyle(color: labelColor, fontSize: 11)),
//               ],
//             ),
//           ),
//           const SizedBox(width: 8),
//
//           // Bars
//           Expanded(
//             child: Stack(
//               children: [
//                 // grid lines
//                 Positioned.fill(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: List.generate(
//                       3,
//                           (_) => Container(height: 1, color: gridColor),
//                     ),
//                   ),
//                 ),
//
//                 // bars + icons
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: Priority.values.map((p) {
//                     final count = breakdown[p] ?? 0;
//                     final barH = maxCount == 0
//                         ? 0.0
//                         : (count / maxCount) * chartH;
//
//                     return Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         if (barH > 0)
//                           Container(
//                             width: 28,
//                             height: barH,
//                             decoration: BoxDecoration(
//                               color: p.color.withOpacity(0.25),
//                               borderRadius: const BorderRadius.vertical(
//                                   top: Radius.circular(4)),
//                             ),
//                           ),
//                         const SizedBox(height: 6),
//                         Icon(p.icon, color: p.color, size: 22),
//                       ],
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ── Legend ─────────────────────────────────────────────────────────────────────
//
// class _PriorityLegend extends StatelessWidget {
//   final bool isDark;
//   const _PriorityLegend({required this.isDark});
//
//   @override
//   Widget build(BuildContext context) {
//     final textColor = isDark ? Colors.white70 : Colors.black87;
//     final priorities = Priority.values;
//
//     return Column(
//       children: [
//         for (int i = 0; i < priorities.length; i += 2)
//           Padding(
//             padding: const EdgeInsets.only(bottom: 12),
//             child: Row(
//               children: [
//                 _legendItem(priorities[i], textColor),
//                 if (i + 1 < priorities.length)
//                   _legendItem(priorities[i + 1], textColor),
//               ],
//             ),
//           ),
//       ],
//     );
//   }
//
//   Widget _legendItem(Priority p, Color textColor) {
//     return Expanded(
//       child: Row(
//         children: [
//           Icon(p.icon, color: p.color, size: 20),
//           const SizedBox(width: 8),
//           Text(p.label,
//               style: TextStyle(color: textColor, fontSize: 14)),
//         ],
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// // 4.  Feedback banner
// // ─────────────────────────────────────────────────────────────────────────────
//
// class FeedbackBanner extends StatelessWidget {
//   final VoidCallback? onTap;
//   const FeedbackBanner({super.key, this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(vertical: 18),
//         decoration: BoxDecoration(
//           color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: const Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('📣', style: TextStyle(fontSize: 18)),
//             SizedBox(width: 8),
//             Text(
//               'Give feedback on Jira mobile',
//               style: TextStyle(
//                 color: Color(0xFF1E88E5),
//                 fontSize: 15,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




