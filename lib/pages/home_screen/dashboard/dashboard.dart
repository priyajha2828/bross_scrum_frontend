import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/home_screen/dashboard/dashboard_provider.dart';
import '../../../resources/card/dashboard_card.dart';
import '../../../resources/color/custom_color.dart';
import '../../../routes/app_route.dart';


class DashboardsScreen extends StatelessWidget {
  const DashboardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardsProvider>(context);

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(color: CustomColor.bg_color(context)),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 20),
                DashboardDropdown(
                  selectedDashboard: provider.selectedDashboard,
                  onTap: () {},

                ),

                const SizedBox(height: 16),
                AssignedToMeCard(
                  isRefreshing: provider.isRefreshing,
                  hasItems: provider.assignedToMeItems.isNotEmpty,
                  itemCount: provider.assignedToMeItems.length,
                  onRefresh: provider.refreshAssignedToMe,
                ),
                const SizedBox(height: 16),
                ActivityFeedCard(
                  activities: provider.activities,
                  dateLabel: '12 June',
                  lastUpdated: provider.lastUpdated,
                  isRefreshing: provider.isRefreshing,
                  onRefresh: provider.refreshActivityStream,
                ),
                const SizedBox(height: 16),
                MissingGadgetsCard(onSendFeedback: () {}),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: Colors.cyan[700],
          child: TextButton(onPressed: (){
            Navigator.pushNamed(context, AppRoute.accountscreen);
          }, child:const Text(
            'PJ',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ), )

        ),
        const SizedBox(width: 24),
        Text(
          'Dashboard',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500, color: CustomColor.textPrimary(context)),
        ),
      ],
    );
  }
}