import 'package:flutter/material.dart';
import '../color/custom_color.dart';

class ParentModel {
  final String name;
  final String type;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;

  const ParentModel({
    required this.name,
    required this.type,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });
}

class ParentBottomSheet extends StatefulWidget {
  final String? currentParent;
  final ValueChanged<ParentModel?> onSelected;

  const ParentBottomSheet({
    super.key,
    this.currentParent,
    required this.onSelected,
  });

  static Future<void> show(
      BuildContext context, {
        String? currentParent,
        required ValueChanged<ParentModel?> onSelected,
      }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ParentBottomSheet(
        currentParent: currentParent,
        onSelected: onSelected,
      ),
    );
  }

  @override
  State<ParentBottomSheet> createState() => _ParentBottomSheetState();
}

class _ParentBottomSheetState extends State<ParentBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<ParentModel> _allParents = const [
    ParentModel(
      name: 'Epic 1',
      type: 'Epic',
      icon: Icons.bolt,
      iconColor: Color(0xFFB554E0),
      iconBg: Color(0xFFF3E8FF),
    ),

    ParentModel(
      name: 'Story 1',
      type: 'Story',
      icon: Icons.bookmark_border,
      iconColor: Color(0xFF16A34A),
      iconBg: Color(0xFFDCFCE7),
    ),

    ParentModel(
      name: 'Task 1',
      type: 'Task',
      icon: Icons.check_circle_outline,
      iconColor: Color(0xFF2563EB),
      iconBg: Color(0xFFDBEAFE),
    ),
  ];

  List<ParentModel> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = _allParents;
    _searchController.addListener(_onSearch);
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  void _onSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filtered = _allParents
          .where((p) =>
      p.name.toLowerCase().contains(query) ||
          p.type.toLowerCase().contains(query))
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
      child: SingleChildScrollView(          // ← add this
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // Drag handle
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

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Search Parents',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.textPrimary(context),
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
                    hintText: 'Search parents...',
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
                        setState(() => _filtered = _allParents);
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

            // No parent option
            ListTile(
              leading: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: CustomColor.chipUnselectedBg(context),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.block,
                  color: CustomColor.textMutedLabel(context),
                  size: 20,
                ),
              ),
              title: Text(
                'No Parent',
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

            // Results list — remove ConstrainedBox, use shrinkWrap only
            if (_filtered.isEmpty)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    'No parents found',
                    style: TextStyle(
                      color: CustomColor.textMutedLabel(context),
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // ← important
                itemCount: _filtered.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, color: CustomColor.dividerColor(context)),
                itemBuilder: (context, index) {
                  final parent = _filtered[index];
                  final isSelected = parent.name == widget.currentParent;

                  return ListTile(
                    leading: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: parent.iconBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(parent.icon, color: parent.iconColor, size: 20),
                    ),
                    title: Text(
                      parent.name,
                      style: TextStyle(
                        color: CustomColor.textPrimary(context),
                        fontSize: 15,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                    subtitle: Text(
                      parent.type,
                      style: TextStyle(
                        color: CustomColor.textMutedLabel(context),
                        fontSize: 12,
                      ),
                    ),
                    trailing: isSelected
                        ? Icon(
                      Icons.check_circle,
                      color: CustomColor.actionBlueText(context),
                    )
                        : null,
                    onTap: () {
                      widget.onSelected(parent);
                      Navigator.pop(context);
                    },
                  );
                },
              ),

            const SizedBox(height: 16),
          ],
        ),
      ),      // ← close SingleChildScrollView
    );
  }


}