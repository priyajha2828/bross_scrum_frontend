import 'package:flutter/material.dart';

class ActivityFeedRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final bool isTopRoundedOnly;
  final bool isBottomRoundedOnly;

  const ActivityFeedRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    this.isTopRoundedOnly = false,
    this.isBottomRoundedOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(16);
    if (isTopRoundedOnly) {
      borderRadius = const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16));
    }
    if (isBottomRoundedOnly) {
      borderRadius = const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16));
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black87),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(color: Colors.grey[500], fontSize: 13)),
              ],
            ),
          )
        ],
      ),
    );
  }
}