import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/home_screen/all_work/all_work_provider.dart';
import '../../../../resources/card/custom_card.dart';
import '../../../../resources/color/custom_color.dart';
import '../../../../routes/app_route.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AllWorkProvider>(context);

    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      appBar: AppBar(
        backgroundColor: CustomColor.appbar(context),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: CustomColor.arrowback(context)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Filters',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: CustomColor.textPrimary(context),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.create);
            },
            child: Text(
              'Create',
              style: TextStyle(
                fontSize: 16,
                color: CustomColor.actionBlueText(context),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterSectionCard(
              title: 'Starred filters',
              filters: provider.starredFilters,
              onTap: (f) {
                provider.setSelectedFilter(f);
                Navigator.pop(context);
              },
              onStarTap: provider.toggleStar,
            ),
            FilterSectionCard(
              title: 'Recent filters',
              filters: provider.recentFilters,
              onTap: (f) {
                provider.setSelectedFilter(f);
                Navigator.pop(context);
              },
              onStarTap: provider.toggleStar,
            ),
            FilterSectionCard(
              title: 'Default filters',
              filters: provider.defaultFilters,
              onTap: (f) {
                provider.setSelectedFilter(f);
                Navigator.pop(context);
              },
              onStarTap: provider.toggleStar,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}