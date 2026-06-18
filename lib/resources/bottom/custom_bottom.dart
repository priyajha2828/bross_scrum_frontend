import 'package:flutter/material.dart';
import '../../providers/home_screen/create(+)/create_screen_provider.dart';
import '../color/custom_color.dart';
import '../model/work_type_model.dart';
import '../tile/custom_tile.dart';

// ── App Selector Bottom Sheet ──────────────────────────────────────────────────
class AppSelectorBottomSheet extends StatelessWidget {
  final CreateProvider provider;

  const AppSelectorBottomSheet({super.key, required this.provider});

  static void show(BuildContext context, CreateProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext bc) {
        return SafeArea(child: AppSelectorBottomSheet(provider: provider));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: CustomColor.dividerColor(context),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Select App',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: CustomColor.textPrimary(context),
            ),
          ),
        ),
        Divider(height: 1, color: CustomColor.dividerColor(context)),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: provider.appList.length,
          itemBuilder: (context, index) {
            final appItem = provider.appList[index];
            final isSelected = appItem == provider.selectedApp;
            return ListTile(
              title: Text(
                appItem,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? CustomColor.actionBlueText(context)
                      : CustomColor.textPrimary(context),
                ),
              ),
              trailing: isSelected
                  ? Icon(Icons.check_circle, color: CustomColor.actionBlueText(context))
                  : null,
              onTap: () {
                provider.setApp(appItem);
                Navigator.pop(context);
              },
            );
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// ── Filter Toggle Button ───────────────────────────────────────────────────────
class FilterToggleButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterToggleButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? CustomColor.secondaryContainerBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected
                ? CustomColor.primarySelectedBlue
                : CustomColor.filterUnselectedText(context),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

// ── Work Type Bottom Sheet ─────────────────────────────────────────────────────
class WorkTypeBottomSheet extends StatelessWidget {
  final WorkType selectedType;
  final List<WorkTypeOption> options;
  final ValueChanged<WorkType> onSelected;

  const WorkTypeBottomSheet({
    super.key,
    required this.selectedType,
    required this.options,
    required this.onSelected,
  });

  static Future<void> show(
      BuildContext context, {
        required WorkType selectedType,
        required List<WorkTypeOption> options,
        required ValueChanged<WorkType> onSelected,
      }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => WorkTypeBottomSheet(
        selectedType: selectedType,
        options: options,
        onSelected: onSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: CustomColor.dividerColor(context),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Work type',
              style: TextStyle(
                fontSize: 16,
                color: CustomColor.textMutedLabel(context),
              ),
            ),
          ),
        ),
        ...options.map(
              (option) => WorkTypeTile(
            option: option,
            isSelected: option.type == selectedType,
            onTap: () {
              onSelected(option.type);
              Navigator.pop(context);
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// ── Login Page Button ──────────────────────────────────────────────────────────
class LoginPageButton extends StatelessWidget {
  final String label;
  final IconData iconData;
  final Color iconColor;
  final VoidCallback onPressed;

  const LoginPageButton({
    super.key,
    required this.label,
    required this.iconData,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 36),
        side: BorderSide(color: Colors.grey.shade300, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        foregroundColor: Colors.black,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(iconData, color: iconColor, size: 22),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: CustomColor.tileTextPrimary(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Filter Tile ────────────────────────────────────────────────────────────────
class FilterTile extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final bool isStarred;
  final VoidCallback onTap;
  final VoidCallback onStarTap;

  const FilterTile({
    super.key,
    required this.name,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.isStarred,
    required this.onTap,
    required this.onStarTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  color: CustomColor.textPrimary(context),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                isStarred ? Icons.star : Icons.star_border,
                color: isStarred ? Colors.amber : CustomColor.tileIconDefault(context),
                size: 22,
              ),
              onPressed: onStarTap,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Filter Section Card ────────────────────────────────────────────────────────
class FilterSectionCard extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> filters;
  final void Function(Map<String, dynamic>) onTap;
  final void Function(Map<String, dynamic>) onStarTap;

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
          padding: const EdgeInsets.fromLTRB(4, 16, 4, 8),
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
                  name: filters[i]['name'] as String,
                  icon: filters[i]['icon'] as IconData,
                  iconBg: filters[i]['iconBg'] as Color,
                  iconColor: filters[i]['iconColor'] as Color,
                  isStarred: filters[i]['isStarred'] as bool,
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

// ── View Toggle Button ─────────────────────────────────────────────────────────
class ViewToggleButton extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const ViewToggleButton({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: isSelected
              ? CustomColor.chipSelectedBg(context)
              : CustomColor.card_bg(context),
          borderRadius: BorderRadius.circular(21),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isSelected
              ? CustomColor.chipSelectedText(context)
              : CustomColor.textMutedLabel(context),
        ),
      ),
    );
  }
}