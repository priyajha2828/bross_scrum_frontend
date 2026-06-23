import 'package:BrossScrum/resources/color/custom_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/home_screen/dashboard/scrum/scrum_provider.dart';
import '../../../../resources/bottom/assignee_bottom_sheet.dart';
import '../../../../resources/model/assignee_model.dart';
import '../../../../resources/model/sprint_model.dart';
import '../../../../resources/model/team_model.dart';
import '../../../../resources/widget/scrum_widgets.dart';

class ScrumScreen extends StatefulWidget {
  const ScrumScreen({super.key});

  @override
  State<ScrumScreen> createState() => _ScrumScreenState();
}

class _ScrumScreenState extends State<ScrumScreen> {
  bool _isEditingTitle = false;
  late TextEditingController _titleController;

  final TextEditingController _commentController = TextEditingController();
  bool _isGeneralExpanded = true;
  bool _isParentExpanded = true;
  bool _isDetailsExpanded = false;
  bool _isMoreFieldsExpanded = true;

  @override
  void initState(){
    super.initState();
    _titleController = TextEditingController();
  }
  @override
  void dispose() {
    _commentController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScrumProvider>(context);

    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      appBar: AppBar(
        backgroundColor: CustomColor.appbar(context),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.visibility_outlined,
              color: CustomColor.textPrimary(context),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.attach_file,
              color: CustomColor.textPrimary(context),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: CustomColor.textPrimary(context),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: CustomColor.box_decoration(context),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.bolt,
                    color: Color(0xFFB554E0),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    provider.issueKey.isNotEmpty ? provider.issueKey : 'SCRUM-10',
                    style: TextStyle(
                      fontSize: 14,
                      color: CustomColor.textMutedLabel(context),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _isEditingTitle
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _titleController,
                        autofocus: true,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                          color: CustomColor.textPrimary(context),
                        ),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: CustomColor.actionBlueText(context),
                              width: 2,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: CustomColor.actionBlueText(context),
                              width: 2,
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: () => setState(() => _isEditingTitle = false),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              side: BorderSide(color: CustomColor.dividerColor(context)),
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: CustomColor.textPrimary(context)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              provider.updateTitle(_titleController.text.trim());
                              setState(() => _isEditingTitle = false);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColor.actionBlueText(context),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                            ),
                            child: const Text(
                              'Save',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                      : TextButton(
                    onPressed: () {
                      _titleController.text =
                      provider.title.isNotEmpty ? provider.title : provider.initialTitle;
                      setState(() => _isEditingTitle = true);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                    ),
                    child: Text(
                      provider.title.isNotEmpty ? provider.title : provider.initialTitle,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        color: CustomColor.textPrimary(context),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                if (!_isEditingTitle)
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: CustomColor.chipUnselectedBg(context),
                    child: IconButton(
                      onPressed: () => AssigneeBottomSheet.show(
                        context,
                        selectedAssignee: provider.assignee?.name,
                        onSelected: provider.setAssignee,
                      ),
                      icon: Icon(
                        CupertinoIcons.person_crop_circle_fill,
                        color: CustomColor.textMutedLabel(context),
                        size: 28,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _showTransitionSheet(context, provider),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: CustomColor.chipUnselectedBg(context),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: CustomColor.chipUnselectedBorder(context),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      provider.status,
                      style: TextStyle(
                        fontSize: 15,
                        color: CustomColor.textPrimary(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      Icons.arrow_drop_down,
                      color: CustomColor.textMutedLabel(context),
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ExpandableSection(
              title: 'General',
              isExpanded: _isGeneralExpanded,
              onToggle: () => setState(() => _isGeneralExpanded = !_isGeneralExpanded),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 13,
                        color: CustomColor.textMutedLabel(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      provider.description.isEmpty ? 'None' : provider.description,
                      style: TextStyle(
                        fontSize: 15,
                        color: provider.description.isEmpty
                            ? CustomColor.textMutedLabel(context)
                            : CustomColor.textPrimary(context),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            ExpandableSection(
              title: 'Parent work item',
              isExpanded: _isParentExpanded,
              onToggle: () => setState(() => _isParentExpanded = !_isParentExpanded),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Text(
                  'None',
                  style: TextStyle(
                    fontSize: 15,
                    color: CustomColor.textMutedLabel(context),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ExpandableSection(
              title: 'Details',
              isExpanded: _isDetailsExpanded,
              onToggle: () => setState(() => _isDetailsExpanded = !_isDetailsExpanded),
              collapsedSubtitle: 'Issue Type, Assignee, Labels, Team, and Due date',
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DetailRow(
                      label: 'Issue Type',
                      isRequired: true,
                      onTap: () => _showIssueTypeSheet(context, provider),
                      child: Row(
                        children: [
                          Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              color: CustomColor.isDark(context)
                                  ? const Color(0xFF1E3A5F)
                                  : const Color(0xFFE8F0FE),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.link,
                              color: Color(0xFF4285F4),
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            provider.issueType,
                            style: TextStyle(
                              fontSize: 15,
                              color: CustomColor.textPrimary(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 24, color: CustomColor.dividerColor(context)),
                    _DetailRow(
                      label: 'Assignee',
                      onTap: () => AssigneeBottomSheet.show(
                        context,
                          selectedAssignee: provider.assignee?.name,
                          onSelected: provider.setAssignee),
                      child: Text(
                        provider.assignee?.name ?? 'Unassigned',
                        style: TextStyle(
                          fontSize: 15,
                          color: provider.assignee == null
                              ? CustomColor.textMutedLabel(context)
                              : CustomColor.textPrimary(context),
                        ),
                      ),
                    ),
                    Divider(height: 24, color: CustomColor.dividerColor(context)),
                    _DetailRow(
                      label: 'Labels',
                      onTap: () => _showLabelsSheet(context, provider),
                      child: provider.labels.isEmpty
                          ? Text(
                        'None',
                        style: TextStyle(
                          fontSize: 15,
                          color: CustomColor.textMutedLabel(context),
                        ),
                      )
                          : Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: provider.labels
                            .map((l) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: CustomColor.chipUnselectedBg(context),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: CustomColor.chipUnselectedBorder(context)),
                          ),
                          child: Text(
                            l,
                            style: TextStyle(
                              fontSize: 13,
                              color: CustomColor.textPrimary(context),
                            ),
                          ),
                        ))
                            .toList(),
                      ),
                    ),
                    Divider(height: 24, color: CustomColor.dividerColor(context)),
                    _DetailRow(
                      label: 'Team',
                      onTap: () => TeamBottomSheet.show(
                        context,
                        currentTeam: provider.team,
                        onSelected: provider.setTeam,
                      ),
                      child: Row(
                        children: [
                          if (provider.teamModel != null)
                            CircleAvatar(
                              backgroundColor: provider.teamModel!.avatarColor,
                              radius: 14,
                              child: Text(
                                provider.teamModel!.initials,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          else
                            Icon(Icons.group_outlined, color: CustomColor.textMutedLabel(context)),
                          const SizedBox(width: 8),
                          Text(
                            provider.team ?? 'None',
                            style: TextStyle(
                              fontSize: 15,
                              color: provider.team == null
                                  ? CustomColor.textMutedLabel(context)
                                  : CustomColor.textPrimary(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 24, color: CustomColor.dividerColor(context)),
                    _DetailRow(
                      label: 'Due date',
                      onTap: () => _showDatePicker(
                        context: context,
                        currentDate: provider.dueDate,
                        onDateSelected: provider.setDueDate,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            provider.dueDate != null ? Icons.calendar_today : Icons.calendar_today_outlined,
                            color: provider.dueDate != null
                                ? CustomColor.actionBlueText(context)
                                : CustomColor.textMutedLabel(context),
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            provider.dueDate == null ? 'None' : _formatDate(provider.dueDate!),
                            style: TextStyle(
                              fontSize: 15,
                              color: provider.dueDate == null
                                  ? CustomColor.textMutedLabel(context)
                                  : CustomColor.textPrimary(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 24, color: CustomColor.dividerColor(context)),

                    _DetailRow(
                      label: 'Start date',
                      onTap: () => _showDatePicker(
                        context: context,
                        currentDate: provider.startDate,
                        onDateSelected: provider.setStartDate,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            provider.startDate != null ? Icons.calendar_today : Icons.calendar_today_outlined,
                            color: provider.startDate != null
                                ? CustomColor.actionBlueText(context)
                                : CustomColor.textMutedLabel(context),
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            provider.startDate == null ? 'None' : _formatDate(provider.startDate!),
                            style: TextStyle(
                              fontSize: 15,
                              color: provider.startDate == null
                                  ? CustomColor.textMutedLabel(context)
                                  : CustomColor.textPrimary(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 24, color: CustomColor.dividerColor(context)),

                    _DetailRow(
                      label: 'Sprint',
                      onTap: () => SprintBottomSheet.show(
                        context,
                        currentSprint: provider.sprint,
                        onSelected: provider.setSprint,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            provider.sprintModel != null ? Icons.flash_on : Icons.flash_on_outlined,
                            color: provider.sprintModel != null
                                ? const Color(0xFF16A34A)
                                : CustomColor.textMutedLabel(context),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            provider.sprint ?? 'None',
                            style: TextStyle(
                              fontSize: 15,
                              color: provider.sprint == null
                                  ? CustomColor.textMutedLabel(context)
                                  : CustomColor.textPrimary(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 24, color: CustomColor.dividerColor(context)),

                    _DetailRow(
                      label: 'Story point estimate',
                      child: TextField(
                        controller: provider.storyPointsController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 15, color: CustomColor.textPrimary(context)),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          hintText: 'None',
                          hintStyle: TextStyle(
                            fontSize: 15,
                            color: CustomColor.textMutedLabel(context),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            ExpandableSection(
              title: 'More fields',
              isExpanded: _isMoreFieldsExpanded,
              onToggle: () => setState(() => _isMoreFieldsExpanded = !_isMoreFieldsExpanded),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Project',
                      style: TextStyle(
                        fontSize: 13,
                        color: CustomColor.textMutedLabel(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: CustomColor.chipUnselectedBg(context),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: CustomColor.chipUnselectedBorder(context)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE53E3E),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(Icons.settings, color: Colors.white, size: 14),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            provider.project,
                            style: TextStyle(
                              fontSize: 14,
                              color: CustomColor.textPrimary(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Created',
                      style: TextStyle(
                        fontSize: 13,
                        color: CustomColor.textMutedLabel(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDateTime(provider.createdAt),
                      style: TextStyle(
                        fontSize: 16,
                        color: CustomColor.textPrimary(context),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Updated',
                      style: TextStyle(
                        fontSize: 13,
                        color: CustomColor.textMutedLabel(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDateTime(provider.updatedAt),
                      style: TextStyle(
                        fontSize: 16,
                        color: CustomColor.textPrimary(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        'Comments',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: CustomColor.textPrimary(context),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.keyboard_arrow_down,
                          size: 20, color: CustomColor.textMutedLabel(context)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => provider.toggleCommentOrder(),
                  child: Row(
                    children: [
                      Text(
                        provider.commentsNewestFirst ? 'Newest first' : 'Oldest first',
                        style: TextStyle(
                          fontSize: 14,
                          color: CustomColor.textMutedLabel(context),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.keyboard_arrow_down,
                          size: 20, color: CustomColor.textMutedLabel(context)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            CommentSuggestions(provider: provider),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: CustomColor.card_bg(context),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: CustomColor.inputBorderDefault(context)),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _commentController,
                    style: TextStyle(
                      color: CustomColor.textPrimary(context),
                      fontSize: 15,
                    ),
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      hintStyle: TextStyle(
                        color: CustomColor.inputHintDefault(context),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          provider.addComment(_commentController.text);
                          _commentController.clear();
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: CustomColor.actionBlueText(context),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (provider.comments.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 64,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 8,
                              child: Container(
                                width: 52,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2563EB),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(Icons.edit, color: Colors.white, size: 20),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF59E0B),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Leave the first comment',
                        style: TextStyle(
                          fontSize: 15,
                          color: CustomColor.textMutedLabel(context),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              ...provider.comments.map(
                    (c) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: CustomColor.card_bg(context),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: CustomColor.dividerColor(context)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: const Color(0xFF5B21B6),
                          child: const Text(
                            'PJ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            c,
                            style: TextStyle(
                              color: CustomColor.textPrimary(context),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showTransitionSheet(BuildContext context, ScrumProvider provider) {
    final List<Map<String, dynamic>> allStatuses = [
      {'label': 'To Do', 'color': const Color(0xFF6B7280)},
      {'label': 'In Progress', 'color': const Color(0xFF2563EB)},
      {'label': 'In Review', 'color': const Color(0xFF7C3AED)},
      {'label': 'Done', 'color': const Color(0xFF16A34A)},
    ];

    final transitions = allStatuses.where((s) => s['label'] != provider.status).toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.only(bottom: 24),
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
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Text(
                'Select a transition',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: CustomColor.textPrimary(context),
                ),
              ),
            ),
            ...transitions.map(
                  (s) => InkWell(
                onTap: () {
                  provider.updateStatus(s['label'] as String);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: CustomColor.bg_color(context),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Text(
                          s['label'] as String,
                          style: TextStyle(
                            fontSize: 16,
                            color: CustomColor.textPrimary(context),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.arrow_forward, size: 18),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: (s['color'] as Color).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            s['label'] as String,
                            style: TextStyle(
                              color: s['color'] as Color,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
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

  void _showAssigneeSheet(BuildContext context, ScrumProvider provider) {
    final TextEditingController searchController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (ctx, setSheetState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
              left: 20,
              right: 20,
            ),
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
                const SizedBox(height: 20),
                Text(
                  'Assignee',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: CustomColor.bg_color(context),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search users',
                      hintStyle: TextStyle(color: CustomColor.textMutedLabel(context)),
                      prefixIcon: Icon(Icons.search, color: CustomColor.textMutedLabel(context)),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Selected',
                      style: TextStyle(
                        fontSize: 13,
                        color: CustomColor.textMutedLabel(context),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        provider.updateAssignee('Unassigned');
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Clear',
                        style: TextStyle(
                          color: CustomColor.actionBlueText(context),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBEAFE),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: CustomColor.chipUnselectedBg(context),
                      child: Icon(Icons.person_outline,
                          color: CustomColor.textMutedLabel(context)),
                    ),
                    title: Text(
                      provider.assignee?.name ?? 'Unassigned',
                      style: TextStyle(
                        color: CustomColor.textPrimary(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Other items',
                  style: TextStyle(
                    fontSize: 13,
                    color: CustomColor.textMutedLabel(context),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: CustomColor.bg_color(context),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: CustomColor.chipUnselectedBg(context),
                      child: Icon(Icons.person_outline,
                          color: CustomColor.textMutedLabel(context)),
                    ),
                    title: Text(
                      'Automatic',
                      style: TextStyle(color: CustomColor.textPrimary(context)),
                    ),
                    onTap: () {
                      provider.updateAssignee('Automatic');
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showIssueTypeSheet(BuildContext context, ScrumProvider provider) {
    final types = [
      {'label': 'Epic', 'icon': Icons.bolt, 'color': const Color(0xFFB554E0)},
      {'label': 'Story', 'icon': Icons.bookmark_outline, 'color': const Color(0xFF16A34A)},
      {'label': 'Task', 'icon': Icons.check_box_outline_blank, 'color': const Color(0xFF2563EB)},
      {'label': 'Subtask', 'icon': Icons.link, 'color': const Color(0xFF4285F4)},
      {'label': 'Bug', 'icon': Icons.bug_report_outlined, 'color': const Color(0xFFDC2626)},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.only(bottom: 24),
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
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Text(
                'Issue Type',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.textPrimary(context),
                ),
              ),
            ),
            Divider(height: 1, color: CustomColor.dividerColor(context)),
            ...types.map(
                  (t) => ListTile(
                leading: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: (t['color'] as Color).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    t['icon'] as IconData,
                    color: t['color'] as Color,
                    size: 16,
                  ),
                ),
                title: Text(
                  t['label'] as String,
                  style: TextStyle(
                    fontSize: 15,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
                trailing: t['label'] == provider.issueType
                    ? Icon(Icons.check_circle, color: CustomColor.actionBlueText(context))
                    : null,
                onTap: () {
                  provider.updateIssueType(t['label'] as String);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showDatePicker({
    required BuildContext context,
    required DateTime? currentDate,
    required ValueChanged<DateTime?> onDateSelected,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: currentDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) onDateSelected(picked);
  }

  void _showLabelsSheet(BuildContext context, ScrumProvider provider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (ctx, setSheetState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
              left: 20,
              right: 20,
            ),
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
                const SizedBox(height: 20),
                Text(
                  'Labels',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: CustomColor.bg_color(context),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Labels',
                        style: TextStyle(
                          fontSize: 13,
                          color: CustomColor.textMutedLabel(context),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextField(
                        controller: provider.labelsController,
                        style: TextStyle(
                          fontSize: 16,
                          color: CustomColor.textPrimary(context),
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 6),
                          hintText: 'Add labels...',
                          hintStyle: TextStyle(
                            color: CustomColor.textMutedLabel(context).withOpacity(0.6),
                          ),
                          border: InputBorder.none,
                        ),
                        onSubmitted: (_) {
                          provider.addLabelFromController();
                          setSheetState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                if (provider.labels.isNotEmpty) ...[
                  Text(
                    'Added labels',
                    style: TextStyle(
                      fontSize: 13,
                      color: CustomColor.textMutedLabel(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: provider.labels
                        .map((l) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: CustomColor.chipUnselectedBg(context),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: CustomColor.chipUnselectedBorder(context)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            l,
                            style: TextStyle(
                              fontSize: 13,
                              color: CustomColor.textPrimary(context),
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () {
                              provider.removeLabel(l);
                              setSheetState(() {});
                            },
                            child: Icon(
                              Icons.close,
                              size: 14,
                              color: CustomColor.textMutedLabel(context),
                            ),
                          ),
                        ],
                      ),
                    ))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                ],
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      provider.addLabelFromController();
                      setSheetState(() {});
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: CustomColor.actionBlueText(context),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime dt) => '${_monthName(dt.month)} ${dt.day}, ${dt.year}';

  String _formatDateTime(DateTime dt) =>
      '${_monthName(dt.month)} ${dt.day}, ${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

  String _monthName(int m) => const [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ][m];

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    if (parts.isNotEmpty && parts[0].isNotEmpty) return parts[0][0].toUpperCase();
    return '?';
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final bool isRequired;
  final Widget child;
  final VoidCallback? onTap;

  const _DetailRow({
    required this.label,
    required this.child,
    this.isRequired = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: CustomColor.textMutedLabel(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (isRequired)
                const Text(
                  ' *',
                  style: TextStyle(color: Colors.red, fontSize: 13),
                ),
            ],
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}