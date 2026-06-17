import 'package:BrossScrum/resources/painter/custom_painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/home_screen/my_open_issue/my_open_issue.dart';
import '../../../../resources/color/custom_color.dart';
import '../../../../routes/app_route.dart';


class MyOpenIssue extends StatelessWidget {
  const MyOpenIssue({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyOpenIssueProvider(),
      child: const _MyOpenIssueBody(),
    );
  }
}

class _MyOpenIssueBody extends StatelessWidget {
  const _MyOpenIssueBody();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyOpenIssueProvider>(context);

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
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: CustomColor.textMutedLabel(context),
            ),
            onSelected: (value) {
              if (value == 'toggle_star') {
                provider.toggleStarFilter();
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'toggle_star',
                child: Text(
                  provider.isStarred ? 'Unstar Filter' : 'Star Filter',
                  style: TextStyle(
                    color: CustomColor.textPrimary(context),
                  ),
                ),
              ),
            ],
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
              "when you're assigned new works items, they'll appear here",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: CustomColor.textMutedLabel(context),
              ),
            ),
            const SizedBox(height: 10),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.create);
              },
              icon: Icon(Icons.add, size: 30, color: CustomColor.actionBlueText(context)),
            ),
          ],
        ),
      ),
    );
  }
}