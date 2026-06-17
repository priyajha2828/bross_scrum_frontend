import 'package:flutter/material.dart';
import '../../../../resources/color/custom_color.dart';

class AssigneeModel {
  final String name;
  final String initials;
  final Color avatarColor;

  const AssigneeModel({
    required this.name,
    required this.initials,
    required this.avatarColor,
  });
}

class AssigneeBottomSheet extends StatefulWidget {
  final String? selectedAssignee;
  final ValueChanged<AssigneeModel?> onSelected;

  const AssigneeBottomSheet({
    super.key,
    this.selectedAssignee,
    required this.onSelected,
  });

  static Future<void> show(
      BuildContext context, {
        String? selectedAssignee,
        required ValueChanged<AssigneeModel?> onSelected,
      }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => AssigneeBottomSheet(
        selectedAssignee: selectedAssignee,
        onSelected: onSelected,
      ),
    );
  }

  @override
  State<AssigneeBottomSheet> createState() => _AssigneeBottomSheetState();
}

class _AssigneeBottomSheetState extends State<AssigneeBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<AssigneeModel> _allAssignees = const [
    AssigneeModel(name: 'Automatic', initials: 'A', avatarColor: Color(0xFF6366F1)),
    AssigneeModel(name: 'Priya Jha', initials: 'PJ', avatarColor: Color(0xFF7C3AED)),
    AssigneeModel(name: 'Rahul Sharma', initials: 'RS', avatarColor: Color(0xFF0891B2)),

  ];

  List<AssigneeModel> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = _allAssignees;
    _searchController.addListener(_onSearch);
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  void _onSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filtered = _allAssignees
          .where((a) => a.name.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),

          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: CustomColor.dividerColor(context),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 16),

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Assignee',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.textPrimary(context),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Search bar
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
                  hintText: 'Search assignee...',
                  hintStyle: TextStyle(
                    color: CustomColor.inputHintDefault(context),
                    fontSize: 15,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: CustomColor.textMutedLabel(context),
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: CustomColor.textMutedLabel(context),
                    ),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _filtered = _allAssignees);
                    },
                  )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          Divider(height: 1, color: CustomColor.dividerColor(context)),

          // Unassign option
          ListTile(
            leading: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: CustomColor.chipUnselectedBg(context),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person_off_outlined,
                color: CustomColor.textMutedLabel(context),
                size: 20,
              ),
            ),
            title: Text(
              'Unassigned',
              style: TextStyle(
                color: CustomColor.textMutedLabel(context),
                fontSize: 15,
              ),
            ),
            onTap: () {
              widget.onSelected(null);
              Navigator.pop(context);
            },
          ),

          Divider(height: 1, color: CustomColor.dividerColor(context)),

          // Suggestions list
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.4,
            ),
            child: _filtered.isEmpty
                ? Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'No assignee found',
                style: TextStyle(
                  color: CustomColor.textMutedLabel(context),
                  fontSize: 14,
                ),
              ),
            )
                : ListView.separated(
              shrinkWrap: true,
              itemCount: _filtered.length,
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: CustomColor.dividerColor(context)),
              itemBuilder: (context, index) {
                final assignee = _filtered[index];
                final isSelected = assignee.name == widget.selectedAssignee;

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: assignee.avatarColor,
                    radius: 19,
                    child: Text(
                      assignee.initials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    assignee.name,
                    style: TextStyle(
                      color: CustomColor.textPrimary(context),
                      fontSize: 15,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(
                    Icons.check_circle,
                    color: CustomColor.actionBlueText(context),
                  )
                      : null,
                  onTap: () {
                    widget.onSelected(assignee);
                    Navigator.pop(context);
                  },
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