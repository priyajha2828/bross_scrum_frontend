import 'package:flutter/material.dart';
import '../color/custom_color.dart';

class CreateIssueFormField extends StatelessWidget {
  final String label;
  final String? value;
  final bool isRequired;
  final VoidCallback? onTap;
  final Widget? trailing;

  const CreateIssueFormField({
    super.key,
    required this.label,
    this.value,
    this.isRequired = false,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 14,
                          color: CustomColor.textMutedLabel(context),
                        ),
                      ),
                      if (isRequired) ...[
                        const SizedBox(width: 6),
                        const Text(
                          '(required)',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (value != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      value!,
                      style: TextStyle(
                        fontSize: 16,
                        color: CustomColor.textPrimary(context),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}