import 'package:flutter/material.dart';
import '../../providers/home_screen/create(+)/create_screen_provider.dart';
import '../color/custom_color.dart';
import '../model/custom_model.dart';
import '../tile/custom_tile.dart';


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
      child: SingleChildScrollView(
        child: Column(
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
            const SizedBox(height: 16),
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
            if (_filtered.isEmpty)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    'No assignee found',
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
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
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
                physics: const NeverScrollableScrollPhysics(),
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
      ),
    );
  }
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
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        _focusNode.requestFocus());
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
      padding: EdgeInsets.only(bottom: MediaQuery
          .of(context)
          .viewInsets
          .bottom),
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
                    Divider(
                        height: 1, color: CustomColor.dividerColor(context)),
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
    TeamModel(
        name: 'Design Team', initials: 'DT', avatarColor: Color(0xFF7C3AED)),
    TeamModel(
        name: 'Backend Team', initials: 'BT', avatarColor: Color(0xFF0891B2)),
    TeamModel(
        name: 'Frontend Team', initials: 'FT', avatarColor: Color(0xFF16A34A)),
    TeamModel(name: 'QA Team', initials: 'QA', avatarColor: Color(0xFFD97706)),
    TeamModel(
        name: 'DevOps Team', initials: 'DO', avatarColor: Color(0xFFDC2626)),
  ];

  List<TeamModel> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = _allTeams;
    _searchController.addListener(_onSearch);
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        _focusNode.requestFocus());
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
      padding: EdgeInsets.only(bottom: MediaQuery
          .of(context)
          .viewInsets
          .bottom),
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
              trailing: widget.currentTeam == null ||
                  widget.currentTeam == 'None'
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
                    Divider(
                        height: 1, color: CustomColor.dividerColor(context)),
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
class ReportBottomSheet extends StatefulWidget {
  final String? selectedReports;
  final ValueChanged<ReportModel?> onSelected;

  const ReportBottomSheet({
    super.key,
    this.selectedReports,
    required this.onSelected,
  });

  static Future<void> show(
      BuildContext context, {
        String? selectedReports,
        required ValueChanged<ReportModel?> onSelected,
      }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ReportBottomSheet(
        selectedReports: selectedReports,
        onSelected: onSelected,
      ),
    );
  }

  @override
  State<ReportBottomSheet> createState() => _ReportBottomSheetState();
}

class _ReportBottomSheetState extends State<ReportBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<ReportModel> _allReports = const [
    ReportModel(name: 'Automatic', initials: 'A', avatarColor: Color(0xFF6366F1)),
    ReportModel(name: 'Report1', initials: 'PJ', avatarColor: Color(0xFF7C3AED)),
    ReportModel(name: 'Report2', initials: 'RS', avatarColor: Color(0xFF0891B2)),

  ];

  List<ReportModel> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = _allReports;
    _searchController.addListener(_onSearch);
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  void _onSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filtered = _allReports
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
                'reports',
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
                      setState(() => _filtered = _allReports);
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
                final isSelected = assignee.name == widget.selectedReports;

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
class WatchersBottomSheet extends StatefulWidget {
  final List<String> selectedWatchers;
  final ValueChanged<List<String>>onSelected;

  const WatchersBottomSheet({
    super.key,
    this.selectedWatchers = const [],
    required this.onSelected,
  });

  static Future<void> show(
      BuildContext context,{
        List<String> selectedWatchers = const [],
        required ValueChanged<List<String>> onSelected,
      }
      ){
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      builder: (_) => WatchersBottomSheet(
        selectedWatchers: selectedWatchers,
        onSelected: onSelected,
      ),
    );
  }

  @override
  State<WatchersBottomSheet> createState() => _WatchersBottomSheetState();
}

class _WatchersBottomSheetState extends State<WatchersBottomSheet> {
  final TextEditingController _searchController = TextEditingController();

  final List<WatchersModel> _allUsers = const[
    WatchersModel(
      name: 'Priya jha',
      initials: 'PJ',
      avatarColor:Color(0xFF5B21B6),
    ),
    WatchersModel(
      name: 'Jyoti Mandal',
      initials: 'JM',
      avatarColor:Color(0xFF0052CC),
    ),
    WatchersModel(
      name: 'Prasuna ',
      initials: 'P',
      avatarColor:Color(0xFF00875A),
    ),
  ];

