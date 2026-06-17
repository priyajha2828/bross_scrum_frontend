import 'package:flutter/material.dart';

// =========================================================================
// AttachmentAction मोडल र CreateIssueAttachmentBar विजेट
// =========================================================================
class AttachmentAction {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const AttachmentAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

class CreateIssueAttachmentBar extends StatelessWidget {
  final List<AttachmentAction> actions;

  const CreateIssueAttachmentBar({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: actions
            .map((action) => _AttachmentButton(action: action))
            .toList(),
      ),
    );
  }
}

class _AttachmentButton extends StatelessWidget {
  final AttachmentAction action;

  const _AttachmentButton({required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action.onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(action.icon, color: const Color(0xFF2563EB), size: 26),
            const SizedBox(height: 4),
            Text(
              action.label,
              style: const TextStyle(
                color: Color(0xFF2563EB),
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}