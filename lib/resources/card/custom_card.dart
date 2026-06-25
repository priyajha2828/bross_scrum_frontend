import 'package:BrossScrum/providers/home_screen/app/SummaryPage/summary_page_provider.dart';
import 'package:flutter/material.dart';
import '../../providers/account_screen_provider/notification_settings_provider/donotdisturb_provider/donotdisturb_provider.dart';
import '../../providers/home_screen/dashboard/dashboard_screen/dashboard_provider.dart';
import '../../providers/home_screen/spaces/space_provider.dart';
import '../bar/custom_bar.dart';
import '../color/custom_color.dart';
import '../dropdown/custom_dropdown.dart';
import '../dropdown/custom_time_dropdown.dart';
import '../legend/custom_legend.dart';
import '../model/custom_model.dart';
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

class SummaryStatsGrid extends StatelessWidget {
  final dynamic stats;

  const SummaryStatsGrid({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final items =[
      StatItem(
        icon: Icons.check,
        count: stats.completed,
        label: 'completed',
        sub: 'in the last 7 days ',
      ),
      StatItem(
        icon: Icons.edit_outlined,
        count: stats.updated,
        label: 'updated',
        sub: 'in the last 7 days',
      ),
      StatItem(
        icon: Icons.add,
        count: stats.created,
        label: 'created',
        sub: 'in the last 7 days',
      ),
      StatItem(
        icon: Icons.calendar_today_outlined,
        count: stats.dueSoon,
        label: 'due soon',
        sub: 'in the next 7 days',
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.55,
      children: items.map((e) => StatCard(item: e)).toList(),
    );
  }
}
class StatItem {
  final IconData icon;
  final int count;
  final String label;
  final String sub;
  
  const StatItem(
      {
        required this.icon,
        required this.count,
        required this.label,
        required this.sub,
      }
      );
}


class StatCard extends StatelessWidget {
  final StatItem item;
  const StatCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconBg = isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF0F0F0);
    final primary = isDark ? Colors.white : Colors.black87;
    final muted = isDark ? Colors.white38 : Colors.black38;

    return Container(
      decoration: BoxDecoration(
        color: CustomColor.card_bg(context),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 24,
            decoration:
            BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(8)),
            child: Icon(item.icon, size: 18, color: primary.withOpacity(0.6)),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${item.count} ',
                  style: TextStyle(
                      color: primary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: item.label,
                  style: TextStyle(
                      color: primary,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text(item.sub,
              style: TextStyle(color: muted, fontSize: 12)),
        ],
      ),
    );
  }
}
class StatusOverviewCard extends StatelessWidget {
  final SummaryStats stats;
  final bool isLoading;
  final String lastRefreshedLabel;
  final VoidCallback onRefresh;

  const StatusOverviewCard({
    super.key,
    required this.stats,
    required this.isLoading,
    required this.lastRefreshedLabel,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: CustomColor.card_bg(context),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Status overview',
              style: TextStyle(
                  color: CustomColor.textPrimary(context),
                  fontSize: 22,
                  fontWeight: FontWeight.w400)),
          const SizedBox(height: 4),
          Text('in the last 14 days',
              style: TextStyle(color: CustomColor.textMutedLabel(context), fontSize: 14)),
          const SizedBox(height: 48),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Center(
            child: Column(
              children: [
                Text(
                  '${stats.totalWorkItems}',
                  style: TextStyle(
                      color: CustomColor.textPrimary(context),
                      fontSize: 40,
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 4),
                Text('Total work items',
                    style: TextStyle(color: CustomColor.textMutedLabel(context), fontSize: 14)),
              ],
            ),
          ),

          const SizedBox(height: 32),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: onRefresh,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.sync_rounded,
                      color: Color(0xFF1E88E5), size: 18),
                  const SizedBox(width: 4),
                  Text(lastRefreshedLabel,
                      style: const TextStyle(
                          color: Color(0xFF1E88E5), fontSize: 13)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class PriorityBreakdownCard extends StatelessWidget {
  final SummaryStats stats;
  final int maxCount;

  const PriorityBreakdownCard(
      {
        super.key,
        required this.stats,
        required this.maxCount});

  @override
  Widget build(BuildContext context) {
    

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: CustomColor.card_bg(context), 
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Priority breakdown',
              style: TextStyle(
                  color: CustomColor.textPrimary(context),
                  fontSize: 22,
                  fontWeight: FontWeight.w400)),
          const SizedBox(height: 4),
          Text('in the last 14 days',
              style: TextStyle(color: CustomColor.textMutedLabel(context), fontSize: 14)),
          const SizedBox(height: 24),

          PriorityBarChart(
            breakdown: stats.priorityBreakdown,
            maxCount: maxCount,
          ),

          const SizedBox(height: 16),
          Divider(color: CustomColor.dividerColor(context)),
          const SizedBox(height: 12),


         const PriorityLegend(),
        ],
      ),
    );
  }
}



