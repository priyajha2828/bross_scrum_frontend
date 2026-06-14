import 'package:flutter/material.dart';
import '../../providers/home_screen/dashboard/dashboard_provider.dart';
import '../color/custom_color.dart';


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

class ActivityFeedCard extends StatelessWidget {
  final List<ActivityItem> activities;
  final String dateLabel;
  final String lastUpdated;
  final bool isRefreshing;
  final VoidCallback onRefresh;

  const ActivityFeedCard({
    super.key,
    required this.activities,
    required this.dateLabel,
    required this.lastUpdated,
    required this.isRefreshing,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Activity stream',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: CustomColor.textPrimary(context),
            ),
          ),
          const SizedBox(height: 8),
          Text(dateLabel, style: TextStyle(fontSize: 14, color: CustomColor.tileTextSecondary(context))),
          const SizedBox(height: 8),
          for (int i = 0; i < activities.length; i++) ...[
            _ActivityRow(item: activities[i]),
            if (i != activities.length - 1)
              Divider(height: 24, thickness: 0.5, color: CustomColor.dividerColor(context)),
          ],
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onRefresh,
            child: Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isRefreshing
                      ? SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: CustomColor.actionBlueText(context),
                    ),
                  )
                      : Icon(Icons.refresh, size: 16, color: CustomColor.actionBlueText(context)),
                  const SizedBox(width: 6),
                  Text(lastUpdated, style: TextStyle(fontSize: 14, color: CustomColor.actionBlueText(context))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  final ActivityItem item;

  const _ActivityRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final textColor = CustomColor.tileTextPrimary(context);
    final mutedColor = CustomColor.tileTextSecondary(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.cyan[700],
          child: const Text(
            'PJ',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 15, color: textColor, height: 1.3),
                  children: [
                    TextSpan(text: item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' ${item.action} '),
                    TextSpan(
                      text: item.target,
                      style: item.bold ? const TextStyle(fontWeight: FontWeight.bold) : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.ticket, style: TextStyle(fontSize: 13, color: mutedColor)),
                  Row(
                    children: [
                      Icon(
                        item.iconType == ActivityIconType.sprint ? Icons.bookmark : Icons.bolt,
                        size: 16,
                        color: item.iconType == ActivityIconType.sprint ? Colors.green : Colors.purple,
                      ),
                      const SizedBox(width: 6),
                      Text(item.date, style: TextStyle(fontSize: 13, color: mutedColor)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// "Missing gadgets" feedback card
class MissingGadgetsCard extends StatelessWidget {
  final VoidCallback onSendFeedback;

  const MissingGadgetsCard({super.key, required this.onSendFeedback});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColor.card_bg(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Looks like you're missing some gadgets",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: CustomColor.textPrimary(context),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "We're building more gadgets for dashboards on mobile. Let us know which gadgets you'd like to see.",
            style: TextStyle(
              fontSize: 15,
              color: CustomColor.tileTextSecondary(context),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onSendFeedback,
            child: Text(
              'Send feedback',
              style: TextStyle(
                fontSize: 15,
                color: CustomColor.actionBlueText(context),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}