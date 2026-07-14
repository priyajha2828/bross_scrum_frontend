import 'package:flutter/material.dart';
import '../../pages/organization_page/create_organization/organization_enums.dart';
import '../color/custom_color.dart';

class PlanTierSelector extends StatelessWidget {
  final PlanTier selected;
  final ValueChanged<PlanTier> onChanged;

  const PlanTierSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose a plan',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: CustomColor.textMutedLabel(context),
          ),
        ),
        const SizedBox(height: 8),
        for (final tier in PlanTier.values) ...[
          _PlanCard(
            tier: tier,
            isSelected: tier == selected,
            onTap: () => onChanged(tier),
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _PlanCard extends StatelessWidget {
  final PlanTier tier;
  final bool isSelected;
  final VoidCallback onTap;

  const _PlanCard({
    required this.tier,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isSelected
        ? CustomColor.planCardSelectedBg(context)
        : CustomColor.planCardUnselectedBg(context);
    final border = isSelected
        ? CustomColor.planCardSelectedBorder(context)
        : CustomColor.planCardUnselectedBorder(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: border, width: isSelected ? 1.5 : 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  size: 20,
                  color: isSelected
                      ? CustomColor.planCardSelectedBorder(context)
                      : CustomColor.planCardUnselectedBorder(context),
                ),
                const SizedBox(width: 10),
                Text(
                  tier.label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: CustomColor.planCardTitle(context),
                  ),
                ),
                if (tier.isPopular) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: CustomColor.planBadgePopularBg(context),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Popular',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.planBadgePopularText(context),
                      ),
                    ),
                  ),
                ],
                const Spacer(),
                Text(
                  tier.priceLabel,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: CustomColor.planCardPrice(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                tier.tagline,
                style: TextStyle(
                  fontSize: 12.5,
                  color: CustomColor.planCardTagline(context),
                ),
              ),
            ),
            if (isSelected) ...[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final feature in tier.features)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Icon(Icons.check,
                                size: 14,
                                color:
                                CustomColor.planCardCheckIcon(context)),
                            const SizedBox(width: 6),
                            Text(
                              feature,
                              style: TextStyle(
                                fontSize: 12.5,
                                color:
                                CustomColor.planCardFeatureText(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}