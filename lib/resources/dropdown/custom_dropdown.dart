import 'package:flutter/material.dart';
import '../color/custom_color.dart';

// =========================================================================
// १. CustomTimeDropdown विजेट
// =========================================================================
class CustomTimeDropdown extends StatelessWidget {
  final String label;
  final String time;
  final ValueChanged<String> onTimeSelected;

  const CustomTimeDropdown({
    required this.label,
    required this.time,
    required this.onTimeSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // माथिको तैरिने लेबल (Floating Label Effect)
        Transform.translate(
          offset: const Offset(12, 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            color: CustomColor.dropdownBg(context),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: CustomColor.dropdownFloatingLabel(context),
              ),
            ),
          ),
        ),
        // ड्रपडाउन बक्सको मुख्य डिजाइन
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: CustomColor.dropdownBorder(context)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 16,
                  color: CustomColor.dropdownText(context),
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: CustomColor.dropdownIcon(context),
                  ),
                  items: ['08:00', '12:00', '17:00', '19:00', '22:00']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    if (newValue != null) onTimeSelected(newValue);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =========================================================================
// २. DashboardDropdown विजेट
// =========================================================================
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