import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/home_screen/home_screen_provider/home_screen_provider.dart';
import '../../../../resources/bottom/custom_bottom.dart';
import '../../../../resources/card/custom_card.dart';
import '../../../../resources/color/custom_color.dart';
import '../../../../resources/text_field/text_field.dart';
import '../../../../routes/app_route.dart';

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
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildSearchBar(),
                const SizedBox(height: 24),
                _buildOverviewSection(),
                const SizedBox(height: 16),
                _buildHorizontalAppCards(),
                const SizedBox(height: 15),
                _buildToggleFilter(provider),
                const SizedBox(height: 20),
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
          radius: 20,
          backgroundColor: Colors.cyan[700],
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
        PopupMenuButton<String>(
          icon: Icon(
            Icons.add,
            size: 28,
            color: CustomColor.textPrimary(context),
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onSelected: (value) {
            switch (value) {
              case 'create_work_item':
                break;
              case 'ai_create':
                break;
              case 'photo_library':
                break;
              case 'camera':
                break;
            }
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem<String>(
              value: 'create_work_item',
              child: Row(
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    color: CustomColor.textPrimary(context),
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoute.create);
                    },
                    child: Text(
                      'Create work item',
                      style: TextStyle(
                        color: CustomColor.textPrimary(context),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const PopupMenuDivider(height: 1),
            PopupMenuItem<String>(
              value: 'ai_create',
              child: Row(
                children: [
                  Icon(
                    Icons.auto_awesome,
                    color: Colors.purple.shade400,
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Create with AI',
                    style: TextStyle(
                      color: CustomColor.textPrimary(context),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'photo_library',
              child: Row(
                children: [
                  Icon(
                    Icons.photo_library_outlined,
                    color: CustomColor.textPrimary(context),
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'From photo library',
                    style: TextStyle(
                      color: CustomColor.textPrimary(context),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'camera',
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    color: CustomColor.textPrimary(context),
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Camera',
                    style: TextStyle(
                      color: CustomColor.textPrimary(context),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
          ),
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
                    icon: Icon(
                      Icons.clear,
                      color: CustomColor.textMutedLabel(context),
                    ),
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
              onTap: () {
                Navigator.pushNamed(context, AppRoute.appscreen);
              },
              title: 'app1',
              iconBgColor: Colors.purple.shade600,
              icon: Icons.album,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SpaceShortcutCard(
              onTap: () {
                Navigator.pushNamed(context, AppRoute.appscreen);
              },
              title: 'App 2',
              iconBgColor: Colors.amber.shade900,
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
            onTap: () {},
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
          onTap: () {
            Navigator.pushNamed(context, AppRoute.myopenissue);
          },
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
          onTap: () {
            Navigator.pushNamed(context, AppRoute.appscreen);
          },
          title: 'App 2',
          subtitle: 'Space • Viewed',
          icon: Icons.dashboard_customize,
          iconBg: Colors.amber.shade900,
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
          onTap: () {
            Navigator.pushNamed(context, AppRoute.appscreen);
          },
          title: 'SCRUM board',
          subtitle: 'Space • Viewed',
          icon: Icons.album,
          iconBg: Colors.purple.shade600,
          iconColor: Colors.white,
          isBottomRoundedOnly: true,
        ),
      ],
    );
  }
}
