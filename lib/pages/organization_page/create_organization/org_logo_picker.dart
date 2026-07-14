import 'dart:io';
import 'package:flutter/material.dart';
import '../../../resources/color/custom_color.dart';

class OrgLogoPicker extends StatelessWidget {
  final File? logoFile;
  final VoidCallback onPick;

  const OrgLogoPicker({
    super.key,
    required this.onPick,
    this.logoFile,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPick,
        child: Stack(
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: CustomColor.logoPickerBg(context),
                shape: BoxShape.circle,
                border: Border.all(color: CustomColor.logoPickerBorder(context)),
              ),
              child: logoFile == null
                  ? Icon(Icons.add_a_photo_outlined,
                  color: CustomColor.logoPickerIcon(context), size: 28)
                  : ClipOval(
                child: Image.file(
                  logoFile!,
                  width: 88,
                  height: 88,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.broken_image_outlined,
                    color: CustomColor.logoPickerIcon(context),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: CustomColor.primaryButtonBg(context),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: CustomColor.card_bg(context),
                    width: 2,
                  ),
                ),
                child: Icon(Icons.edit,
                    size: 14, color: CustomColor.primaryButtonText(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}