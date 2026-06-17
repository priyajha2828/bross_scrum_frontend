import 'package:flutter/material.dart';
import '../../providers/home_screen/create(+)/create_screen_provider.dart';
import '../color/custom_color.dart';
import '../model/work_type_model.dart';
import '../tile/custom_tile.dart';

class AppSelectorBottomSheet extends StatelessWidget {
  final CreateProvider provider;

  const AppSelectorBottomSheet({
    super.key,
    required this.provider,
  });

  static void show(BuildContext context, CreateProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext bc) {
        return SafeArea(
          child: AppSelectorBottomSheet(provider: provider),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Select App",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(height: 1),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: provider.appList.length,
          itemBuilder: (context, index) {
            final appItem = provider.appList[index];
            final isSelected = appItem == provider.selectedApp;

            return ListTile(
              title: Text(
                appItem,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? CustomColor.actionBlueText(context)
                      : CustomColor.textPrimary(context),
                ),
              ),
              trailing: isSelected
                  ? Icon(Icons.check_circle,
                  color: CustomColor.actionBlueText(context))
                  : null,
              onTap: () {
                provider.setApp(appItem);
                Navigator.pop(context);
              },
            );
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class FilterToggleButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterToggleButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? CustomColor.secondaryContainerBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? CustomColor.primarySelectedBlue : CustomColor.filterUnselectedText(context),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class WorkTypeBottomSheet extends StatelessWidget {
  final WorkType selectedType;
  final List<WorkTypeOption> options;
  final ValueChanged<WorkType> onSelected;

  const WorkTypeBottomSheet({
    super.key,
    required this.selectedType,
    required this.options,
    required this.onSelected,
  });

  static Future<void> show(
      BuildContext context, {
        required WorkType selectedType,
        required List<WorkTypeOption> options,
        required ValueChanged<WorkType> onSelected,
      }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => WorkTypeBottomSheet(
        selectedType: selectedType,
        options: options,
        onSelected: onSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: CustomColor.dividerColor(context),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Work type',
              style: TextStyle(
                fontSize: 16,
                color: CustomColor.textMutedLabel(context),
              ),
            ),
          ),
        ),
        ...options.map((option) => WorkTypeTile(
          option: option,
          isSelected: option.type == selectedType,
          onTap: () {
            onSelected(option.type);
            Navigator.pop(context);
          },
        )),
        const SizedBox(height: 16),
      ],
    );
  }
}

class LoginPageButton extends StatelessWidget {
  final String label;
  final IconData iconData;
  final Color iconColor;
  final VoidCallback onPressed;

  const LoginPageButton({
    super.key,
    required this.label,
    required this.iconData,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 36),
        side: BorderSide(color: Colors.grey.shade300, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        foregroundColor: Colors.black,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(iconData, color: iconColor, size: 22),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: CustomColor.tileTextPrimary(context),
              ),
            ),
          )
        ],
      ),
    );
  }
}