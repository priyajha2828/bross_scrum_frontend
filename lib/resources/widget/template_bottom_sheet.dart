import 'package:BrossScrum/resources/color/custom_color.dart';
import 'package:flutter/material.dart';
import '../model/space_template_model.dart';


class TemplateBottomSheet extends StatelessWidget {
  final List<SpaceTemplateModel> templates;
  final String selectedTemplateId;
  final ValueChanged<SpaceTemplateModel> onSelected;

  const TemplateBottomSheet({
    super.key,
    required this.templates,
    required this.selectedTemplateId,
    required this.onSelected,
  });

  static void show(
      BuildContext context, {
        required List<SpaceTemplateModel> templates,
        required String selectedTemplateId,
        required ValueChanged<SpaceTemplateModel> onSelected,
      }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: CustomColor.bg_color(context),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => TemplateBottomSheet(
        templates: templates,
        selectedTemplateId: selectedTemplateId,
        onSelected: onSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 14),
          // Pull Indicator Bar
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header Section
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
            child: Text(
              'Select a space template',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: CustomColor.textPrimary(context),
              ),
            ),
          ),

          const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),

          // Templates Scrolling Option Rows
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: templates.length,
              separatorBuilder: (_, __) => const Padding(
                padding: EdgeInsets.only(left: 88.0),
                child: Divider(height: 1, thickness: 0.8, color: Color(0xFFF5F5F5)),
              ),
              itemBuilder: (context, index) {
                final item = templates[index];
                final isSelected = item.id == selectedTemplateId;

                return InkWell(
                  onTap: () {
                    onSelected(item);
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Dynamic Template Representation Asset Avatar
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: item.iconColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(item.icon, color: item.iconColor, size: 24),
                        ),
                        const SizedBox(width: 20),

                        // Text Description Grouping Block
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style:  TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColor.textPrimary(context),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.description,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: CustomColor.textMutedLabel(context),
                                  height: 1.35,
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Sub-Action Inline Info Redirect Anchor
                              GestureDetector(
                                onTap: () {}, // Action route placeholder
                                child: const Text(
                                  'LEARN MORE',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Selection Affirmation Checkbox Widget Indicator
                        if (isSelected)
                          const Padding(
                            padding: EdgeInsets.only(top: 2.0),
                            child: Icon(Icons.check, color: Colors.blue, size: 22),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}