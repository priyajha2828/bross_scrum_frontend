import 'package:flutter/material.dart';
import '../color/custom_color.dart';

class OrgNameField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const OrgNameField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Organization name',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: CustomColor.textMutedLabel(context),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          style: TextStyle(color: CustomColor.textPrimary(context)),
          decoration: InputDecoration(
            hintText: 'e.g. Kinetic Team',
            hintStyle: TextStyle(color: CustomColor.inputHintDefault(context)),
            filled: true,
            fillColor: CustomColor.inputBg(context),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
              BorderSide(color: CustomColor.inputBorderDefault(context)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
              BorderSide(color: CustomColor.inputBorderDefault(context)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
              BorderSide(color: CustomColor.primaryButtonBg(context)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
              BorderSide(color: CustomColor.inputBorderError(context)),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().length < 2) {
              return 'Enter at least 2 characters';
            }
            return null;
          },
        ),
      ],
    );
  }
}