// import 'package:flutter/material.dart';
//
// class IssueDetailsProvider extends ChangeNotifier {
//   // Issue Identification
//   final String issueKey;
//   final String initialTitle;
//
//   // Dynamic fields
//   String _title;
//   String _status = 'To Do';
//   String _description = '';
//   String _issueType = 'Epic';
//   String _assignee = 'Unassigned';
//   String _project = 'app1';
//   List<String> _labels = [];
//   List<String> _comments = [];
//
//   IssueDetailsProvider({
//     required this.issueKey,
//     required this.initialTitle,
//   }) : _title = initialTitle;
//
//   // Getters
//   String get title => _title;
//   String get status => _status;
//   String get description => _description;
//   String get issueType => _issueType;
//   String get assignee => _assignee;
//   String get project => _project;
//   List<String> get labels => _labels;
//   List<String> get comments => _comments;
//
//   // Setters/Actions
//   void updateStatus(String newStatus) {
//     _status = newStatus;
//     notifyListeners();
//   }
//
//   void updateDescription(String text) {
//     _description = text;
//     notifyListeners();
//   }
//
//   void addComment(String comment) {
//     if (comment.trim().isNotEmpty) {
//       _comments.add(comment.trim());
//       notifyListeners();
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../resources/color/custom_color.dart'; // Adjust path based on your project
// import 'issue_details_provider.dart';
//
// class IssueDetailsScreen extends StatelessWidget {
//   final String issueKey;
//   final String title;
//
//   const IssueDetailsScreen({
//     super.key,
//     required this.issueKey,
//     required this.title,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => IssueDetailsProvider(issueKey: issueKey, initialTitle: title),
//       child: const _IssueDetailsView(),
//     );
//   }
// }
//
// class _IssueDetailsView extends StatelessWidget {
//   const _IssueDetailsView();
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<IssueDetailsProvider>(context);
//
//     return Scaffold(
//       backgroundColor: CustomColor.bg_color(context),
//       appBar: AppBar(
//         backgroundColor: CustomColor.bg_color(context),
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: CustomColor.textPrimary(context)),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.visibility_outlined, color: CustomColor.textPrimary(context)),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.attach_file, color: CustomColor.textPrimary(context)),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.more_vert, color: CustomColor.textPrimary(context)),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Main Scrollable Content
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Issue Key Badge (e.g., SCRUM-10)
//                   Row(
//                     children: [
//                       Icon(Icons.bolt, color: const Color(0xFFB554E0), size: 18),
//                       const SizedBox(width: 6),
//                       Text(
//                         provider.issueKey,
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: CustomColor.textMutedLabel(context),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//
//                   // Issue Title
//                   Text(
//                     provider.title,
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.w500,
//                       color: CustomColor.textPrimary(context),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//
//                   // Status Dropdown Button ("To Do")
//                   _buildStatusDropdown(context, provider),
//                   const SizedBox(height: 16),
//
//                   // General Info Expansion Card
//                   _buildExpansionCard(
//                     context,
//                     title: 'General',
//                     initiallyExpanded: true,
//                     children: [
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           provider.description.isEmpty ? 'Description' : provider.description,
//                           style: TextStyle(
//                             color: CustomColor.textMutedLabel(context),
//                             fontSize: 14,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//
//                   // Parent Work Item Expansion Card
//                   _buildExpansionCard(
//                     context,
//                     title: 'Parent work item',
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         child: Text('No parent item linked', style: TextStyle(color: CustomColor.textMutedLabel(context))),
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//
//                   // Details Expansion Card
//                   _buildExpansionCard(
//                     context,
//                     title: 'Details',
//                     initiallyExpanded: true,
//                     children: [
//                       _buildDetailRow(context, 'Issue Type *', provider.issueType, trailingIcon: Icons.bolt, iconColor: const Color(0xFFB554E0)),
//                       _buildDetailRow(context, 'Assignee', provider.assignee),
//                       _buildDetailRow(context, 'Labels', provider.labels.isEmpty ? 'None' : provider.labels.join(', ')),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//
//                   // More Fields Expansion Card
//                   _buildExpansionCard(
//                     context,
//                     title: 'More fields',
//                     initiallyExpanded: true,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             flex: 2,
//                             child: Text('Project', style: TextStyle(color: CustomColor.textMutedLabel(context), fontSize: 14)),
//                           ),
//                           Expanded(
//                             flex: 3,
//                             child: Align(
//                               alignment: Alignment.centerLeft,
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade100,
//                                   borderRadius: BorderRadius.circular(6),
//                                   border: Border.all(color: Colors.grey.shade300),
//                                 ),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     const CircleAvatar(radius: 6, backgroundColor: Colors.cyan),
//                                     const SizedBox(width: 6),
//                                     Text(provider.project, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                 ],
//               ),
//             ),
//           ),
//
//           // Bottom Fixed Section (Suggestions Chips + Comments input)
//           _buildBottomCommentBar(context, provider),
//         ],
//       ),
//     );
//   }
//
//   // Helper Custom Expansion Card Builder
//   Widget _buildExpansionCard(BuildContext context, {required String title, required List<Widget> children, bool initiallyExpanded = false}) {
//     return Container(
//       decoration: BoxDecoration(
//         color: CustomColor.card_bg(context),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Theme(
//         data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//         child: ExpansionTile(
//           initiallyExpanded: initiallyExpanded,
//           title: Text(
//             title,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: CustomColor.textPrimary(context)),
//           ),
//           childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//           children: children,
//         ),
//       ),
//     );
//   }
//
//   // Detail item field inside expansion sections
//   Widget _buildDetailRow(BuildContext context, String label, String value, {IconData? trailingIcon, Color? iconColor}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(label, style: TextStyle(color: CustomColor.textMutedLabel(context), fontSize: 14)),
//           ),
//           Expanded(
//             flex: 3,
//             child: Row(
//               children: [
//                 if (trailingIcon != null) ...[
//                   Icon(trailingIcon, color: iconColor, size: 16),
//                   const SizedBox(width: 6),
//                 ],
//                 Text(value, style: TextStyle(color: CustomColor.textPrimary(context), fontSize: 14, fontWeight: FontWeight.w400)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Status selection drop button widget style
//   Widget _buildStatusDropdown(BuildContext context, IssueDetailsProvider provider) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade200,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             provider.status,
//             style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 14),
//           ),
//           const SizedBox(width: 4),
//           const Icon(Icons.arrow_drop_down, color: Colors.black54, size: 20),
//         ],
//       ),
//     );
//   }
//
//   // Interactive Bottom Comments Interface Layer
//   Widget _buildBottomCommentBar(BuildContext context, IssueDetailsProvider provider) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       decoration: BoxDecoration(
//         color: CustomColor.card_bg(context),
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, -2))],
//       ),
//       child: SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Horizontal suggestion chips row
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 children: [
//                   _buildSuggestionChip('Who is working on this...?'),
//                   const SizedBox(width: 8),
//                   _buildSuggestionChip('Can I get more info?'),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 12),
//
//             // Standardizing comment field
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade50,
//                   borderRadius: BorderRadius.circular(24),
//                   border: Border.all(color: Colors.grey.shade300),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Add a comment...',
//                         style: TextStyle(color: CustomColor.textMutedLabel(context), fontSize: 14),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSuggestionChip(String label) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF1F5F9),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Text(
//         label,
//         style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/home_screen/dashboard/scrum/scrum_provider.dart';
import '../../../../resources/color/custom_color.dart';

class ScrumScreen extends StatefulWidget {
  const ScrumScreen({super.key});

  @override
  State<ScrumScreen> createState() => _ScrumScreenState();
}

class _ScrumScreenState extends State<ScrumScreen> {
  final TextEditingController _commentController = TextEditingController();
  bool _isGeneralExpanded = true;
  bool _isParentExpanded = true;
  bool _isDetailsExpanded = true;

  @override
  void dispose() {
    _commentController.dispose();
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
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: CustomColor.arrowback(context)),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.visibility_outlined, color: CustomColor.textPrimary(context)),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.attach_file, color: CustomColor.textPrimary(context)),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: CustomColor.textPrimary(context)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 8),

            // ── Issue Key ──
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: CustomColor.isDark(context)
                        ? const Color(0xFF3D2A50)
                        : const Color(0xFFF3E8FF),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.bolt,
                    color: const Color(0xFFB554E0),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  provider.issueKey.isNotEmpty ? provider.issueKey : 'SCRUM-7',
                  style: TextStyle(
                    fontSize: 14,
                    color: CustomColor.textMutedLabel(context),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ── Title + Assignee Avatar ──
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    provider.title.isNotEmpty ? provider.title : provider.initialTitle,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                      color: CustomColor.textPrimary(context),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: CustomColor.chipUnselectedBg(context),
                  child: Icon(
                    Icons.person_outline,
                    color: CustomColor.textMutedLabel(context),
                    size: 24,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ── Status Dropdown ──
            GestureDetector(
              onTap: () => _showStatusSheet(context, provider),
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

            // ── General Section ──
            _ExpandableSection(
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
                      provider.description.isEmpty
                          ? 'No description provided.'
                          : provider.description,
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

            // ── Parent Work Item Section ──
            _ExpandableSection(
              title: 'Parent work item',
              isExpanded: _isParentExpanded,
              onToggle: () => setState(() => _isParentExpanded = !_isParentExpanded),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Text(
                  'No parent work item.',
                  style: TextStyle(
                    fontSize: 15,
                    color: CustomColor.textMutedLabel(context),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ── Details Section ──
            _ExpandableSection(
              title: 'Details',
              isExpanded: _isDetailsExpanded,
              onToggle: () => setState(() => _isDetailsExpanded = !_isDetailsExpanded),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Issue Type
                    _DetailRow(
                      label: 'Issue Type',
                      isRequired: true,
                      child: Row(
                        children: [
                          Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              color: CustomColor.isDark(context)
                                  ? const Color(0xFF3D2A50)
                                  : const Color(0xFFF3E8FF),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.bolt,
                              color: Color(0xFFB554E0),
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

                    // Assignee
                    _DetailRow(
                      label: 'Assignee',
                      child: Text(
                        provider.assignee,
                        style: TextStyle(
                          fontSize: 15,
                          color: provider.assignee == 'Unassigned'
                              ? CustomColor.textMutedLabel(context)
                              : CustomColor.textPrimary(context),
                        ),
                      ),
                    ),

                    Divider(height: 24, color: CustomColor.dividerColor(context)),

                    // Labels
                    _DetailRow(
                      label: 'Labels',
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: CustomColor.chipUnselectedBg(context),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: CustomColor.chipUnselectedBorder(context)),
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
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ── Comment Suggestion Chips ──
            _CommentSuggestions(provider: provider),

            const SizedBox(height: 12),

            // ── Comment Input ──
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

            // ── Existing Comments ──
            if (provider.comments.isNotEmpty) ...[
              const SizedBox(height: 16),
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
            ],

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showStatusSheet(BuildContext context, ScrumProvider provider) {
    final List<Map<String, dynamic>> statuses = [
      {'label': 'To Do', 'color': const Color(0xFF6B7280)},
      {'label': 'In Progress', 'color': const Color(0xFF2563EB)},
      {'label': 'In Review', 'color': const Color(0xFF7C3AED)},
      {'label': 'Done', 'color': const Color(0xFF16A34A)},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
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
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Text(
                'Status',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.textPrimary(context),
                ),
              ),
            ),
            Divider(height: 1, color: CustomColor.dividerColor(context)),
            ...statuses.map(
                  (s) => ListTile(
                leading: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: (s['color'] as Color).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    s['label'] as String,
                    style: TextStyle(
                      color: s['color'] as Color,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                trailing: s['label'] == provider.status
                    ? Icon(
                  Icons.check_circle,
                  color: CustomColor.actionBlueText(context),
                )
                    : null,
                onTap: () {
                  provider.updateStatus(s['label'] as String);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Detail Row ────────────────────────────────────────────────────────────────
class _DetailRow extends StatelessWidget {
  final String label;
  final bool isRequired;
  final Widget child;

  const _DetailRow({
    required this.label,
    required this.child,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

// ── Expandable Section ────────────────────────────────────────────────────────
class _ExpandableSection extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Widget child;

  const _ExpandableSection({
    required this.title,
    required this.isExpanded,
    required this.onToggle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.card_bg(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CustomColor.dividerColor(context)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: isExpanded
                ? const BorderRadius.vertical(top: Radius.circular(16))
                : BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.textPrimary(context),
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: CustomColor.textMutedLabel(context),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            Divider(height: 1, color: CustomColor.dividerColor(context)),
            child,
          ],
        ],
      ),
    );
  }
}

// ── Comment Suggestion Chips ──────────────────────────────────────────────────
class _CommentSuggestions extends StatelessWidget {
  final ScrumProvider provider;
  const _CommentSuggestions({required this.provider});

  @override
  Widget build(BuildContext context) {
    final suggestions = [
      'Who is working on this...?',
      'Can I get more info?',
      'What is the priority?',
    ];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: suggestions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => provider.addComment(suggestions[index]),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: CustomColor.card_bg(context),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: CustomColor.chipUnselectedBorder(context),
                ),
              ),
              child: Text(
                suggestions[index],
                style: TextStyle(
                  fontSize: 13,
                  color: CustomColor.textPrimary(context),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
