
import 'package:BrossScrum/pages/home_screen/home/app/board/board_screen.dart';
import 'package:BrossScrum/pages/home_screen/home/app/summary/summary_page_screen.dart';
import 'package:BrossScrum/resources/color/custom_color.dart';
import 'package:flutter/material.dart';

import '../../../../../resources/bottomsheet/custom_bottomsheet.dart';
import '../../../../../routes/app_route.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      appBar: AppBar(
        backgroundColor: CustomColor.bg_color(context),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoute.bottonnavibar);
          },
          icon: Icon(Icons.arrow_back, color: CustomColor.arrowback(context)),
        ),
        title: Row(
          children: [
            Text(
              "app",
              style: TextStyle(
                color: CustomColor.textMutedLabel(context),
                fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
            ),
            IconButton(onPressed: () => ShowBoardPickerBottomSheet(context,spaceName:'app1',)
              , icon: Icon(
              Icons.arrow_drop_down,
              color: CustomColor.textMutedLabel(context),
              size: 25,
            ),
            )

          ],
        ),

        actions: [
          IconButton(
              onPressed: (){},
              icon:Icon(
                Icons.share,
                color: CustomColor.textMutedLabel(context),

              ) )
        ],
      ),

      body: DefaultTabController(
          length: 5,
          child: Column(
          children: [
            TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: "Summary"),
                Tab(text: "board"),
                Tab(text: "calender"),
                Tab(text: "backlog"),
                Tab(text: "Setting"),

              ],

            ),
            Expanded(
                child: TabBarView(children: [
                  SummaryPageScreen(),
                  BoardPageScreen(),
                  Center(child: Text("Calender")),
                  Center(child: Text("backlog")),
                  Center(child: Text("Setting"),),

                ])
            )
          ],
          )
      ),

    );
  }
}
