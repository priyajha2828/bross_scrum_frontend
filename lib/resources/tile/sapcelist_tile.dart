import 'package:flutter/material.dart';
import '../../providers/home_screen/spaces/space_provider.dart';
import '../color/custom_color.dart';


class SpaceListTile extends StatelessWidget {
  final SpaceModel space;
  final VoidCallback? onStarTap;
  final VoidCallback? onTap;

  const SpaceListTile({
    super.key,
    required this.space,
    this.onStarTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: space.iconColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                space.icon,
                color: CustomColor.shortcutIconDefault,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    space.name,
                    style: TextStyle(
                      color: CustomColor.tileTextPrimary(context),
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    space.subtitle,
                    style: TextStyle(
                      color: CustomColor.tileTextSecondary(context),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                space.isStarred ? Icons.star : Icons.star_border,
                color: space.isStarred
                    ? Colors.amber
                    : CustomColor.tileIconDefault(context),
              ),
              onPressed: onStarTap,
            ),
          ],
        ),
      ),
    );
  }
}