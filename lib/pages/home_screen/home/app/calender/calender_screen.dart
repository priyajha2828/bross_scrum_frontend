import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/home_screen/app/calender/calender_provider.dart';
import '../../../../../resources/widget/calender_widget.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CalenderProvider>();
      final events = provider.eventsForSelectedDay;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical:16),
      child: Column(
        children: [
          CalenderFilterRow(
            filters: provider.filters,
            onToggle: provider.toggleFilter,

          ),
          const SizedBox(height: 16),

          CalenderCard(provider:provider),
          const SizedBox(height: 16),
          if(events.isEmpty)
            const NothingScheduleCard()
          else
            ...events.map((e) => CalenderEventsCard(event : e)),
          const SizedBox(height: 24),
        ],
      )
    );
  }
}
