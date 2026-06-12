import 'package:flutter/material.dart';
import '../../providers/account_screen_provider/notification_settings_provider/donotdisturb_provider/donotdisturb_provider.dart';
import '../color/custom_color.dart';
import '../dropdown/custom_time_dropdown.dart';
import '../tile/custom_tile.dart';


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