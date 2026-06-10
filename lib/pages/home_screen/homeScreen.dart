import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/home_screen/home_screen_provider.dart';
import '../../resources/bottom/custom_bottom.dart';
import '../../resources/bottom/project_card.dart';
import '../../resources/color/custom_color.dart';
import '../../resources/navigation/bottom_nav_bar.dart';
import '../../resources/text_field/text_field.dart';
import '../../routes/app_route.dart';
import '../account/account_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeScreenProvider>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: CustomColor.bgGradientColors,
            stops: CustomColor.bgGradientStops,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // Main Dashboard Scrollable View
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Module Block
                      _buildHeader(),
                      const SizedBox(height: 20),

                      // Search text field
                      _buildSearchBar(),
                      const SizedBox(height: 24),

                      // Overview Section
                      _buildOverviewSection(),
                      const SizedBox(height: 16),

                      // Horizontal Shortcut Cards
                      _buildHorizontalAppCards(),
                      const SizedBox(height: 15),

                      // Filter Toggle Setup (Viewed vs Activity)
                      _buildToggleFilter(provider),
                      const SizedBox(height: 20),

                      // Recent Activity List
                      _buildRecentActivityList(provider),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // Bottom Nav Dock Component
              CustomBottomNavBar(provider: provider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: CustomColor.profileAvatarPurple,
          child:TextButton(
            onPressed: (){
              Navigator.pushNamed(context, AppRoute.accountscreen);

            },

            child:Text(
            'PJ',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          )

        ),
        IconButton(
          icon: const Icon(Icons.add, size: 28, color: Colors.black87),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: TextFromFieldWithPrefixSuffix(
        controller: _searchController,
        hintText: 'Search',
        hintTextColor: Colors.grey[600],
        borderRadius: 28.0,
        fillColor: Colors.white,
        textInputAction: TextInputAction.search,
        applyPrefix: true,
        prefixIcon: Icon(Icons.search, color: Colors.grey[600], size: 26),
        applySuffixIcon: true,
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: _searchController,
          builder: (context, val, child) {
            return val.text.isNotEmpty
                ? IconButton(
              icon: const Icon(Icons.clear, color: Colors.grey),
              onPressed: () => _searchController.clear(),
            )
                : const SizedBox.shrink();
          },
        ),
        validator: (value) => null,
      ),
    );
  }

  Widget _buildOverviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today's Overview",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
        const SizedBox(height: 12),
        Text(
          "No recent work activities found in the last 4 days.",
          style: TextStyle(fontSize: 16, color: Colors.blueGrey[900], height: 1.3),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('Beta', style: TextStyle(color: Colors.grey[700], fontSize: 12, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 8),
            Icon(Icons.info_outline, size: 14, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text('Uses AI. Verify results.', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
            const Spacer(),
            Icon(Icons.thumb_up_alt_outlined, size: 16, color: Colors.grey[700]),
            const SizedBox(width: 14),
            Icon(Icons.thumb_down_alt_outlined, size: 16, color: Colors.grey[700]),
            const SizedBox(width: 14),
            Icon(Icons.copy, size: 16, color: Colors.grey[700]),
          ],
        ),
      ],
    );
  }

  Widget _buildHorizontalAppCards() {
    return SizedBox(
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: SpaceShortcutCard(
              title: 'app1',
              iconBgColor: CustomColor.appShortcutBlue,
              icon: Icons.album,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SpaceShortcutCard(
              title: 'App 2',
              iconBgColor: CustomColor.appShortcutOrange,
              icon: Icons.dashboard_customize,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleFilter(HomeScreenProvider provider) {
    return Container(
      height: 46,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: CustomColor.toggleBackgroundGrey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: FilterToggleButton(
              text: 'Viewed',
              isSelected: provider.selectedFilterIndex == 0,
              onTap: () => provider.changeFilter(0),
            ),
          ),
          Expanded(
            child: FilterToggleButton(
              text: 'Activity',
              isSelected: provider.selectedFilterIndex == 1,
              onTap: () => provider.changeFilter(1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivityList(HomeScreenProvider provider) {
    if (provider.selectedFilterIndex == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Live Updates', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          ActivityFeedRow(
            title: 'No recent tracking changes logs.',
            subtitle: 'Sync completed',
            icon: Icons.sync,
            iconBg: Colors.green[500]!.withOpacity(0.15),
            iconColor: Colors.green[800]!,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Today', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500)),
        const SizedBox(height: 10),
        ActivityFeedRow(
          title: 'My open issues',
          subtitle: 'Filter • Viewed',
          icon: Icons.filter_list,
          iconBg: Colors.blue[100]!,
          iconColor: Colors.blue[800]!,
        ),
        const SizedBox(height: 24),
        const Text('This month', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500)),
        const SizedBox(height: 10),
        ActivityFeedRow(
          title: 'App 2',
          subtitle: 'Space • Viewed',
          icon: Icons.dashboard_customize,
          iconBg: CustomColor.appShortcutOrange,
          iconColor: Colors.white,
          isTopRoundedOnly: true,
        ),
        const Divider(height: 1, thickness: 0.5, indent: 60, color: CustomColor.dividerColor),
        ActivityFeedRow(
          title: 'SCRUM board',
          subtitle: 'Space • Viewed',
          icon: Icons.album,
          iconBg: CustomColor.appShortcutBlue,
          iconColor: Colors.white,
          isBottomRoundedOnly: true,
        ),
      ],
    );
  }
}