import 'package:BrossScrum/providers/home_screen/spaces/space_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../resources/card/custom_card.dart';
import '../../../../resources/color/custom_color.dart';

class SearchSpacesScreen extends StatefulWidget {
  const SearchSpacesScreen({super.key});

  @override
  State<SearchSpacesScreen> createState() => _SearchSpacesScreenState();
}

class _SearchSpacesScreenState extends State<SearchSpacesScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SpacesProvider>(context);

    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      appBar: AppBar(
        backgroundColor: CustomColor.bg_color(context),
        elevation: 0,
        leadingWidth: 56,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: CustomColor.arrowback(context)),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: provider.setSearchQuery,
          style: TextStyle(
            color: CustomColor.textPrimary(context),
            fontSize: 18,
          ),
          decoration: InputDecoration(
            hintText: 'Search spaces',
            hintStyle: TextStyle(color: CustomColor.inputHintDefault(context)),
            border: InputBorder.none,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
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
              spaces: provider.filteredSpaces,
              onStarTap: provider.toggleStar,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}