import 'package:flutter/material.dart';
import '../color/custom_color.dart';

class NoResultsState extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  const NoResultsState({
    super.key,
    this.title = 'No matches found',
    this.message = "We couldn't find anything that matches your search.",
    this.icon = Icons.search_off,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 64,
            color: CustomColor.textMutedLabel(context).withOpacity(0.4),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: CustomColor.textPrimary(context),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: CustomColor.textMutedLabel(context),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}