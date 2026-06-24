import 'package:flutter/material.dart';
import '../color/custom_color.dart';

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
          color: isSelected
              ? CustomColor.secondaryContainerBlue
              : Colors.transparent,
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
                color: isStarred
                    ? Colors.amber
                    : CustomColor.tileIconDefault(context),
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

class MoreOptionsMenuButton {
  static void show(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        MediaQuery.of(context).size.width,
        kToolbarHeight,
        0,
        0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
      ),
      color: CustomColor.card_bg(context),
      items: [
        _buildMenuItem(
          context,
          icon: Icons.link,
          label: 'Copy Link',
          onTap: () {},
        ),
        _buildMenuItem(
          context,
          icon: Icons.share_outlined,
          label: 'Share',
          onTap: () {},
        ),
        _buildMenuItem(
          context,
          icon: Icons.flag_outlined,
          label: 'Flag',
          onTap: () {},
        ),
        _buildMenuItem(
          context,
          icon: Icons.work_history_outlined,
          label: 'Log Work',
          onTap: () {},
        ),
        _buildMenuItem(
          context,
          icon: Icons.link_outlined,
          label: 'Link work item',
          onTap: () {},
        ),
        _buildMenuItem(
          context,
          icon: Icons.account_tree_outlined,
          label: 'Add child work item',
          onTap: () {},
        ),
        _buildMenuItem(
          context,
          icon: Icons.delete_outline,
          label: 'Delete',
          isDestructive: true,
          onTap: () {},
        ),
      ],
    );
  }

  static PopupMenuItem _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final color = isDestructive
        ? const Color(0xFFDC2626)
        : CustomColor.textPrimary(context);
    return PopupMenuItem(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 16),
          Text(label, style: TextStyle(fontSize: 16, color: color)),
        ],
      ),
    );
  }
}
