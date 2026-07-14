import 'package:flutter/material.dart';

import '../../../resources/color/custom_color.dart';

/// Overlapping row of circular avatars with a trailing "+N" bubble
/// for any members not shown individually.
class AvatarStack extends StatelessWidget {
  final List<String> avatarUrls;
  final int extraCount;
  final double avatarSize;

  const AvatarStack({
    super.key,
    required this.avatarUrls,
    this.extraCount = 0,
    this.avatarSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    final overlap = avatarSize * 0.6;
    final totalBubbles = avatarUrls.length + (extraCount > 0 ? 1 : 0);
    final width = avatarSize + (totalBubbles - 1) * overlap;

    return SizedBox(
      height: avatarSize,
      width: width,
      child: Stack(
        children: [
          for (var i = 0; i < avatarUrls.length; i++)
            Positioned(
              left: i * overlap,
              child: _AvatarBubble(
                size: avatarSize,
                borderColor: CustomColor.avatarStackBorder(context),
                child: ClipOval(
                  child: Image.network(
                    avatarUrls[i],
                    width: avatarSize,
                    height: avatarSize,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: CustomColor.avatarExtraBg(context),
                    ),
                  ),
                ),
              ),
            ),
          if (extraCount > 0)
            Positioned(
              left: avatarUrls.length * overlap,
              child: _AvatarBubble(
                size: avatarSize,
                borderColor: CustomColor.avatarStackBorder(context),
                child: Container(
                  color: CustomColor.avatarExtraBg(context),
                  alignment: Alignment.center,
                  child: Text(
                    '+$extraCount',
                    style: TextStyle(
                      color: CustomColor.avatarExtraText(context),
                      fontSize: avatarSize * 0.32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AvatarBubble extends StatelessWidget {
  final double size;
  final Color borderColor;
  final Widget child;

  const _AvatarBubble({
    required this.size,
    required this.borderColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
      ),
      child: ClipOval(child: child),
    );
  }
}