import 'package:flutter/material.dart';
import '../../../resources/model/filter_model.dart';

class AllWorkProvider extends ChangeNotifier {
  // View toggle: true = list, false = grid
  bool _isListView = true;
  bool get isListView => _isListView;

  void toggleView() {
    _isListView = !_isListView;
    notifyListeners();
  }

  // Selected filter
  FilterModel _selectedFilter = FilterModel(
    name: 'My open work items',
    icon: Icons.person_outline,
    iconBg: Color(0xFFE5E7EB),
    iconColor: Color(0xFF4B5563),
    section: FilterSection.starred,
    isStarred: true,
  );

  FilterModel get selectedFilter => _selectedFilter;

  void setSelectedFilter(FilterModel filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  // All filters
  final List<FilterModel> _filters = [
    FilterModel(
      name: 'My open work items',
      icon: Icons.person_outline,
      iconBg: Color(0xFFE5E7EB),
      iconColor: Color(0xFF4B5563),
      section: FilterSection.starred,
      isStarred: true,
    ),
    FilterModel(
      name: 'Updated recently',
      icon: Icons.filter_list,
      iconBg: Color(0xFFE5E7EB),
      iconColor: Color(0xFF4B5563),
      section: FilterSection.recent,
    ),
    FilterModel(
      name: 'Viewed recently',
      icon: Icons.filter_list,
      iconBg: Color(0xFFE5E7EB),
      iconColor: Color(0xFF4B5563),
      section: FilterSection.recent,
    ),
    FilterModel(
      name: 'Reported by me',
      icon: Icons.filter_list,
      iconBg: Color(0xFFE5E7EB),
      iconColor: Color(0xFF4B5563),
      section: FilterSection.recent,
    ),
    FilterModel(
      name: 'Done work items',
      icon: Icons.filter_list,
      iconBg: Color(0xFFE5E7EB),
      iconColor: Color(0xFF4B5563),
      section: FilterSection.recent,
    ),
    FilterModel(
      name: 'Reported by me',
      icon: Icons.error_outline,
      iconBg: Color(0xFFE5E7EB),
      iconColor: Color(0xFF4B5563),
      section: FilterSection.default_,
    ),
    FilterModel(
      name: 'Viewed recently',
      icon: Icons.remove_red_eye_outlined,
      iconBg: Color(0xFFE5E7EB),
      iconColor: Color(0xFF4B5563),
      section: FilterSection.default_,
    ),
    FilterModel(
      name: 'All work items',
      icon: Icons.inbox_outlined,
      iconBg: Color(0xFFE5E7EB),
      iconColor: Color(0xFF4B5563),
      section: FilterSection.default_,
    ),
    FilterModel(
      name: 'Open work items',
      icon: Icons.open_in_new,
      iconBg: Color(0xFFE5E7EB),
      iconColor: Color(0xFF4B5563),
      section: FilterSection.default_,
    ),
  ];

  List<FilterModel> get starredFilters =>
      _filters.where((f) => f.isStarred).toList();

  List<FilterModel> get recentFilters =>
      _filters.where((f) => f.section == FilterSection.recent).toList();

  List<FilterModel> get defaultFilters =>
      _filters.where((f) => f.section == FilterSection.default_).toList();

  void toggleStar(FilterModel filter) {
    filter.isStarred = !filter.isStarred;
    if (filter.isStarred) {
      filter = FilterModel(
        name: filter.name,
        icon: filter.icon,
        iconBg: filter.iconBg,
        iconColor: filter.iconColor,
        section: FilterSection.starred,
        isStarred: true,
      );
    }
    notifyListeners();
  }

  // Search
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Recently viewed work items for search
  final List<Map<String, dynamic>> recentWorkItems = [
    {
      'title': 'Helooo',
      'subtitle': 'SCRUM-8',
      'icon': Icons.bookmark_border,
      'iconBg': const Color(0xFFDCFCE7),
      'iconColor': const Color(0xFF16A34A),
    },
    {
      'title': 'Hii',
      'subtitle': 'SCRUM-7',
      'icon': Icons.bolt,
      'iconBg': const Color(0xFFF3E8FF),
      'iconColor': const Color(0xFFB554E0),
    },
  ];
}