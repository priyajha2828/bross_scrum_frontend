import 'package:flutter/material.dart';
import '../../providers/organization_provider/create_organization_provider.dart';
import '../../providers/organization_provider/organization_provider.dart';
import '../color/custom_color.dart';

class OrgSlugField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final SlugStatus status;

  const OrgSlugField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Organization URL',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: CustomColor.textMutedLabel(context),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: CustomColor.inputBg(context),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _borderColor(context)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              Text(
                'kinetic.app/',
                style: TextStyle(color: CustomColor.slugPrefixText(context)),
              ),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  onChanged: onChanged,
                  style: TextStyle(color: CustomColor.textPrimary(context)),
                  decoration: InputDecoration(
                    hintText: 'kinetic-team',
                    hintStyle:
                    TextStyle(color: CustomColor.inputHintDefault(context)),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              _StatusIcon(status: status),
            ],
          ),
        ),
        const SizedBox(height: 6),
        _StatusLabel(status: status),
      ],
    );
  }

  Color _borderColor(BuildContext context) {
    switch (status) {
      case SlugStatus.taken:
      case SlugStatus.invalid:
        return CustomColor.inputBorderError(context);
      case SlugStatus.available:
        return CustomColor.slugAvailableText(context);
      case SlugStatus.checking:
      case SlugStatus.idle:
        return CustomColor.inputBorderDefault(context);
    }
  }
}

class _StatusIcon extends StatelessWidget {
  final SlugStatus status;
  const _StatusIcon({required this.status});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case SlugStatus.checking:
        return SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: CustomColor.slugCheckingText(context),
          ),
        );
      case SlugStatus.available:
        return Icon(Icons.check_circle,
            size: 18, color: CustomColor.slugAvailableText(context));
      case SlugStatus.taken:
      case SlugStatus.invalid:
        return Icon(Icons.error,
            size: 18, color: CustomColor.slugTakenText(context));
      case SlugStatus.idle:
        return const SizedBox.shrink();
    }
  }
}

class _StatusLabel extends StatelessWidget {
  final SlugStatus status;
  const _StatusLabel({required this.status});

  @override
  Widget build(BuildContext context) {
    String? text;
    Color? color;

    switch (status) {
      case SlugStatus.checking:
        text = 'Checking availability…';
        color = CustomColor.slugCheckingText(context);
        break;
      case SlugStatus.available:
        text = 'This URL is available';
        color = CustomColor.slugAvailableText(context);
        break;
      case SlugStatus.taken:
        text = 'This URL is already taken';
        color = CustomColor.slugTakenText(context);
        break;
      case SlugStatus.invalid:
        text = 'Use lowercase letters, numbers, and hyphens only';
        color = CustomColor.slugTakenText(context);
        break;
      case SlugStatus.idle:
        text = null;
    }

    if (text == null) return const SizedBox.shrink();

    return Text(text, style: TextStyle(fontSize: 12, color: color));
  }
}