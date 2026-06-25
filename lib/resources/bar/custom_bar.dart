import 'package:flutter/material.dart';

import '../../providers/home_screen/app/SummaryPage/summary_page_provider.dart';
import '../color/custom_color.dart';


class AttachmentAction {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const AttachmentAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

class CreateIssueAttachmentBar extends StatelessWidget {
  final List<AttachmentAction> actions;

  const CreateIssueAttachmentBar({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: actions
            .map((action) => _AttachmentButton(action: action))
            .toList(),
      ),
    );
  }
}

class _AttachmentButton extends StatelessWidget {
  final AttachmentAction action;

  const _AttachmentButton({required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action.onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(action.icon, color: const Color(0xFF2563EB), size: 26),
            const SizedBox(height: 4),
            Text(
              action.label,
              style: const TextStyle(
                color: Color(0xFF2563EB),
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class PriorityBarChart extends StatelessWidget {
  final Map<Priority, int> breakdown;
  final int maxCount;

  const PriorityBarChart({
    super.key,
    required this.breakdown,
    required this.maxCount,

  });

  @override
  Widget build(BuildContext context) {
    const chartH = 120.0;

    return SizedBox(
      height: chartH + 36,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [

          SizedBox(
            width: 20,
            height: chartH,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('$maxCount',
                    style: TextStyle(color: CustomColor.textMutedLabel(context), fontSize: 11)),
                Text('${maxCount ~/ 2}',
                    style: TextStyle(color: CustomColor.textMutedLabel(context), fontSize: 11)),
                Text('0',
                    style: TextStyle(color: CustomColor.textMutedLabel(context), fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(width: 8),

          Expanded(
            child: Stack(
              children: [

                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      3,
                          (_) => Container(height: 1, color: CustomColor.textPrimary(context)),
                    ),
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: Priority.values.map((p) {
                    final count = breakdown[p] ?? 0;
                    final barH = maxCount == 0
                        ? 0.0
                        : (count / maxCount) * chartH;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (barH > 0)
                          Container(
                            width: 28,
                            height: barH,
                            decoration: BoxDecoration(
                              color: p.color.withOpacity(0.25),
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(4)),
                            ),
                          ),
                        const SizedBox(height: 6),
                        Icon(p.icon, color: p.color, size: 22),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
