import 'package:flutter/material.dart';
import '../color/custom_color.dart';
import '../model/filter_search_model.dart';


class SearchTypeBottomSheet extends StatelessWidget {
  final SearchType selected;
  final ValueChanged<SearchType> onSelected;

  const SearchTypeBottomSheet({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  static Future<void> show(
      BuildContext context, {
        required SearchType selected,
        required ValueChanged<SearchType> onSelected,
      }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SearchTypeBottomSheet(selected: selected, onSelected: onSelected),
    );
  }

  Widget _tile({
    required BuildContext context,
    required String label,
    Widget? badge,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: CustomColor.chipUnselectedBg(context),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: CustomColor.textPrimary(context),
              ),
            ),
            if (badge != null) ...[
              const SizedBox(width: 8),
              badge,
            ],
            const Spacer(),
            Radio<bool>(
              value: true,
              groupValue: isSelected,
              activeColor: CustomColor.actionBlueText(context),
              onChanged: (_) => onTap(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: CustomColor.dividerColor(context),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Text(
              'Search type',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: CustomColor.textPrimary(context),
              ),
            ),
          ),
          _tile(
            context: context,
            label: 'Basic',
            isSelected: selected == SearchType.basic,
            onTap: () {
              onSelected(SearchType.basic);
              Navigator.pop(context);
            },
          ),
          _tile(
            context: context,
            label: 'JQL',
            isSelected: selected == SearchType.jql,
            onTap: () {
              onSelected(SearchType.jql);
              Navigator.pop(context);
            },
          ),
          _tile(
            context: context,
            label: 'AI search',
            badge: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFF3E8FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'New',
                style: TextStyle(
                  color: Color(0xFFB554E0),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            isSelected: selected == SearchType.aiSearch,
            onTap: () {
              onSelected(SearchType.aiSearch);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}