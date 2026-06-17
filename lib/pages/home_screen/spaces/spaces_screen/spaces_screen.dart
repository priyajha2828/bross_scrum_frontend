import 'package:BrossScrum/pages/home_screen/spaces/spaces_screen/search_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/home_screen/spaces/space_provider.dart';
import '../../../../resources/card/custom_card.dart';
import '../../../../resources/color/custom_color.dart';
import '../../../../routes/app_route.dart';

class SpacesScreen extends StatelessWidget {
  const SpacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SpacesProvider>(context);

    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      appBar: AppBar(
        backgroundColor: CustomColor.bg_color(context),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.cyan[700],
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.accountscreen);
              },
              child: Text(
                'PJ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: CustomColor.textPrimary(context)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchSpacesScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.add, color: CustomColor.textPrimary(context)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Spaces',
              style: TextStyle(
                color: CustomColor.textPrimary(context),
                fontSize: 32,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            if (provider.starredSpaces.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  'Starred',
                  style: TextStyle(
                    color: CustomColor.textMutedLabel(context),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SpaceSectionCard(
                spaces: provider.starredSpaces,
                onStarTap: provider.toggleStar,
              ),
              const SizedBox(height: 20),
            ],
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                'Recently viewed',
                style: TextStyle(
                  color: CustomColor.textMutedLabel(context),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SpaceSectionCard(
              spaces: provider.recentlyViewed,
              onStarTap: provider.toggleStar,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                'All spaces',
                style: TextStyle(
                  color: CustomColor.textMutedLabel(context),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SpaceSectionCard(
              spaces: provider.allSpaces,
              onStarTap: provider.toggleStar,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
