import 'package:flutter/material.dart';

import '../../providers/home_screen/dashboard/scrum/scrum_provider.dart';
import '../color/custom_color.dart';

// ── Expandable Section ────────────────────────────────────────────────────────
class ExpandableSection extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Widget child;
  final String? collapsedSubtitle;

  const ExpandableSection({
    required this.title,
    required this.isExpanded,
    required this.onToggle,
    required this.child,
    this.collapsedSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.card_bg(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CustomColor.dividerColor(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: isExpanded
                ? const BorderRadius.vertical(top: Radius.circular(16))
                : BorderRadius.circular(16),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: collapsedSubtitle != null && !isExpanded ? 12 : 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: CustomColor.textPrimary(context),
                          ),
                        ),
                        if (!isExpanded &&
                            collapsedSubtitle != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            collapsedSubtitle!,
                            style: TextStyle(
                              fontSize: 13,
                              color: CustomColor.textMutedLabel(context),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: CustomColor.textMutedLabel(context),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            Divider(height: 1, color: CustomColor.dividerColor(context)),
            child,
          ],
        ],
      ),
    );
  }
}

// ── Comment Suggestion Chips ──────────────────────────────────────────────────
class CommentSuggestions extends StatelessWidget {
  final ScrumProvider provider;
  const CommentSuggestions({required this.provider});

  @override
  Widget build(BuildContext context) {
    final suggestions = [
      'Who is working on this...?',
      'Can I get more info?',
      'What is the priority?',
    ];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: suggestions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => provider.addComment(suggestions[index]),
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: CustomColor.card_bg(context),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: CustomColor.chipUnselectedBorder(context),
                ),
              ),
              child: Text(
                suggestions[index],
                style: TextStyle(
                  fontSize: 13,
                  color: CustomColor.textPrimary(context),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}