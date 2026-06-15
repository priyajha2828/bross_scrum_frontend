import 'package:flutter/material.dart';
import '../../providers/home_screen/spaces/space_provider.dart';
import '../color/custom_color.dart';
import '../tile/sapcelist_tile.dart';


class SpaceSectionCard extends StatelessWidget {
  final List<SpaceModel> spaces;
  final void Function(SpaceModel)? onStarTap;
  final void Function(SpaceModel)? onTap;

  const SpaceSectionCard({
    super.key,
    required this.spaces,
    this.onStarTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.tileActiveBg(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          for (int i = 0; i < spaces.length; i++) ...[
            SpaceListTile(
              space: spaces[i],
              onTap: () => onTap?.call(spaces[i]),
              onStarTap: () => onStarTap?.call(spaces[i]),
            ),
            if (i != spaces.length - 1)
              Divider(
                height: 1,
                color: CustomColor.dividerColor(context),
                indent: 16,
                endIndent: 16,
              ),
          ],
        ],
      ),
    );
  }
}