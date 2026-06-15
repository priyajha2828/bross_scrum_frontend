import 'package:BrossScrum/resources/painter/custom_painter.dart';
import 'package:flutter/material.dart';

import '../../../resources/color/custom_color.dart';

class MyOpenIssue extends StatefulWidget {
  const MyOpenIssue({super.key});

  @override
  State<MyOpenIssue> createState() => _MyOpenIssueState();
}

class _MyOpenIssueState extends State<MyOpenIssue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      appBar: AppBar(
        backgroundColor: CustomColor.appbar(context),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: CustomColor.arrowback(context)),
        ),
        title: Text(
          "My Open Issue",
          style: TextStyle(
            color: CustomColor.textPrimary(context),
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: CustomColor.textMutedLabel(context),
            ),
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: CustomPaint(
                painter: PartyPainter(),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "No Work Assigned",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: CustomColor.textPrimary(context),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.center,
              "when you're assigned new works items, they'll appear here",
              style: TextStyle(
                fontSize: 16,
                color: CustomColor.textMutedLabel(context),
              ),
            ),
            const SizedBox(height: 10),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add, size: 30,color: CustomColor.actionBlueText(context)),
            ),
          ],
        ),
      ),
    );
  }
}