  late List<String> _selected;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _selected = List<String>.from(widget.selectedWatchers);
    _searchController.addListener(
          () => setState(() => _query = _searchController.text.trim().toLowerCase()),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<WatchersModel> get _selectedUsers =>
      _allUsers.where((u) => _selected.contains(u.name)).toList();

  List<WatchersModel> get _filteredSelected {
    if (_query.isEmpty) return _selectedUsers;
    return _selectedUsers
        .where((u) => u.name.toLowerCase().contains(_query))
        .toList();
  }

  List<WatchersModel> get _otherUsers {
    final unselected =
    _allUsers.where((u) => !_selected.contains(u.name)).toList();
    if (_query.isEmpty) return unselected;
    return unselected
        .where((u) => u.name.toLowerCase().contains(_query))
        .toList();
  }

  void _toggle(WatchersModel user) {
    setState(() {
      if (_selected.contains(user.name)) {
        _selected.remove(user.name);
      } else {
        _selected.add(user.name);
      }
    });
  }

  void _clearAll() => setState(() => _selected.clear());

  void _done() {
    widget.onSelected(_selected);
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
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
                color: CustomColor.textMutedLabel(context),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Watchers',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w400,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
                TextButton(
                  onPressed: _done,
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.actionBlueText(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: CustomColor.box_decoration(context),
                borderRadius: BorderRadius.circular(28),
              ),
              child: TextField(
                controller: _searchController,
                style: TextStyle(
                  color: CustomColor.textPrimary(context),
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  hintText: 'Search users',
                  hintStyle: TextStyle(
                    color: CustomColor.textMutedLabel(context),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: CustomColor.textMutedLabel(context),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ConstrainedBox(constraints: BoxConstraints(
            maxHeight:  MediaQuery.of(context).size.height * 0.52,
          ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_filteredSelected.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Selected',
                              style: TextStyle(
                                fontSize: 13,
                                color: CustomColor.textMutedLabel(context),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: _clearAll,
                              child: Text(
                                'Clear',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: CustomColor.actionBlueText(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      ..._filteredSelected.map(
                            (u) => WatcherTile(
                          user: u,
                          isSelected: true,
                          onTap: () => _toggle(u),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    if (_otherUsers.isNotEmpty) ...[
                      if (_filteredSelected.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Other items',
                            style: TextStyle(
                              fontSize: 13,
                              color: CustomColor.textMutedLabel(context),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      const SizedBox(height: 10),
                      ..._otherUsers.map(
                            (u) => WatcherTile(
                          user: u,
                          isSelected: false,
                          onTap: () => _toggle(u),
                        ),
                      ),
                    ],

                    // ── Empty state ──
                    if (_filteredSelected.isEmpty && _otherUsers.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Center(
                          child: Text(
                            'No users found',
                            style: TextStyle(
                              fontSize: 15,
                              color: CustomColor.textMutedLabel(context),
                            ),
                          ),
                        ),
                      ),

                    const SizedBox(height: 24),
                  ],
                ),

              )
          ),
        ],
      ),
    );
  }
}
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

  static void show(BuildContext context, {
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
      builder: (_) =>
          TemplateBottomSheet(
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
        maxHeight: MediaQuery
            .of(context)
            .size
            .height * 0.85,
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
              separatorBuilder: (_, __) =>
              const Padding(
                padding: EdgeInsets.only(left: 88.0),
                child: Divider(
                    height: 1, thickness: 0.8, color: Color(0xFFF5F5F5)),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 16.0),
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
                          child: Icon(
                              item.icon, color: item.iconColor, size: 24),
                        ),
                        const SizedBox(width: 20),

// Text Description Grouping Block
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: TextStyle(
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
                            child: Icon(
                                Icons.check, color: Colors.blue, size: 22),
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
class SearchTypeBottomSheet extends StatelessWidget {
  final SearchType selected;
  final ValueChanged<SearchType> onSelected;

  const SearchTypeBottomSheet({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  static Future<void> show(
      BuildContext context, {
        required SearchType selected,
        required ValueChanged<SearchType> onSelected,
      }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SearchTypeBottomSheet(selected: selected, onSelected: onSelected),
    );
  }

  Widget _tile({
    required BuildContext context,
    required String label,
    Widget? badge,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: CustomColor.chipUnselectedBg(context),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: CustomColor.textPrimary(context),
              ),
            ),
            if (badge != null) ...[
              const SizedBox(width: 8),
              badge,
            ],
            const Spacer(),
            Radio<bool>(
              value: true,
              groupValue: isSelected,
              activeColor: CustomColor.actionBlueText(context),
              onChanged: (_) => onTap(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Text(
              'Search type',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: CustomColor.textPrimary(context),
              ),
            ),
          ),
          _tile(
            context: context,
            label: 'Basic',
            isSelected: selected == SearchType.basic,
            onTap: () {
              onSelected(SearchType.basic);
              Navigator.pop(context);
            },
          ),
          _tile(
            context: context,
            label: 'JQL',
            isSelected: selected == SearchType.jql,
            onTap: () {
              onSelected(SearchType.jql);
              Navigator.pop(context);
            },
          ),
          _tile(
            context: context,
            label: 'AI search',
            badge: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFF3E8FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'New',
                style: TextStyle(
                  color: Color(0xFFB554E0),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            isSelected: selected == SearchType.aiSearch,
            onTap: () {
              onSelected(SearchType.aiSearch);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
class OrderByBottomSheet extends StatelessWidget {
  final String selectedOption;
  final List<String> options;
  final ValueChanged<String> onSelected;
  final VoidCallback onReset;

  const OrderByBottomSheet({
    super.key,
    required this.selectedOption,
    required this.options,
    required this.onSelected,
    required this.onReset,
  });

  static Future<void> show(
      BuildContext context, {
        required String selectedOption,
        required List<String> options,
        required ValueChanged<String> onSelected,
        required VoidCallback onReset,
      }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => OrderByBottomSheet(
        selectedOption: selectedOption,
        options: options,
        onSelected: onSelected,
        onReset: onReset,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: CustomColor.dividerColor(context).withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order by',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    onReset();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...options.map((option) {
            final isSelected = option.toLowerCase() == selectedOption.toLowerCase();
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
              title: Text(
                option,
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected ? Colors.blue : CustomColor.textPrimary(context),
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
              trailing: isSelected
                  ? const Icon(Icons.arrow_downward, color: Colors.blue)
                  : null,
              onTap: () {
                onSelected(option);
                Navigator.pop(context);
              },
            );
          }),
        ],
      ),
    );
  }
}
// ── Work Type Bottom Sheet ─────────────────────────────────────────────────────
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
        ...options.map(
              (option) => WorkTypeTile(
            option: option,
            isSelected: option.type == selectedType,
            onTap: () {
              onSelected(option.type);
              Navigator.pop(context);
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
// ── App Selector Bottom Sheet ──────────────────────────────────────────────────
class AppSelectorBottomSheet extends StatelessWidget {
  final CreateProvider provider;

  const AppSelectorBottomSheet({super.key, required this.provider});

  static void show(BuildContext context, CreateProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext bc) {
        return SafeArea(child: AppSelectorBottomSheet(provider: provider));
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
            color: CustomColor.dividerColor(context),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Select App',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: CustomColor.textPrimary(context),
            ),
          ),
        ),
        Divider(height: 1, color: CustomColor.dividerColor(context)),
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
                  ? Icon(Icons.check_circle, color: CustomColor.actionBlueText(context))
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


class AttachmentBottomSheet {
  static void show(
      BuildContext context, {
        required VoidCallback onChooseFile,
        required VoidCallback onTakePhoto,
        required VoidCallback onRecordVideo,
      }) {
    final options = [
      {
        'icon': Icons.attach_file,
        'label': 'Choose file',
        'onTap': onChooseFile,
      },
      {
        'icon': Icons.camera_alt_outlined,
        'label': 'Take photo',
        'onTap': onTakePhoto,
      },
      {
        'icon': Icons.videocam_outlined,
        'label': 'Record video',
        'onTap': onRecordVideo,
      },
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const SizedBox(height: 20),
            Text(
              'Add attachment',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: CustomColor.textPrimary(context),
              ),
            ),
            const SizedBox(height: 20),
            ...options.map(
                  (o) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context); // Bottom sheet close garchha
                    (o['onTap'] as VoidCallback)(); // Tyo option ko page open garchha
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                    decoration: BoxDecoration(
                      color: CustomColor.chipUnselectedBg(context),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: CustomColor.bg_color(context),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            o['icon'] as IconData,
                            color: CustomColor.textMutedLabel(context),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          o['label'] as String,
                          style: TextStyle(
                            fontSize: 16,
                            color: CustomColor.textPrimary(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




