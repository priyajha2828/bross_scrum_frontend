import 'package:flutter/material.dart';
import '../color/custom_color.dart';

class OrderByBottomSheet extends StatelessWidget {
  final String selectedOption;
  final List<String> options;
  final ValueChanged<String> onSelected;
  final VoidCallback onReset;

  const OrderByBottomSheet({
    super.key,
    required this.selectedOption,
    required this.options,
    required this.onSelected,
    required this.onReset,
  });

  static Future<void> show(
      BuildContext context, {
        required String selectedOption,
        required List<String> options,
        required ValueChanged<String> onSelected,
        required VoidCallback onReset,
      }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => OrderByBottomSheet(
        selectedOption: selectedOption,
        options: options,
        onSelected: onSelected,
        onReset: onReset,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: CustomColor.dividerColor(context).withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order by',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    onReset();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...options.map((option) {
            final isSelected = option.toLowerCase() == selectedOption.toLowerCase();
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
              title: Text(
                option,
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected ? Colors.blue : CustomColor.textPrimary(context),
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
              trailing: isSelected
                  ? const Icon(Icons.arrow_downward, color: Colors.blue)
                  : null,
              onTap: () {
                onSelected(option);
                Navigator.pop(context);
              },
            );
          }),
        ],
      ),
    );
  }
}