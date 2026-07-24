import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/color/custom_color.dart';
import '../../services/org_service.dart';

class OrganizationSummary {
  final String id;
  final String name;
  final int memberCount;
  final String status;
  final String imageUrl;
  final List<String> avatarUrls;
  final int extraMembersCount;

  const OrganizationSummary({
    required this.id,
    required this.name,
    required this.memberCount,
    required this.status,
    required this.imageUrl,
    required this.avatarUrls,
    this.extraMembersCount = 0,
  });

  factory OrganizationSummary.fromJson(Map<String, dynamic> json) {
    return OrganizationSummary(
      id: json["id"],
      name: json["name"],
      memberCount: json["memberCount"] ?? 0,
      status: json["status"] ?? "Active",
      imageUrl: json["logoUrl"] ?? "",
      avatarUrls: (json["avatarUrls"] as List?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
      extraMembersCount: json["extraMembersCount"] ?? 0,
    );
  }
}

class OrganizationProvider extends ChangeNotifier {
  final OrganizationApiRepository _service = OrganizationApiRepository();

  final List<OrganizationSummary> _organizations = [];

  List<OrganizationSummary> get organizations =>
      List.unmodifiable(_organizations);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final String inviteLink = "/join/xy7f2k";

  bool _isCopying = false;
  bool get isCopying => _isCopying;

  Future<void> loadOrganizations() async {
    try {
      _isLoading = true;
      notifyListeners();

      final organizations = await _service.getOrganizations();

      _organizations
        ..clear()
        ..addAll(organizations);
    } catch (e) {
      debugPrint("Load Organizations Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<void> copyInviteLink(BuildContext context) async {
    _isCopying = true;
    notifyListeners();

    await Clipboard.setData(
      ClipboardData(text: inviteLink),
    );

    _isCopying = false;
    notifyListeners();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Invite link copied to clipboard"),
          backgroundColor: CustomColor.copyButtonBg(context),
        ),
      );
    }
  }

  void viewDetails(String id) {}
}