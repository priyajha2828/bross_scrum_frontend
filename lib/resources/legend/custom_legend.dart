import 'package:BrossScrum/resources/color/custom_color.dart';
import 'package:flutter/material.dart';

import '../../providers/home_screen/app/SummaryPage/summary_page_provider.dart';

class PriorityLegend extends StatelessWidget {
  const PriorityLegend({super.key});

  @override
  Widget build(BuildContext context) {

    final priorities = Priority.values;

    return Column(
      children: [
        for (int i = 0; i < priorities.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                legendItem(priorities[i], CustomColor.textPrimary(context)),
                if (i + 1 < priorities.length)
                  legendItem(priorities[i + 1], CustomColor.textPrimary(context)),
              ],
            ),
          ),
      ],
    );
  }
  Widget legendItem(Priority p, Color textColor) {
    return Expanded(
      child: Row(
        children: [
          Icon(p.icon, color: p.color, size: 20),
          const SizedBox(width: 8),
          Text(p.label,
              style: TextStyle(color: textColor, fontSize: 14)),
        ],
      ),
    );
  }
}
