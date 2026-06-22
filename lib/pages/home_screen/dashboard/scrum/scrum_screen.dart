import 'package:BrossScrum/resources/color/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/home_screen/dashboard/scrum/scrum_provider.dart';

class ScrumScreen extends StatelessWidget {
  const ScrumScreen({super.key});

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
          IconButton(onPressed: (){},
              icon: Icon(
                Icons.more_vert,
                color: CustomColor.textPrimary(context),
              )
          ),

        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                    decoration: BoxDecoration(
                      color:CustomColor.box_decoration(context),
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
                  provider.issueKey.isNotEmpty? provider.issueKey : 'SCRUM-7',
                  style: TextStyle(
                    fontSize: 14,
                    color: CustomColor.textMutedLabel(context),
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),

            const SizedBox(height: 12),

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

          ],
        ),
      ),
    );
  }
}
