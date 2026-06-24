import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/home_screen/create(+)/create_screen_provider.dart';
import '../../../resources/bar/custom_bar.dart';
import '../../../resources/bottomsheet/custom_bottomsheet.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/form_field/custom_form_field.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateProvider(),
      child: const _CreateIssueBody(),
    );
  }
}

class _CreateIssueBody extends StatelessWidget {
  const _CreateIssueBody();

  // ── Date Picker Helper ──────────────────────────────────────────
  Future<void> _showDatePicker({
    required BuildContext context,
    required DateTime? currentDate,
    required ValueChanged<DateTime?> onDateSelected,
  }) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: CustomColor.actionBlueText(context),
              onPrimary: Colors.white,
              surface: CustomColor.card_bg(context),
              onSurface: CustomColor.textPrimary(context),
            ),
            dialogBackgroundColor: CustomColor.card_bg(context),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: CustomColor.actionBlueText(context),
              ),
            ),
          ),
          child: Stack(
            children: [
              child!,
              if (currentDate != null)
                Positioned(
                  bottom: 8,
                  left: 16,
                  child: TextButton(
                    onPressed: () {
                      onDateSelected(null);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Remove',
                      style: TextStyle(
                        color: CustomColor.logout_text(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );

    if (picked != null) {
      onDateSelected(picked);
    }
  }

  String _formatDate(DateTime date) =>
      '${date.day}/${date.month}/${date.year}';

  // ───────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CreateProvider>(context);
    final option = provider.selectedWorkTypeOption;

    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      appBar: AppBar(
        backgroundColor: CustomColor.appbar(context),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: CustomColor.arrowback(context)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: provider.canCreate ? () {} : null,
            child: Text(
              'CREATE',
              style: TextStyle(
                color: provider.canCreate
                    ? CustomColor.textPrimary(context)
                    : CustomColor.textMutedLabel(context),
                fontWeight: FontWeight.w600,
                fontSize: 15,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── App + WorkType Row ──
            Container(
              color: CustomColor.card_bg(context),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => AppSelectorBottomSheet.show(context, provider),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        child: Row(
                          children: [
                            Text(
                              provider.selectedApp,
                              style: TextStyle(
                                fontSize: 16,
                                color: CustomColor.textPrimary(context),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: CustomColor.dropdownIcon(context),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(width: 1, height: 40, color: CustomColor.dividerColor(context)),
                  InkWell(
                    onTap: () => WorkTypeBottomSheet.show(
                      context,
                      selectedType: provider.selectedWorkType,
                      options: provider.workTypeOptions,
                      onSelected: provider.setWorkType,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Row(
                        children: [
                          Icon(option.icon, color: option.iconColor, size: 20),
                          const SizedBox(width: 6),
                          Text(
                            option.label,
                            style: TextStyle(
                              fontSize: 16,
                              color: CustomColor.textPrimary(context),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.arrow_drop_down, color: CustomColor.textMutedLabel(context)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Divider(height: 1, color: CustomColor.dividerColor(context)),

            // ── Summary ──
            Container(
              color: CustomColor.card_bg(context),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: TextField(
                onChanged: provider.setSummary,
                style: TextStyle(fontSize: 22, color: CustomColor.textPrimary(context)),
                decoration: InputDecoration(
                  hintText: 'Summary',
                  hintStyle: TextStyle(fontSize: 22, color: CustomColor.inputHintDefault(context)),
                  border: const UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColor.actionBlueText(context)),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColor.inputBorderDefault(context)),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 4),

            // ── Description ──
            Container(
              color: CustomColor.card_bg(context),
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: TextField(
                onChanged: provider.setDescription,
                maxLines: null,
                style: TextStyle(fontSize: 16, color: CustomColor.textPrimary(context)),
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(fontSize: 14, color: CustomColor.textMutedLabel(context)),
                  hintText: 'Add a description...',
                  hintStyle: TextStyle(color: CustomColor.inputHintDefault(context), fontSize: 16),
                  border: const UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColor.actionBlueText(context)),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColor.inputBorderDefault(context)),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 4),

            // ── Attachment Bar ──
            Container(
              color: CustomColor.card_bg(context),
              child: CreateIssueAttachmentBar(
                actions: [
                  AttachmentAction(icon: Icons.camera_alt, label: 'Take photo', onTap: () {}),
                  AttachmentAction(icon: Icons.videocam, label: 'Record vid...', onTap: () {}),
                  AttachmentAction(icon: Icons.attach_file, label: 'Choose file', onTap: () {}),
                  AttachmentAction(icon: Icons.radio_button_checked, label: 'Record scr...', onTap: () {}),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // ── More / Less Toggle ──
            if (!provider.showMore)
              Container(
                color: CustomColor.card_bg(context),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: GestureDetector(
                      onTap: provider.toggleShowMore,
                      child: Text(
                        'More',
                        style: TextStyle(
                          color: CustomColor.actionBlueText(context),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            if (provider.showMore) ...[

              // ── Assignee ──
              Container(
                color: CustomColor.card_bg(context),
                child: CreateIssueFormField(
                  label: 'Assignee',
                  value: provider.assignee?.name,
                  onTap: () => AssigneeBottomSheet.show(
                    context,
                    selectedAssignee: provider.assignee?.name,
                    onSelected: provider.setAssignee,
                  ),
                  trailing: provider.assignee != null
                      ? CircleAvatar(
                    backgroundColor: provider.assignee!.avatarColor,
                    radius: 14,
                    child: Text(
                      provider.assignee!.initials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                      : Icon(Icons.person_outline, color: CustomColor.textMutedLabel(context)),
                ),
              ),

              Divider(height: 1, color: CustomColor.dividerColor(context)),

              // ── Labels ──
              Container(
                color: CustomColor.card_bg(context),
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
                      style: TextStyle(fontSize: 16, color: CustomColor.textPrimary(context)),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 6),
                        hintText: 'Add labels...',
                        hintStyle: TextStyle(
                          color: CustomColor.textMutedLabel(context).withOpacity(0.6),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),

              Divider(height: 1, color: CustomColor.dividerColor(context)),

              // ── Parents ──
              Container(
                color: CustomColor.card_bg(context),
                child: CreateIssueFormField(
                  label: 'Parents',
                  value: provider.parent?.name,
                  onTap: () => ParentBottomSheet.show(
                    context,
                    currentParent: provider.parent?.name,
                    onSelected: provider.setParent,
                  ),
                  trailing: provider.parent != null
                      ? Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: provider.parent!.iconBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      provider.parent!.icon,
                      color: provider.parent!.iconColor,
                      size: 18,
                    ),
                  )
                      : Icon(Icons.account_tree_outlined, color: CustomColor.textMutedLabel(context)),
                ),
              ),

              Divider(height: 1, color: CustomColor.dividerColor(context)),

              // ── Team ──
              Container(
                color: CustomColor.card_bg(context),
                child: CreateIssueFormField(
                  label: 'Team',
                  value: provider.team,
                  onTap: () => TeamBottomSheet.show(
                    context,
                    currentTeam: provider.team,
                    onSelected: provider.setTeam,
                  ),
                  trailing: provider.teamModel != null
                      ? CircleAvatar(
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
                      : Icon(Icons.group_outlined, color: CustomColor.textMutedLabel(context)),
                ),
              ),

              Divider(height: 1, color: CustomColor.dividerColor(context)),

              // ── Due Date ──
              Container(
                color: CustomColor.card_bg(context),
                child: CreateIssueFormField(
                  label: 'Due date',
                  value: provider.dueDate != null ? _formatDate(provider.dueDate!) : null,
                  onTap: () => _showDatePicker(
                    context: context,
                    currentDate: provider.dueDate,
                    onDateSelected: provider.setDueDate,
                  ),
                  trailing: Icon(
                    provider.dueDate != null
                        ? Icons.calendar_today
                        : Icons.calendar_today_outlined,
                    color: provider.dueDate != null
                        ? CustomColor.actionBlueText(context)
                        : CustomColor.textMutedLabel(context),
                    size: 18,
                  ),
                ),
              ),

              Divider(height: 1, color: CustomColor.dividerColor(context)),

              // ── Start Date ──
              Container(
                color: CustomColor.card_bg(context),
                child: CreateIssueFormField(
                  label: 'Start date',
                  value: provider.startDate != null ? _formatDate(provider.startDate!) : null,
                  onTap: () => _showDatePicker(
                    context: context,
                    currentDate: provider.startDate,
                    onDateSelected: provider.setStartDate,
                  ),
                  trailing: Icon(
                    provider.startDate != null
                        ? Icons.calendar_today
                        : Icons.calendar_today_outlined,
                    color: provider.startDate != null
                        ? CustomColor.actionBlueText(context)
                        : CustomColor.textMutedLabel(context),
                    size: 18,
                  ),
                ),
              ),

              Divider(height: 1, color: CustomColor.dividerColor(context)),

              // ── Sprint ──

              Container(
                color: CustomColor.card_bg(context),
                child: CreateIssueFormField(
                  label: 'Sprint',
                  value: provider.sprint,
                  onTap: () => SprintBottomSheet.show(
                    context,
                    currentSprint: provider.sprint,
                    onSelected: provider.setSprint,
                  ),
                  trailing: Icon(
                    provider.sprintModel != null
                        ? Icons.flash_on
                        : Icons.flash_on_outlined,
                    color: provider.sprintModel != null
                        ? const Color(0xFF16A34A)
                        : CustomColor.textMutedLabel(context),
                    size: 20,
                  ),
                ),
              ),
              Divider(height: 1, color: CustomColor.dividerColor(context)),

              // ── Story Point Estimate ──
              Container(
                color: CustomColor.card_bg(context),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Story Point Estimate',
                      style: TextStyle(
                        fontSize: 13,
                        color: CustomColor.textMutedLabel(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextField(
                      controller: provider.labelsController,
                      style: TextStyle(fontSize: 16, color: CustomColor.textPrimary(context)),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 6),
                        hintText: 'Add Story point estimate...',
                        hintStyle: TextStyle(
                          color: CustomColor.textMutedLabel(context).withOpacity(0.6),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: CustomColor.dividerColor(context)),

              // ── Reporter ──
              Container(
                color: CustomColor.card_bg(context),
                child: CreateIssueFormField(
                  label: 'Report',
                  value: provider.report?.name,
                  onTap: () => ReportBottomSheet.show(
                    context,
                    selectedReports: provider.report?.name,
                    onSelected: provider.setReport,
                  ),
                  trailing: provider.report != null
                      ? CircleAvatar(
                    backgroundColor: provider.report!.avatarColor,
                    radius: 14,
                    child: Text(
                      provider.report!.initials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                      : Icon(Icons.person_outline, color: CustomColor.textMutedLabel(context)),
                ),
              ),

              Divider(height: 1, color: CustomColor.dividerColor(context)),

              // ── Flagged ──
              Container(
                color: CustomColor.card_bg(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Flagged',
                        style: TextStyle(
                          fontSize: 14,
                          color: CustomColor.textMutedLabel(context),
                        ),
                      ),
                      Switch(
                        value: provider.flagged,
                        onChanged: (_) => provider.toggleFlagged(),
                        activeColor: CustomColor.switchActiveTrack(context),
                      ),
                    ],
                  ),
                ),
              ),

              Divider(height: 1, color: CustomColor.dividerColor(context)),

              // ── Issue Color ──
              Container(
                color: CustomColor.card_bg(context),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Issue Color',
                      style: TextStyle(
                        fontSize: 13,
                        color: CustomColor.textMutedLabel(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextField(
                      controller: provider.labelsController,
                      style: TextStyle(fontSize: 16, color: CustomColor.textPrimary(context)),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 6),
                        hintText: 'Add issue color...',
                        hintStyle: TextStyle(
                          color: CustomColor.textMutedLabel(context).withOpacity(0.6),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),

              Divider(height: 1, color: CustomColor.dividerColor(context)),

              // ── Less ──
              Container(
                color: CustomColor.card_bg(context),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: GestureDetector(
                      onTap: provider.toggleShowMore,
                      child: Text(
                        'Less',
                        style: TextStyle(
                          color: CustomColor.actionBlueText(context),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}