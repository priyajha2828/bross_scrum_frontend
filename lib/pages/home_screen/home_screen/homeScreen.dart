import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/home_screen/home_screen_provider/home_screen_provider.dart';
import '../../../resources/bottom/custom_bottom.dart';
import '../../../resources/bottom/project_card.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/text_field/text_field.dart';
import '../../../routes/app_route.dart';

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

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: CustomColor.bgGradientColors(context),
            stops: CustomColor.bgGradientStops,
          ),
        ),
        child: SafeArea(
          bottom: false,
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
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor:Colors.cyan[700],
          child: ClipOval(
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(36, 36),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.accountscreen);
              },
              child: const Text(
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
        IconButton(
          icon: Icon(
            Icons.add,
            size: 28,
            color: CustomColor.textPrimary(context),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    final bool isDark = CustomColor.isDark(context);

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black45 : Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: TextFromFieldWithPrefixSuffix(
        controller: _searchController,
        hintText: 'Search',
        hintTextColor: CustomColor.textMutedLabel(context),
        borderRadius: 28.0,
        fillColor: CustomColor.card_bg(context),
        textInputAction: TextInputAction.search,
        applyPrefix: true,
        prefixIcon: Icon(
          Icons.search,
          color: CustomColor.textMutedLabel(context),
          size: 26,
        ),
        applySuffixIcon: true,
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: _searchController,
          builder: (context, val, child) {
            return val.text.isNotEmpty
                ? IconButton(
              icon: Icon(Icons.clear, color: CustomColor.textMutedLabel(context)),
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
    final mutedColor = CustomColor.textMutedLabel(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today's Overview",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w500,
            color: CustomColor.textPrimary(context),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "No recent work activities found in the last 4 days.",
          style: TextStyle(
            fontSize: 16,
            color: CustomColor.tileTextPrimary(context),
            height: 1.3,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Beta',
                style: TextStyle(
                  color: CustomColor.tileTextPrimary(context),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.info_outline, size: 14, color: mutedColor),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                'Uses AI. Verify results.',
                style: TextStyle(color: mutedColor, fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            Icon(Icons.thumb_up_alt_outlined, size: 16, color: mutedColor),
            const SizedBox(width: 14),
            Icon(Icons.thumb_down_alt_outlined, size: 16, color: mutedColor),
            const SizedBox(width: 14),
            Icon(Icons.copy, size: 16, color: mutedColor),
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
        color: CustomColor.toggleBackgroundGrey.withOpacity(0.3),
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
    final subheadStyle = TextStyle(
      color: CustomColor.smalltext(context),
      fontWeight: FontWeight.w500,
    );

    if (provider.selectedFilterIndex == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Live Updates', style: subheadStyle),
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
        Text('Today', style: subheadStyle),
        const SizedBox(height: 10),
        ActivityFeedRow(
          title: 'My open issues',
          subtitle: 'Filter • Viewed',
          icon: Icons.filter_list,
          iconBg: Colors.blue[100]!,
          iconColor: Colors.blue[800]!,
        ),
        const SizedBox(height: 24),
        Text('This month', style: subheadStyle),
        const SizedBox(height: 10),
        ActivityFeedRow(
          title: 'App 2',
          subtitle: 'Space • Viewed',
          icon: Icons.dashboard_customize,
          iconBg: CustomColor.appShortcutOrange,
          iconColor: Colors.white,
          isTopRoundedOnly: true,
        ),
        Divider(
          height: 1,
          thickness: 0.5,
          indent: 60,
          color: CustomColor.dividerColor(context),
        ),
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