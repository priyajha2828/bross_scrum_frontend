import 'package:flutter/material.dart';

import '../color/custom_color.dart';

class InviteOthersCard extends StatelessWidget {
  final String inviteLink;
  final bool isCopying;
  final VoidCallback onCopy;

  const InviteOthersCard({
    super.key,
    required this.inviteLink,
    required this.onCopy,
    this.isCopying = false,
  });

  @override
  Widget build(BuildContext context) {
    return _DashedBorder(
      color: CustomColor.inviteCardBorder(context),
      radius: 16,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: CustomColor.inviteIconBg(context),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person_add_alt_1,
                      size: 20,
                      color: CustomColor.inviteIconColor(context)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Invite Others',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: CustomColor.textPrimary(context),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Grow your team by sharing this link.',
                        style: TextStyle(
                          fontSize: 13,
                          color: CustomColor.smalltext(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 14),
                    decoration: BoxDecoration(
                      color: CustomColor.inviteLinkBg(context),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      inviteLink,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: CustomColor.inviteLinkText(context),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: isCopying ? null : onCopy,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: CustomColor.copyButtonBg(context),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.copy,
                            size: 16,
                            color: CustomColor.copyButtonText(context)),
                        const SizedBox(width: 6),
                        Text(
                          'Copy Link',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: CustomColor.copyButtonText(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Lightweight dashed-border container so the widget has no external
/// package dependency.
class _DashedBorder extends StatelessWidget {
  final Widget child;
  final Color color;
  final double radius;

  const _DashedBorder({
    required this.child,
    required this.color,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(color: color, radius: radius),
      child: child,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double dashWidth;
  final double dashGap;

  _DashedBorderPainter({
    required this.color,
    required this.radius,
    this.dashWidth = 6,
    this.dashGap = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance = next + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.radius != radius;
}