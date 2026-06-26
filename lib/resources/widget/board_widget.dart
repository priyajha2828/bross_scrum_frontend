import 'package:flutter/material.dart';
import 'package:BrossScrum/resources/color/custom_color.dart';
import '../../providers/home_screen/app/board/board_provider.dart';

class BoardColumnCard extends StatelessWidget {
  final BoardColumn column;
  final VoidCallback? onMenuTap;
  final VoidCallback? onDeleteTap;

  const BoardColumnCard({
    super.key,
    required this.column,
    this.onMenuTap,
    this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = column.tasks.isEmpty;

    return Container(
      width: MediaQuery.of(context).size.width - 32,
      margin: const EdgeInsets.only(right: 12),
      constraints: const BoxConstraints(
        maxHeight: 450,
      ),
      decoration: BoxDecoration(
        color: CustomColor.board(context),

        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Text(
                  '${column.title}  ${column.taskCount}',
                  style: TextStyle(
                    color: CustomColor.textMutedLabel(context),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'delete' && onDeleteTap != null) {
                      onDeleteTap!();
                    } else if (value == 'menu' && onMenuTap != null) {
                      onMenuTap!();
                    }
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: CustomColor.textMutedLabel(context),
                    size: 20,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem<String>(
                      value: 'menu',
                      child: Text('Options'),
                    ),
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline, color: Colors.red[400], size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Delete column',
                            style: TextStyle(color: Colors.red[400]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Flexible(
            child: _buildColumnContent(isEmpty),
          ),
        ],
      ),
    );
  }

  Widget _buildColumnContent(bool isEmpty) {
    if (isEmpty && column.id == 'todo') {
      return const SingleChildScrollView(
        child: _EmptyBoardState(),
      );
    } else if (isEmpty) {
      return const SizedBox(height: 450);
    } else {
      return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        itemCount: column.tasks.length,
        itemBuilder: (_, i) => _TaskCard(task: column.tasks[i]),
      );
    }
  }
}

class _EmptyBoardState extends StatelessWidget {
  const _EmptyBoardState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 450,
        ),
        child: Column(
          children: [
            const _KanbanBoardIllustration(),
            const SizedBox(height: 24),
            Text(
              'No work yet!',
              style: TextStyle(
                color: CustomColor.textPrimary(context),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Your team's work will appear here when you start a sprint from the backlog.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: CustomColor.textMutedLabel(context),
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.list_alt_rounded,
                    color: CustomColor.actionBlueText(context), size: 20),
                const SizedBox(width: 8),
                Text(
                  'View backlog',
                  style: TextStyle(
                    color: CustomColor.actionBlueText(context),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _KanbanBoardIllustration extends StatelessWidget {
  const _KanbanBoardIllustration();

  @override
  Widget build(BuildContext context) {
    final bool isDark = CustomColor.isDark(context);
    final baseColor = isDark ? const Color(0xFF374151) : const Color(0xFFD1D5DB);
    final accentBlue = const Color(0xFF3B82F6).withOpacity(0.85);

    return SizedBox(
      width: 140,
      height: 110,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 62,
              height: 100,
              decoration: BoxDecoration(
                color: baseColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: baseColor.withValues(alpha: 0.4), width: 1.5),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 62,
              height: 100,
              decoration: BoxDecoration(
                color: baseColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: baseColor.withValues(alpha: 0.4), width: 1.5),
              ),
            ),
          ),
          Positioned(
            left: 8,
            top: 12,
            child: Container(
              width: 46,
              height: 24,
              decoration: BoxDecoration(
                color: baseColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Positioned(
            left: 8,
            top: 44,
            child: Container(
              width: 46,
              height: 32,
              decoration: BoxDecoration(
                color: accentBlue,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: const Icon(Icons.check, size: 14, color: Colors.white),
            ),
          ),
          Positioned(
            right: 8,
            top: 20,
            child: Container(
              width: 46,
              height: 28,
              decoration: BoxDecoration(
                color: baseColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final BoardTask task;
  const _TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: CustomColor.card_bg(context),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: TextStyle(
              color: CustomColor.textPrimary(context),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (task.subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              task.subtitle!,
              style: TextStyle(
                color: CustomColor.textMutedLabel(context),
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class AddColumnButton extends StatelessWidget {
  final VoidCallback onTap;
  const AddColumnButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(vertical: 16),
        constraints: BoxConstraints(
          maxHeight: 450,

        ),
        decoration: BoxDecoration(
          color: CustomColor.card_bg(context),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: CustomColor.dividerColor(context),
          ),
        ),
        child: Center(
          child: Text(
            'Add column',
            style: TextStyle(
              color: CustomColor.actionBlueText(context),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}