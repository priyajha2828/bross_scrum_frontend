import 'package:flutter/material.dart';
import '../color/custom_color.dart';

class TeamModel {
  final String name;
  final String initials;
  final Color avatarColor;

  const TeamModel({
    required this.name,
    required this.initials,
    required this.avatarColor,
  });
}

class TeamBottomSheet extends StatefulWidget {
  final String? currentTeam;
  final ValueChanged<TeamModel?> onSelected;

  const TeamBottomSheet({
    super.key,
    this.currentTeam,
    required this.onSelected,
  });

  static Future<void> show(
      BuildContext context, {
        String? currentTeam,
        required ValueChanged<TeamModel?> onSelected,
      }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => TeamBottomSheet(
        currentTeam: currentTeam,
        onSelected: onSelected,
      ),
    );
  }

  @override
  State<TeamBottomSheet> createState() => _TeamBottomSheetState();
}

class _TeamBottomSheetState extends State<TeamBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<TeamModel> _allTeams = const [
    TeamModel(name: 'Design Team', initials: 'DT', avatarColor: Color(0xFF7C3AED)),
    TeamModel(name: 'Backend Team', initials: 'BT', avatarColor: Color(0xFF0891B2)),
    TeamModel(name: 'Frontend Team', initials: 'FT', avatarColor: Color(0xFF16A34A)),
    TeamModel(name: 'QA Team', initials: 'QA', avatarColor: Color(0xFFD97706)),
    TeamModel(name: 'DevOps Team', initials: 'DO', avatarColor: Color(0xFFDC2626)),
  ];

  List<TeamModel> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = _allTeams;
    _searchController.addListener(_onSearch);
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  void _onSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filtered = _allTeams
          .where((t) => t.name.toLowerCase().contains(query))
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
                'Team',
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
                    hintText: 'Search team...',
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
                        setState(() => _filtered = _allTeams);
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

            // None option (default)
            ListTile(
              leading: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: CustomColor.chipUnselectedBg(context),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.group_off_outlined,
                  color: CustomColor.textMutedLabel(context),
                  size: 20,
                ),
              ),
              title: Text(
                'None',
                style: TextStyle(
                  color: CustomColor.textMutedLabel(context),
                  fontSize: 15,
                ),
              ),
              trailing: widget.currentTeam == null || widget.currentTeam == 'None'
                  ? Icon(
                Icons.check_circle,
                color: CustomColor.actionBlueText(context),
              )
                  : null,
              onTap: () {
                widget.onSelected(null);
                Navigator.pop(context);
              },
            ),

            Divider(height: 1, color: CustomColor.dividerColor(context)),

            // Teams list
            if (_filtered.isEmpty)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    'No team found',
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
                  final team = _filtered[index];
                  final isSelected = team.name == widget.currentTeam;

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: team.avatarColor,
                      radius: 19,
                      child: Text(
                        team.initials,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      team.name,
                      style: TextStyle(
                        color: CustomColor.textPrimary(context),
                        fontSize: 15,
                        fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                    trailing: isSelected
                        ? Icon(
                      Icons.check_circle,
                      color: CustomColor.actionBlueText(context),
                    )
                        : null,
                    onTap: () {
                      widget.onSelected(team);
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