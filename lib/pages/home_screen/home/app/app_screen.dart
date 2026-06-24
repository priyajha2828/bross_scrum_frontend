import 'package:BrossScrum/resources/color/custom_color.dart';
import 'package:flutter/material.dart';

import '../../../../routes/app_route.dart';

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
                color: CustomColor.textPrimary(context),
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 6),
            IconButton(onPressed: (){}, icon: Icon(
              Icons.arrow_drop_down,
              color: CustomColor.textMutedLabel(context),
              size: 20,
            ),
            )

          ],
        ),

        actions: [
          IconButton(
              onPressed: (){},
              icon:Icon(
                Icons.share,

              ) )
        ],
      ),

    );
  }
}
