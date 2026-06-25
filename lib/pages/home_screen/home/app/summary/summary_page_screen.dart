import 'package:BrossScrum/providers/home_screen/app/SummaryPage/summary_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../resources/banner/custom_banner.dart';
import '../../../../../resources/card/custom_card.dart';

class SummaryPageScreen extends StatefulWidget {
  const SummaryPageScreen({super.key});

  @override
  State<SummaryPageScreen> createState() => _SummaryPageScreenState();
}

class _SummaryPageScreenState extends State<SummaryPageScreen> {
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<SummaryPageProvider>().refresh();
    });
  }
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SummaryPageProvider>();

    return RefreshIndicator(
        onRefresh: provider.refresh,
        child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SummaryStatsGrid(stats: provider.stats),
              const SizedBox(height: 16),

              StatusOverviewCard(
                stats:provider.stats,
                isLoading:provider.isLoading,
                lastRefreshedLabel : provider.lastRefreshedLabel,
                onRefresh: provider.refresh,
              ),
              const SizedBox(height: 16),
          PriorityBreakdownCard(
              stats: provider.stats,
              maxCount: provider.maxPriorityCount,
            ),
              const SizedBox(height: 16),

              FeedbackBanner(
                onTap: (){}
              )
            ],
          ),
        )
    );
  }
}
