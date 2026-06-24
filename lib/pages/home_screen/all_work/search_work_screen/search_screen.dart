import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/home_screen/all_work/all_work_provider.dart';
import '../../../../resources/bottomsheet/custom_bottomsheet.dart';
import '../../../../resources/color/custom_color.dart';
import '../../../../resources/model/custom_model.dart';
import '../../../../resources/widget/multi_select_filter_sheet.dart';

class SearchWorkScreen extends StatefulWidget {
  const SearchWorkScreen({super.key});

  @override
  State<SearchWorkScreen> createState() => _SearchWorkScreenState();
}

class _SearchWorkScreenState extends State<SearchWorkScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<String> _filterChips = [
    'Basic',
    'Space',
    'Type',
    'Status',
    'Priority',
    'Assignee',
    'Reporter',
    'Resolution',
    'Label',
    'Component',
    'Fix Version',
    'Affect Version',
    'Order By',
    'Sprint',
  ];

  SearchType _searchType = SearchType.basic;
  String _selectedOrderBy = 'Priority'; // Default active sort option from image

  final Map<String, List<String>> _selectedValues = {
    'Space': [],
    'Type': [],
    'Status': [],
    'Priority': [],
    'Assignee': [],
    'Reporter': [],
    'Resolution': [],
    'Label': [],
    'Component': [],
    'Fix Version': [],
    'Affect Version': [],
    'Sprint': [],
  };

  // Static option data per chip
  final Map<String, List<FilterOptionModel>> _optionData = {
    'Space': const [
      FilterOptionModel(label: 'app1', icon: Icons.public, iconBg: Color(0xFFFFE4D6), iconColor: Color(0xFFEA580C)),
      FilterOptionModel(label: 'App 3', icon: Icons.description, iconBg: Color(0xFFDBEAFE), iconColor: Color(0xFF2563EB)),
    ],
    'Type': const [
      FilterOptionModel(label: 'Subtask', icon: Icons.subdirectory_arrow_right, iconBg: Color(0xFFDBEAFE), iconColor: Color(0xFF2563EB)),
      FilterOptionModel(label: 'Story', icon: Icons.check_box_outlined, iconBg: Color(0xFFDBEAFE), iconColor: Color(0xFF2563EB)),
      FilterOptionModel(label: 'Task', icon: Icons.check_box_outlined, iconBg: Color(0xFFDBEAFE), iconColor: Color(0xFF2563EB)),
      FilterOptionModel(label: 'Bug', icon: Icons.bug_report, iconBg: Color(0xFFFEE2E2), iconColor: Color(0xFFDC2626)),
      FilterOptionModel(label: 'Epic', icon: Icons.bolt, iconBg: Color(0xFFF3E8FF), iconColor: Color(0xFFB554E0)),
    ],
    'Status': const [
      FilterOptionModel(label: 'To Do', badgeColor: Color(0xFFE5E7EB), badgeTextColor: Color(0xFF374151)),
      FilterOptionModel(label: 'In Progress', badgeColor: Color(0xFFDBEAFE), badgeTextColor: Color(0xFF2563EB)),
      FilterOptionModel(label: 'In Review', badgeColor: Color(0xFFDBEAFE), badgeTextColor: Color(0xFF2563EB)),
      FilterOptionModel(label: 'Done', badgeColor: Color(0xFFDCFCE7), badgeTextColor: Color(0xFF16A34A)),
    ],
    'Priority': const [
      FilterOptionModel(label: 'Highest', icon: Icons.keyboard_double_arrow_up, iconBg: Color(0xFFFEE2E2), iconColor: Color(0xFFDC2626)),
      FilterOptionModel(label: 'High', icon: Icons.keyboard_arrow_up, iconBg: Color(0xFFFEE2E2), iconColor: Color(0xFFDC2626)),
      FilterOptionModel(label: 'Medium', icon: Icons.drag_handle, iconBg: Color(0xFFFFEDD5), iconColor: Color(0xFFEA580C)),
      FilterOptionModel(label: 'Low', icon: Icons.keyboard_arrow_down, iconBg: Color(0xFFDBEAFE), iconColor: Color(0xFF2563EB)),
      FilterOptionModel(label: 'Lowest', icon: Icons.keyboard_double_arrow_down, iconBg: Color(0xFFDBEAFE), iconColor: Color(0xFF2563EB)),
    ],
    'Assignee': const [
      FilterOptionModel(label: 'Unassigned', icon: Icons.person_off_outlined),
      FilterOptionModel(label: 'Priya jha'),
    ],
    'Reporter': const [
      FilterOptionModel(label: 'Priya Jha'),
      FilterOptionModel(label: 'Rahul Sharma'),
    ],
    'Resolution': const [
      FilterOptionModel(label: 'Unresolved'),
      FilterOptionModel(label: "Done"),
    ],
    'Label': const [],
    'Component': const [
      FilterOptionModel(label: 'UI'),
      FilterOptionModel(label: 'API'),
      FilterOptionModel(label: 'Database'),
    ],
    'Fix Version': const [],
    'Affect Version': const [],
    'Order By': const [
      FilterOptionModel(label: 'Created'),
      FilterOptionModel(label: 'Updated'),
      FilterOptionModel(label: 'Last Viewed'),
      FilterOptionModel(label: 'Priority'),
      FilterOptionModel(label: 'Work item key'),
    ],
    'Sprint': const [
      FilterOptionModel(label: 'Sprint 1', subtitle: 'A3 board'),
      FilterOptionModel(label: 'Sprint 2', subtitle: 'SCRUM board'),
    ],
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onChipTap(String chipLabel) {
    if (chipLabel == 'Basic') {
      SearchTypeBottomSheet.show(
        context,
        selected: _searchType,
        onSelected: (type) => setState(() => _searchType = type),
      );
      return;
    }

    if (chipLabel == 'Order By') {
      final options = _optionData['Order By']?.map((e) => e.label).toList() ?? [];
       OrderByBottomSheet.show(
        context,
        options: options,
        selectedOption: _selectedOrderBy,
        onSelected: (newValue) {
          setState(() => _selectedOrderBy = newValue);
        },
        onReset: () {
          setState(() => _selectedOrderBy = 'Created');
        },
      );
      return;
    }

    final options = _optionData[chipLabel];
    if (options == null) return;

    MultiSelectFilterSheet.show(
      context,
      title: 'Search ${chipLabel.toLowerCase()}',
      filterByLabel: 'Filter by ${chipLabel.toLowerCase()}',
      options: options,
      selectedLabels: _selectedValues[chipLabel] ?? [],
      onChanged: (selected) {
        setState(() => _selectedValues[chipLabel] = selected);
      },
    );
  }

  String _chipDisplayLabel(String chipLabel) {
    if (chipLabel == 'Basic') {
      switch (_searchType) {
        case SearchType.basic:
          return 'Basic';
        case SearchType.jql:
          return 'JQL';
        case SearchType.aiSearch:
          return 'AI search';
      }
    }
    if (chipLabel == 'Order By') {
      return _selectedOrderBy;
    }
    final count = _selectedValues[chipLabel]?.length ?? 0;
    return count > 0 ? '$chipLabel ($count)' : chipLabel;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AllWorkProvider>(context);

    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      appBar: AppBar(
        backgroundColor: CustomColor.appbar(context),
        elevation: 0,
        leadingWidth: 40,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: CustomColor.arrowback(context)),
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.zero,
        ),
        title: TextField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: provider.setSearchQuery,
          style: TextStyle(color: CustomColor.textPrimary(context), fontSize: 18),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: CustomColor.inputHintDefault(context), fontSize: 18),
            border: InputBorder.none,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Save search',
              style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter chips row
          SizedBox(
            height: 52,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _filterChips.length,
              separatorBuilder: (_, i) {
                if (i == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(Icons.arrow_forward_ios, size: 12, color: CustomColor.textMutedLabel(context)),
                  );
                }
                return const SizedBox(width: 8);
              },
              itemBuilder: (context, index) {
                final chipLabel = _filterChips[index];

                final isOrderBy = chipLabel == 'Order By';
                final hasSelection = !isOrderBy && chipLabel != 'Basic' &&
                    (_selectedValues[chipLabel]?.isNotEmpty ?? false);
                final isBasicSelected = chipLabel == 'Basic';

                // Active blue styling condition matching the design image
                final isActiveChip = isBasicSelected || hasSelection || isOrderBy;

                return GestureDetector(
                  onTap: () => _onChipTap(chipLabel),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: isActiveChip
                          ? (isOrderBy ? const Color(0xFFDBEAFE) : CustomColor.chipSelectedBg(context))
                          : CustomColor.card_bg(context),
                      borderRadius: BorderRadius.circular(8), // Flattened radius style matching the screenshot
                      border: Border.all(
                        color: isActiveChip
                            ? (isOrderBy ? const Color(0xFFDBEAFE) : CustomColor.chipSelectedBg(context))
                            : CustomColor.chipUnselectedBorder(context),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _chipDisplayLabel(chipLabel),
                          style: TextStyle(
                            color: isActiveChip
                                ? (isOrderBy ? const Color(0xFF1E40AF) : CustomColor.chipSelectedText(context))
                                : CustomColor.textMutedLabel(context),
                            fontSize: 14,
                            fontWeight: isActiveChip ? FontWeight.w500 : FontWeight.normal,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 16,
                          color: isActiveChip
                              ? (isOrderBy ? const Color(0xFF1E40AF) : CustomColor.chipSelectedText(context))
                              : CustomColor.textMutedLabel(context),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Divider(height: 1, color: CustomColor.dividerColor(context)),

          // Dynamic Result list items matching image context
          Expanded(
            child: _controller.text.isEmpty
                ? const Center(child: Text("Start typing to view results"))
                : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    '2 results',
                    style: TextStyle(fontSize: 14, color: CustomColor.textMutedLabel(context)),
                  ),
                ),
                ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.bookmark_border, color: Colors.green),
                  ),
                  title: Text('Helooo', style: TextStyle(color: CustomColor.textPrimary(context), fontWeight: FontWeight.w500)),
                  subtitle: Text('SCRUM-8', style: TextStyle(color: CustomColor.textMutedLabel(context))),
                ),
                ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.bolt, color: Colors.purple),
                  ),
                  title: Text('Hii', style: TextStyle(color: CustomColor.textPrimary(context), fontWeight: FontWeight.w500)),
                  subtitle: Text('SCRUM-7', style: TextStyle(color: CustomColor.textMutedLabel(context))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}