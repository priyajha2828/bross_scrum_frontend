import 'package:flutter/material.dart';
import '../color/custom_color.dart';
import '../model/filter_search_model.dart';
import 'no_result_state.dart';


class MultiSelectFilterSheet extends StatefulWidget {
  final String title;
  final String filterByLabel;
  final List<FilterOptionModel> options;
  final List<String> selectedLabels;
  final ValueChanged<List<String>> onChanged;
  final bool requiresSpaceFirst;

  const MultiSelectFilterSheet({
    super.key,
    required this.title,
    required this.filterByLabel,
    required this.options,
    required this.selectedLabels,
    required this.onChanged,
    this.requiresSpaceFirst = false,
  });

  static Future<void> show(
      BuildContext context, {
        required String title,
        required String filterByLabel,
        required List<FilterOptionModel> options,
        required List<String> selectedLabels,
        required ValueChanged<List<String>> onChanged,
        bool requiresSpaceFirst = false,
      }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => MultiSelectFilterSheet(
        title: title,
        filterByLabel: filterByLabel,
        options: options,
        selectedLabels: selectedLabels,
        onChanged: onChanged,
        requiresSpaceFirst: requiresSpaceFirst,
      ),
    );
  }

  @override
  State<MultiSelectFilterSheet> createState() => _MultiSelectFilterSheetState();
}

class _MultiSelectFilterSheetState extends State<MultiSelectFilterSheet> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late List<String> _selected;
  List<FilterOptionModel> _filtered = [];

  @override
  void initState() {
    super.initState();
    _selected = List.from(widget.selectedLabels);
    _filtered = widget.options;
    _searchController.addListener(_onSearch);
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  void _onSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filtered = widget.options
          .where((o) => o.label.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _toggle(String label) {
    setState(() {
      if (_selected.contains(label)) {
        _selected.remove(label);
      } else {
        _selected.add(label);
      }
    });
    widget.onChanged(_selected);
  }

  @override
  Widget build(BuildContext context) {
    // Determine empty-state mode upfront
    final bool showSpaceFirstState =
        widget.requiresSpaceFirst && widget.options.isEmpty;
    final bool showNoResultsState =
        !showSpaceFirstState && _filtered.isEmpty;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
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
            const SizedBox(height: 16),

            // Search field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: CustomColor.chipUnselectedBg(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  style: TextStyle(
                    color: CustomColor.textPrimary(context),
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.title,
                    hintStyle: TextStyle(
                      color: CustomColor.inputHintDefault(context),
                      fontSize: 15,
                    ),
                    border: InputBorder.none,
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Filter by + Clear all row (hidden in space-first empty state)
            if (!showSpaceFirstState) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.filterByLabel,
                      style: TextStyle(
                        fontSize: 15,
                        color: CustomColor.textPrimary(context),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() => _selected.clear());
                        widget.onChanged(_selected);
                      },
                      child: Text(
                        'Clear all',
                        style: TextStyle(
                          color: CustomColor.actionBlueText(context),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: CustomColor.dividerColor(context)),
            ],

            // Empty states / options list
            if (showSpaceFirstState)
              const NoResultsState(
                icon: Icons.help_outline,
                title: 'Select a space filter first',
                message:
                'Choose a space from the filter dropdown, then choose a version filter.',
              )
            else if (showNoResultsState)
              const NoResultsState()
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _filtered.length,
                itemBuilder: (context, index) {
                  final option = _filtered[index];
                  final isChecked = _selected.contains(option.label);

                  return CheckboxListTile(
                    value: isChecked,
                    onChanged: (_) => _toggle(option.label),
                    controlAffinity: ListTileControlAffinity.trailing,
                    activeColor: CustomColor.actionBlueText(context),
                    title: Row(
                      children: [
                        if (option.icon != null) ...[
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: option.iconBg ??
                                  CustomColor.chipUnselectedBg(context),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              option.icon,
                              color: option.iconColor ??
                                  CustomColor.textMutedLabel(context),
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        if (option.badgeColor != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: option.badgeColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              option.label,
                              style: TextStyle(
                                color: option.badgeTextColor ?? Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ] else
                          Expanded(
                            child: Text(
                              option.label,
                              style: TextStyle(
                                fontSize: 15,
                                color: CustomColor.textPrimary(context),
                              ),
                            ),
                          ),
                      ],
                    ),
                    subtitle: option.subtitle != null
                        ? Padding(
                      padding: const EdgeInsets.only(left: 44),
                      child: Text(
                        option.subtitle!,
                        style: TextStyle(
                          fontSize: 12,
                          color: CustomColor.textMutedLabel(context),
                        ),
                      ),
                    )
                        : null,
                  );
                },
              ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}