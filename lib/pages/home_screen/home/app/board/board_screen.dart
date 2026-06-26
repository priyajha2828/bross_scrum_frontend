import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/home_screen/app/board/board_provider.dart';
import '../../../../../resources/card/custom_card.dart';
import '../../../../../resources/color/custom_color.dart';
import '../../../../../resources/widget/board_widget.dart';

class BoardPageScreen extends StatefulWidget {
  const BoardPageScreen({super.key});

  @override
  State<BoardPageScreen> createState() => _BoardPageScreenState();
}

class _BoardPageScreenState extends State<BoardPageScreen> {
  @override
  void initState(){
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_){
    context.read<BoardProvider>().refresh();
  });
  }

  void _showAddColumnDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: CustomColor.card_bg(context),
        title: Text(
          'New column',
          style: TextStyle(color: CustomColor.textPrimary(context)),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: TextStyle(color: CustomColor.textPrimary(context)),
          decoration: InputDecoration(
            hintText: 'Column name',
            hintStyle:
            TextStyle(color: CustomColor.textMutedLabel(context)),
            enabledBorder: UnderlineInputBorder(
              borderSide:
              BorderSide(color: CustomColor.dividerColor(context)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF2563EB)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel',
                style:
                TextStyle(color: CustomColor.textMutedLabel(context))),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                context
                    .read<BoardProvider>()
                    .addColumn(controller.text.trim());
                Navigator.pop(context);
              }
            },
            child: const Text('Add',
                style: TextStyle(color: Color(0xFF2563EB))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BoardProvider>();
    if(provider.isLoading){
      return const Center(child: CircularProgressIndicator());
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      ...provider.columns.map(
      (col) => BoardColumnCard(
      column: col,
      onMenuTap: () {

      },
    ),
      ),
          AddColumnButton(onTap: _showAddColumnDialog),
        ],
      ),
    );
  }
}
