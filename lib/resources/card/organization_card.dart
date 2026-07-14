import 'package:flutter/material.dart';
import '../../pages/organization_page/avatar_stack/avatar_stack.dart';
import '../../providers/organization_provider/organization_provider.dart';
import '../color/custom_color.dart';


class OrganizationCard extends StatelessWidget {
  final OrganizationSummary organization;
  final VoidCallback onViewDetails;

  const OrganizationCard({
    super.key,
    required this.organization,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColor.card_bg(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CustomColor.orgCardBorder(context)),
        boxShadow: [
          BoxShadow(
            color: CustomColor.orgCardShadow(context),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      organization.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: CustomColor.textPrimary(context),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.people_outline,
                            size: 14,
                            color: CustomColor.smalltext(context)),
                        const SizedBox(width: 4),
                        Text(
                          '${organization.memberCount} Members',
                          style: TextStyle(
                            fontSize: 13,
                            color: CustomColor.smalltext(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _StatusBadge(status: organization.status),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              organization.imageUrl,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 140,
                color: CustomColor.orgCardBorder(context),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AvatarStack(
                avatarUrls: organization.avatarUrls,
                extraCount: organization.extraMembersCount,
              ),
              InkWell(
                onTap: onViewDetails,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View Details',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: CustomColor.actionBlueText(context),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.arrow_forward,
                          size: 16,
                          color: CustomColor.actionBlueText(context)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: CustomColor.activeBadgeBg(context),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: CustomColor.activeBadgeText(context),
        ),
      ),
    );
  }
}