import 'package:BrossScrum/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/home_screen/dashboard/dashboard_screen/dashboard_provider.dart';
import '../../../../resources/color/custom_color.dart';
import '../../../../resources/widget/dashboard_selector_sheet.dart';


class DashboardsScreen extends StatelessWidget {
  const DashboardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardsProvider>(context);

    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      appBar: AppBar(
        backgroundColor: CustomColor.bg_color(context),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundColor: Colors.cyan[700],
            child:  TextButton(
              onPressed: (){
              Navigator.pushNamed(context, AppRoute.accountscreen);
            },
              child: Text(
              'PJ',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),)


          ),
        ),
        title: Text(
          'Dashboards',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: CustomColor.textPrimary(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            _DashboardSelectorCard(provider: provider),

            const SizedBox(height: 12),


            if (provider.selectedDashboard == 'Default dashboard') ...[
              _AssignedToMeCard(provider: provider),
              const SizedBox(height: 12),
            ],

            _ActivityStreamCard(provider: provider),

            const SizedBox(height: 12),


            _MissingGadgetsCard(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}


class _DashboardSelectorCard extends StatelessWidget {
  final DashboardsProvider provider;
  const _DashboardSelectorCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => DashboardSelectorSheet.show(context, provider),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: CustomColor.card_bg(context),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              provider.selectedDashboard,
              style: TextStyle(
                fontSize: 16,
                color: CustomColor.textPrimary(context),
                fontWeight: FontWeight.w400,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: CustomColor.textMutedLabel(context),
            ),
          ],
        ),
      ),
    );
  }
}


class _AssignedToMeCard extends StatelessWidget {
  final DashboardsProvider provider;
  const _AssignedToMeCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CustomColor.card_bg(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Assigned to Me',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: CustomColor.textPrimary(context),
                ),
              ),
              Icon(
                Icons.sync,
                color: CustomColor.actionBlueText(context),
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (provider.assignedToMe.isEmpty)
            Text(
              'No matching work items found.',
              style: TextStyle(
                fontSize: 14,
                color: CustomColor.textMutedLabel(context),
              ),
            )
          else
            ...provider.assignedToMe.map(
                  (item) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  item['title'] as String,
                  style: TextStyle(color: CustomColor.textPrimary(context)),
                ),
                subtitle: Text(
                  item['key'] as String,
                  style: TextStyle(color: CustomColor.textMutedLabel(context)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}


class _ActivityStreamCard extends StatelessWidget {
  final DashboardsProvider provider;
  const _ActivityStreamCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    final todayItems = provider.activityItems.where((a) => a.isToday).toList();
    final olderItems = provider.activityItems.where((a) => !a.isToday).toList();

    final Map<String, List<ActivityItem>> groupedOlder = {};
    for (final item in olderItems) {
      groupedOlder.putIfAbsent(item.date, () => []).add(item);
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CustomColor.card_bg(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Activity stream',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: CustomColor.textPrimary(context),
            ),
          ),

          const SizedBox(height: 16),


          if (todayItems.isNotEmpty) ...[
            Text(
              'Today',
              style: TextStyle(
                fontSize: 13,
                color: CustomColor.textMutedLabel(context),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            ...todayItems.map((item) => _ActivityRow(item: item)),
          ],

          // Older grouped sections
          ...groupedOlder.entries.map((entry) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                _formatGroupDate(entry.key),
                style: TextStyle(
                  fontSize: 13,
                  color: CustomColor.textMutedLabel(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              ...entry.value.map((item) => _ActivityRow(item: item)),
            ],
          )),


          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.sync, size: 16, color: CustomColor.actionBlueText(context)),
                const SizedBox(width: 4),
                Text(
                  provider.lastRefreshed,
                  style: TextStyle(
                    fontSize: 13,
                    color: CustomColor.actionBlueText(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatGroupDate(String date) {
    final parts = date.split(' ');
    if (parts.length >= 2) return '${parts[0]} ${parts[1]}';
    return date;
  }
}

class _ActivityRow extends StatelessWidget {
  final ActivityItem item;
  const _ActivityRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap !=null ? () => item.onTap!(context) : null,
     borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: item.avatarColor,
                  child: Text(
                    item.userInitials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${item.userName} ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: CustomColor.textPrimary(context),
                              ),
                            ),
                            TextSpan(
                              text: '${item.action} ${item.issueKey} - ${item.issueTitle}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: CustomColor.textPrimary(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            item.issueKey,
                            style: TextStyle(
                              fontSize: 12,
                              color: CustomColor.textMutedLabel(context),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: item.issueIconBg,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              item.issueIcon,
                              color: item.issueIconColor,
                              size: 14,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            item.date == 'just now' ? 'just now' : item.date,
                            style: TextStyle(
                              fontSize: 12,
                              color: item.date == 'just now'
                                  ? CustomColor.textMutedLabel(context)
                                  : CustomColor.textMutedLabel(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(height: 20, color: CustomColor.dividerColor(context)),
          ],
        ),
      ),
    );
  }
}

// ── Missing Gadgets Card
class _MissingGadgetsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CustomColor.card_bg(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Looks like you're missing some gadgets",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: CustomColor.textPrimary(context),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "We're building more gadgets for dashboards on mobile. Let us know which gadgets you'd like to see.",
            style: TextStyle(
              fontSize: 14,
              color: CustomColor.textPrimary(context),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Send feedback',
              style: TextStyle(
                fontSize: 14,
                color: CustomColor.actionBlueText(context),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}