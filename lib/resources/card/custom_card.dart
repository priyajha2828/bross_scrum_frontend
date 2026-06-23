import 'package:flutter/material.dart';
import '../../providers/account_screen_provider/notification_settings_provider/donotdisturb_provider/donotdisturb_provider.dart';
import '../../providers/home_screen/dashboard/dashboard_screen/dashboard_provider.dart';
import '../../providers/home_screen/spaces/space_provider.dart';
import '../color/custom_color.dart';
import '../dropdown/custom_dropdown.dart';
import '../dropdown/custom_time_dropdown.dart';
import '../model/filter_model.dart';
import '../tile/custom_tile.dart';


class DashboardDropdown extends StatelessWidget {
  final String selectedDashboard;
  final VoidCallback? onTap;

  const DashboardDropdown({
    super.key,
    required this.selectedDashboard,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: CustomColor.card_bg(context),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDashboard,
              style: TextStyle(fontSize: 16, color: CustomColor.textPrimary(context)),
            ),
            Icon(Icons.keyboard_arrow_down, color: CustomColor.dropdownIcon(context)),
          ],
        ),
      ),
    );
  }
}

class AssignedToMeCard extends StatelessWidget {
  final bool isRefreshing;
  final bool hasItems;
  final int itemCount;
  final VoidCallback onRefresh;

  const AssignedToMeCard({
    super.key,
    required this.isRefreshing,
    required this.hasItems,
    required this.itemCount,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColor.card_bg(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assigned to Me',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.textPrimary(context),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                hasItems ? '$itemCount items' : 'No matching work items found.',
                style: TextStyle(fontSize: 15, color: CustomColor.tileTextSecondary(context)),
              ),
            ],
          ),
          GestureDetector(
            onTap: onRefresh,
            child: isRefreshing
                ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: CustomColor.actionBlueText(context),
              ),
            )
                : Icon(Icons.refresh, color: CustomColor.actionBlueText(context)),
          ),
        ],
      ),
    );
  }
}

