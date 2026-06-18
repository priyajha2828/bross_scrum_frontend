import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/home_screen/all_work/all_work_provider.dart';
import '../../../../resources/color/custom_color.dart';


class SearchWorkScreen extends StatefulWidget {
  const SearchWorkScreen({super.key});

  @override
  State<SearchWorkScreen> createState() => _SearchWorkScreenState();
}

class _SearchWorkScreenState extends State<SearchWorkScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<String> _filterChips = [
    'Basic',
    'Space',
    'Type',
    'Status',
    'Priority',
    'Assignee'
    'Reporter',
    'Resolution',
    'Label',
    'Component',
    'Fix Version',
    'Affect Version',
    'Order By',
    'Sprint',
  ];
  int _selectedChip = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AllWorkProvider>(context);

    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      appBar: AppBar(
        backgroundColor: CustomColor.appbar(context),
        elevation: 0,
        leadingWidth: 40,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: CustomColor.arrowback(context)),
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.zero,
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
            hintText: 'Search',
            hintStyle: TextStyle(
              color: CustomColor.inputHintDefault(context),
              fontSize: 18,
            ),
            border: InputBorder.none,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Save search',
              style: TextStyle(
                color: CustomColor.textMutedLabel(context),
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter chips row
          SizedBox(
            height: 52,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _filterChips.length,
              separatorBuilder: (_, i) {
                // Arrow separator after first chip
                if (i == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: CustomColor.textMutedLabel(context),
                    ),
                  );
                }
                return const SizedBox(width: 8);
              },
              itemBuilder: (context, index) {
                final isSelected = index == _selectedChip;
                return GestureDetector(
                  onTap: () => setState(() => _selectedChip = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? CustomColor.chipSelectedBg(context)
                          : CustomColor.card_bg(context),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? CustomColor.chipSelectedBg(context)
                            : CustomColor.chipUnselectedBorder(context),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _filterChips[index],
                          style: TextStyle(
                            color: isSelected
                                ? CustomColor.chipSelectedText(context)
                                : CustomColor.textMutedLabel(context),
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 16,
                          color: isSelected
                              ? CustomColor.chipSelectedText(context)
                              : CustomColor.textMutedLabel(context),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Divider(height: 1, color: CustomColor.dividerColor(context)),

          // Recently viewed
          if (_controller.text.isEmpty) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Recently viewed',
                style: TextStyle(
                  fontSize: 14,
                  color: CustomColor.textMutedLabel(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ...provider.recentWorkItems.map(
                  (item) => ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: item['iconBg'] as Color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: item['iconColor'] as Color,
                    size: 20,
                  ),
                ),
                title: Text(
                  item['title'] as String,
                  style: TextStyle(
                    fontSize: 15,
                    color: CustomColor.textPrimary(context),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  item['subtitle'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    color: CustomColor.textMutedLabel(context),
                  ),
                ),
                onTap: () {},
              ),
            ),
          ],
        ],
      ),
    );
  }
}