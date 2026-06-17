import 'package:flutter/material.dart';
import '../color/custom_color.dart';

class SprintModel {
  final String name;
  final String subtitle;
  final String type; // 'none' | 'active' | 'future'

  const SprintModel({
    required this.name,
    required this.subtitle,
    required this.type,
  });
}

class SprintBottomSheet extends StatefulWidget {
  final String? currentSprint;
  final ValueChanged<SprintModel?> onSelected;

  const SprintBottomSheet({
    super.key,
    this.currentSprint,
    required this.onSelected,
  });

  static Future<void> show(
      BuildContext context, {
        String? currentSprint,
        required ValueChanged<SprintModel?> onSelected,
      }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SprintBottomSheet(
        currentSprint: currentSprint,
        onSelected: onSelected,
      ),
    );
  }

  @override
  State<SprintBottomSheet> createState() => _SprintBottomSheetState();
}

class _SprintBottomSheetState extends State<SprintBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<SprintModel> _allSprints = const [
    SprintModel(
      name: 'None',
      subtitle: '',
      type: 'none',
    ),
    SprintModel(
      name: 'Active Sprints',
      subtitle: 'SCRUM board',
      type: 'active',
    ),
    SprintModel(
      name: 'A# Sprint 1',
      subtitle: 'A3 board',
      type: 'future',
    ),
  ];

  List<SprintModel> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = _allSprints;
    _searchController.addListener(_onSearch);
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  void _onSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filtered = _allSprints
          .where((s) =>
      s.name.toLowerCase().contains(query) ||
          s.subtitle.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Widget _buildSprintIcon(SprintModel sprint) {
    if (sprint.type == 'none') {
      return Container(
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
      );
    } else if (sprint.type == 'active') {
      return Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: const Color(0xFFDCFCE7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.flash_on,
          color: Color(0xFF16A34A),
          size: 20,
        ),
      );
    } else {
      return Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: const Color(0xFFDBEAFE),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.schedule,
          color: Color(0xFF2563EB),
          size: 20,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
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
                'Sprint',
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
                    hintText: 'Search sprint...',
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
                        setState(() => _filtered = _allSprints);
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

            // Sprint list
            if (_filtered.isEmpty)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    'No sprint found',
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
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _filtered.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, color: CustomColor.dividerColor(context)),
                itemBuilder: (context, index) {
                  final sprint = _filtered[index];
                  final isSelected = sprint.name == widget.currentSprint ||
                      (sprint.type == 'none' &&
                          (widget.currentSprint == null ||
                              widget.currentSprint == 'None'));

                  return ListTile(
                    leading: _buildSprintIcon(sprint),
                    title: Text(
                      sprint.name,
                      style: TextStyle(
                        color: CustomColor.textPrimary(context),
                        fontSize: 15,
                        fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                    subtitle: sprint.subtitle.isNotEmpty
                        ? Text(
                      sprint.subtitle,
                      style: TextStyle(
                        color: CustomColor.textMutedLabel(context),
                        fontSize: 12,
                      ),
                    )
                        : null,
                    trailing: isSelected
                        ? Icon(
                      Icons.check_circle,
                      color: CustomColor.actionBlueText(context),
                    )
                        : null,
                    onTap: () {
                      widget.onSelected(
                          sprint.type == 'none' ? null : sprint);
                      Navigator.pop(context);
                    },
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