// class ActivityFeedCard extends StatelessWidget {
//   final List<ActivityItem> activities;
//   final String dateLabel;
//   final String lastUpdated;
//   final bool isRefreshing;
//   final VoidCallback onRefresh;
//
//   const ActivityFeedCard({
//     super.key,
//     required this.activities,
//     required this.dateLabel,
//     required this.lastUpdated,
//     required this.isRefreshing,
//     required this.onRefresh,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: CustomColor.card_bg(context),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Activity stream',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: CustomColor.textPrimary(context),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(dateLabel, style: TextStyle(fontSize: 14, color: CustomColor.tileTextSecondary(context))),
//           const SizedBox(height: 8),
//           for (int i = 0; i < activities.length; i++) ...[
//             _ActivityRow(item: activities[i]),
//             if (i != activities.length - 1)
//               Divider(height: 24, thickness: 0.5, color: CustomColor.dividerColor(context)),
//           ],
//           const SizedBox(height: 12),
//           GestureDetector(
//             onTap: onRefresh,
//             child: Align(
//               alignment: Alignment.centerRight,
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   isRefreshing
//                       ? SizedBox(
//                     width: 14,
//                     height: 14,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 2,
//                       color: CustomColor.actionBlueText(context),
//                     ),
//                   )
//                       : Icon(Icons.refresh, size: 16, color: CustomColor.actionBlueText(context)),
//                   const SizedBox(width: 6),
//                   Text(lastUpdated, style: TextStyle(fontSize: 14, color: CustomColor.actionBlueText(context))),
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
// class _ActivityRow extends StatelessWidget {
//   final ActivityItem item;
//
//   const _ActivityRow({required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     final textColor = CustomColor.tileTextPrimary(context);
//     final mutedColor = CustomColor.tileTextSecondary(context);
//
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CircleAvatar(
//           radius: 16,
//           backgroundColor: Colors.cyan[700],
//           child: const Text(
//             'PJ',
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               RichText(
//                 text: TextSpan(
//                   style: TextStyle(fontSize: 15, color: textColor, height: 1.3),
//                   children: [
//                     TextSpan(text: item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
//                     TextSpan(text: ' ${item.action} '),
//                     TextSpan(
//                       text: item.target,
//                       style: item.bold ? const TextStyle(fontWeight: FontWeight.bold) : null,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(item.ticket, style: TextStyle(fontSize: 13, color: mutedColor)),
//                   Row(
//                     children: [
//                       Icon(
//                         item.iconType == ActivityIconType.sprint ? Icons.bookmark : Icons.bolt,
//                         size: 16,
//                         color: item.iconType == ActivityIconType.sprint ? Colors.green : Colors.purple,
//                       ),
//                       const SizedBox(width: 6),
//                       Text(item.date, style: TextStyle(fontSize: 13, color: mutedColor)),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class MissingGadgetsCard extends StatelessWidget {
//   final VoidCallback onSendFeedback;
//
//   const MissingGadgetsCard({super.key, required this.onSendFeedback});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: CustomColor.card_bg(context),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Looks like you're missing some gadgets",
//             style: TextStyle(
//               fontSize: 17,
//               fontWeight: FontWeight.w600,
//               color: CustomColor.textPrimary(context),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             "We're building more gadgets for dashboards on mobile. Let us know which gadgets you'd like to see.",
//             style: TextStyle(
//               fontSize: 15,
//               color: CustomColor.tileTextSecondary(context),
//               height: 1.4,
//             ),
//           ),
//           const SizedBox(height: 12),
//           GestureDetector(
//             onTap: onSendFeedback,
//             child: Text(
//               'Send feedback',
//               style: TextStyle(
//                 fontSize: 15,
//                 color: CustomColor.actionBlueText(context),
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class DndScheduleCard extends StatelessWidget {
  final DndProvider dndProvider;

  const DndScheduleCard({
    required this.dndProvider,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Card(
      color: CustomColor.card_bg(context),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomListTile(
              icon: Icons.calendar_today_outlined,
              text: 'Schedule notifications',
              subtitle: 'Set when you want to be notified',
              showSwitch: true,
              switchValue: dndProvider.isScheduleEnabled,
              onSwitchChanged: dndProvider.toggleSchedule,
              isTabActive: false,
              onTap: () {},
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      color: CustomColor.dividerColor(context),
                      height: 1,
                      thickness: 1,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Only notify me on these days',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: CustomColor.textMutedLabel(context),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(7, (index) {
                        final isSelected = dndProvider.selectedDays[index];

                        return GestureDetector(
                          onTap: () => dndProvider.toggleDay(index),
                          child: Container(
                            width: 38,
                            height: 38,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? CustomColor.daySelectedBg(context)
                                  : CustomColor.dayUnselectedBg(context),
                            ),
                            child: Text(
                              weekDays[index],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : CustomColor.textPrimary(context),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'During these hours',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: CustomColor.textMutedLabel(context),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTimeDropdown(
                            label: 'Start',
                            time: dndProvider.startTime,
                            onTimeSelected: dndProvider.updateStartTime,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomTimeDropdown(
                            label: 'End',
                            time: dndProvider.endTime,
                            onTimeSelected: dndProvider.updateEndTime,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              crossFadeState: dndProvider.isScheduleEnabled
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 200),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityFeedRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final bool isTopRoundedOnly;
  final bool isBottomRoundedOnly;
  final VoidCallback onTap;

  const ActivityFeedRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    this.isTopRoundedOnly = false,
    this.isBottomRoundedOnly = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(16);
    if (isTopRoundedOnly) {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      );
    }
    if (isBottomRoundedOnly) {
      borderRadius = const BorderRadius.only(
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      );
    }

    return Material(
      color: CustomColor.feedRowBg(context),
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: CustomColor.feedTextPrimary(context),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: CustomColor.feedTextSecondary(context),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SpaceSectionCard extends StatelessWidget {
  final List<SpaceModel> spaces;
  final void Function(SpaceModel)? onStarTap;
  final void Function(SpaceModel)? onTap;

  const SpaceSectionCard({
    super.key,
    required this.spaces,
    this.onStarTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.tileActiveBg(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          for (int i = 0; i < spaces.length; i++) ...[
            SpaceListTile(
              space: spaces[i],
              onTap: () => onTap?.call(spaces[i]),
              onStarTap: () => onStarTap?.call(spaces[i]),
            ),
            if (i != spaces.length - 1)
              Divider(
                height: 1,
                color: CustomColor.dividerColor(context),
                indent: 16,
                endIndent: 16,
              ),
          ],
        ],
      ),
    );
  }
}

class SpaceShortcutCard extends StatelessWidget {
  final String title;
  final Color iconBgColor;
  final IconData icon;
  final VoidCallback onTap;

  const SpaceShortcutCard({
    super.key,
    required this.title,
    required this.iconBgColor,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomColor.shortcutCardBg(context),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: CustomColor.shortcutIconDefault, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: CustomColor.tileTextPrimary(context),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Space',
                      style: TextStyle(
                        color: CustomColor.shortcutSubtitle(context),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FilterSectionCard extends StatelessWidget {
  final String title;
  final List<FilterModel> filters;
  final void Function(FilterModel) onTap;
  final void Function(FilterModel) onStarTap;

  const FilterSectionCard({
    super.key,
    required this.title,
    required this.filters,
    required this.onTap,
    required this.onStarTap,
  });

  @override
  Widget build(BuildContext context) {
    if (filters.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: CustomColor.textMutedLabel(context),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: CustomColor.card_bg(context),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              for (int i = 0; i < filters.length; i++) ...[
                FilterTile(
                  filter: filters[i],
                  onTap: () => onTap(filters[i]),
                  onStarTap: () => onStarTap(filters[i]),
                ),
                if (i != filters.length - 1)
                  Divider(
                    height: 1,
                    color: CustomColor.dividerColor(context),
                    indent: 16,
                    endIndent: 16,
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}