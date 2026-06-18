import 'package:BrossScrum/providers/home_screen/all_work/all_work_provider.dart';
import 'package:BrossScrum/resources/color/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../resources/bottom/custom_bottom.dart';
import '../../../../resources/painter/custom_painter.dart';
import '../../../../routes/app_route.dart';

class AllWorkScreen extends StatelessWidget {
  const AllWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AllWorkProvider>(context);

    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      appBar: AppBar(
        backgroundColor: CustomColor.appbar(context),
        elevation: 0,
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.cyan[700],
            child: TextButton(
                onPressed:(){
                  Navigator.pushNamed(context, AppRoute.accountscreen);
                },
                child: Text(
                  "PJ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
            )
          ),
        ),
        title: Text(
          "All Work",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: CustomColor.textPrimary(context),
          ),
        ),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushNamed(context, AppRoute.searchworkscreen);
              },
              icon: Icon(
                Icons.search,
                color:CustomColor.textPrimary(context),
              )
          ),
          IconButton(
              onPressed: (){
                Navigator.pushNamed(context, AppRoute.create);
              }, icon: Icon(
            Icons.add,
            color: CustomColor.textPrimary(context),
          )
          )
        ],
      ),
     body: Column(
       children: [
         Padding(
             padding: const EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 12),
           child: Row(
             children: [
               Expanded(child: GestureDetector(
                 onTap: (){
                   Navigator.pushNamed(context, AppRoute.filterscreen);
                 },
                 child: Container(
                   padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                   decoration: BoxDecoration(
                     color: CustomColor.card_bg(context),
                     borderRadius: BorderRadius.circular(24),
                   ),
                   child: Row(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       Container(
                         width: 26,
                         height: 26,
                         decoration: BoxDecoration(
                           color: provider.selectedFilter.iconBg,
                           borderRadius: BorderRadius.circular(6),
                         ),
                         child: Icon(
                           provider.selectedFilter.icon,
                           size: 16,
                           color: provider.selectedFilter.iconColor,
                         ),
                       ),
                       const SizedBox(width: 8),
                       Flexible(
                           child: Text(
                             provider.selectedFilter.name,
                             overflow: TextOverflow.ellipsis,
                             style: TextStyle(
                               fontSize: 14,
                               color: CustomColor.textPrimary(context),
                               fontWeight: FontWeight.w500,
                             ),
                           )
                       ),
                       const SizedBox(width: 4),
                       Icon(
                         Icons.keyboard_arrow_down,
                         size: 18,
                         color: CustomColor.textMutedLabel(context),
                       )
                     ],
                   ),
                 ),
               )
               ),
              const SizedBox(width: 8),
               ViewToggleButton(
                 icon: Icons.format_list_bulleted,
                 isSelected: provider.isListView,
                 onTap: (){
                   if(!provider.isListView)provider.toggleView();
                 },

               ),
               const SizedBox( width: 8),
               ViewToggleButton(
                 icon: Icons.grid_view,
                 isSelected: !provider.isListView,
                 onTap: (){
                   if(provider.isListView) provider.toggleView();
                 },
               )
             ],
           ),
         ),
         Expanded(
             child:Center(
               child: SingleChildScrollView(
                 padding: const EdgeInsets.all(24),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     SizedBox(
                       width: 180,
                       height: 180,
                       child: CustomPaint(
                         painter: PartyPainter(),
                       ),
                     ),
                     const SizedBox(height: 24),
                     Text(
                       "No Work asiigned... Nice",
                       style: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.w700,
                         color: CustomColor.textPrimary(context),
                       ),
                     ),
                     const SizedBox(height: 10),
                     Text(
                       "When your're assigned new work items , they'll appear here",
                       textAlign: TextAlign.center,
                       style: TextStyle(
                         fontSize: 14,
                         color: CustomColor.textMutedLabel(context),
                         height: 1.4,
                       ),
                     ),
                     const SizedBox(height: 20),
                     TextButton(onPressed: (){
                       Navigator.pushNamed(context, AppRoute.create);
                     },
                         child:Text(
                           "Create issue",
                           style: TextStyle(
                             color: CustomColor.actionBlueText(context),
                             fontSize: 16,
                             fontWeight: FontWeight.w500,
                           ),
                         )
                     )

                   ],
                 ),
               ),
             )
         )

       ],
     ),



    );
  }
}
