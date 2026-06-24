import 'package:flutter/material.dart';

import '../../../../resources/bottomsheet/custom_bottomsheet.dart';
import '../../../../resources/color/custom_color.dart';
import '../../../../resources/model/custom_model.dart';

class CreateSpaceScreen extends StatefulWidget {
  const CreateSpaceScreen({super.key});

  @override
  State<CreateSpaceScreen> createState() => _CreateSpaceScreenState();
}

class _CreateSpaceScreenState extends State<CreateSpaceScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();

  // Available sample templates
  final List<SpaceTemplateModel> _templates = const [
    SpaceTemplateModel(
      id: 'kanban',
      title: 'Kanban',
      description: 'Visualize and advance your project forward using work items on a powerful board.',
      icon: Icons.dashboard_customize_outlined,
      iconColor: Colors.blue,
    ),
    SpaceTemplateModel(
      id: 'scrum',
      title: 'Scrum',
      description: 'Sprint toward your project goals with a board, backlog, and timeline.',
      icon: Icons.loop,
      iconColor: Colors.blueAccent,
    ),
    SpaceTemplateModel(
      id: 'blank',
      title: 'Blank space',
      description: 'Start with a blank canvas.',
      icon: Icons.note_add_outlined,
      iconColor: Colors.grey,
    ),
    SpaceTemplateModel(
      id: 'project_management',
      title: 'Project management',
      description: 'Plan and deliver business projects.',
      icon: Icons.map_outlined,
      iconColor: Colors.orange,
    ),
    SpaceTemplateModel(
      id: 'task_tracking',
      title: 'Task tracking',
      description: 'Organize and track team or personal tasks.',
      icon: Icons.assignment_outlined,
      iconColor: Colors.blue,
    ),
  ];

  late SpaceTemplateModel _selectedTemplate;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _selectedTemplate = _templates.first; // Default configuration sets to Kanban
    _nameController.addListener(_validateForm);
    _keyController.addListener(_validateForm);
  }

  void _validateForm() {
    final isValid = _nameController.text.trim().isNotEmpty &&
        _keyController.text.trim().isNotEmpty;
    if (isValid != _isButtonEnabled) {
      setState(() => _isButtonEnabled = isValid);
    }
  }

  void _openTemplateSelection() {
    TemplateBottomSheet.show(
      context,
      templates: _templates,
      selectedTemplateId: _selectedTemplate.id,
      onSelected: (template) {
        setState(() => _selectedTemplate = template);
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _keyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = CustomColor.isDark(context);

    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      body: Column(
        children: [
          // Graphic Map Banner Area
          Stack(
            children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4FA8FA), Color(0xFF1E70EB)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SafeArea(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white, size: 26),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ),
              ),
              // Vector landscape illustration layout element matching screen capture
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 120,
                  alignment: Alignment.bottomCenter,
                  child: Opacity(
                    opacity: 0.25,
                    child: Icon(
                      Icons.map_rounded,
                      size: 160,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ),
              )
            ],
          ),

          // Main Interactive Settings Fields Content Form
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Space Name Floating Border Input Layout
                  TextField(
                    controller: _nameController,
                    style: TextStyle(color: CustomColor.textPrimary(context), fontSize: 16),
                    decoration: InputDecoration(
                      labelText: 'Space name',
                      labelStyle: TextStyle(
                        color: CustomColor.actionBlueText(context),
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: CustomColor.actionBlueText(context), width: 2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: CustomColor.actionBlueText(context), width: 2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Template Dropdown Selection Box Layout Row
                  GestureDetector(
                    onTap: _openTemplateSelection,
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Space template',
                          style: TextStyle(
                            color: CustomColor.textMutedLabel(context),
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedTemplate.title,
                              style: TextStyle(
                                fontSize: 16,
                                color: CustomColor.textPrimary(context),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: CustomColor.textMutedLabel(context),
                              size: 24,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: isDark ? const Color(0xFF4B5563) : Colors.black38,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Space Key Standard Underline Input Layout
                  TextField(
                    controller: _keyController,
                    style: TextStyle(color: CustomColor.textPrimary(context), fontSize: 16),
                    decoration: InputDecoration(
                      labelText: 'Space key',
                      labelStyle: TextStyle(color: CustomColor.textMutedLabel(context)),
                      border: const UnderlineInputBorder(),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomColor.dividerColor(context),
                          width: 1,
                        ),
                      ),
                      focusedBorder: BorderSide.none == true
                          ? null
                          : UnderlineInputBorder(
                        borderSide: BorderSide(color: CustomColor.actionBlueText(context), width: 2),
                      ),
                      contentPadding: const EdgeInsets.only(bottom: 6),
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Action Confirmation Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isButtonEnabled ? () {} : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColor.actionBlueText(context),
                        disabledBackgroundColor: isDark
                            ? const Color(0xFF374151)
                            : const Color(0xFFE5E7EB),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                      child: Text(
                        'CREATE SPACE',
                        style: TextStyle(
                          color: _isButtonEnabled
                              ? Colors.white
                              : (isDark ? Colors.grey.shade600 : Colors.grey.shade400),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}