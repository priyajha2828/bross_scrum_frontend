import 'package:flutter/material.dart';
import '../color/custom_color.dart';
import '../../providers/home_screen/dashboard/dashboard_screen/dashboard_provider.dart';

class DashboardSelectorSheet extends StatelessWidget {
  final DashboardsProvider provider;

  const DashboardSelectorSheet({super.key, required this.provider});

  static void show(BuildContext context, DashboardsProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => DashboardSelectorSheet(provider: provider),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: CustomColor.dividerColor(context),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Starred dashboards section
          if (provider.starredDashboards.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
              child: Text(
                'Starred dashboards',
                style: TextStyle(
                  fontSize: 14,
                  color: CustomColor.textMutedLabel(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ...provider.starredDashboards.map(
                  (d) => _DashboardTile(
                name: d.name,
                isSelected: d.name == provider.selectedDashboard,
                onTap: () {
                  provider.selectDashboard(d.name);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DashboardTile extends StatelessWidget {
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const _DashboardTile({
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: isSelected ? CustomColor.chipSelectedBg(context) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected
                      ? CustomColor.chipSelectedText(context)
                      : CustomColor.textPrimary(context),
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}