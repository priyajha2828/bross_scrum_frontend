import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../resources/color/custom_color.dart';


/// Simple data model for a single organization entry.
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
}

/// Holds the list of organizations for the current user plus the
/// invite-link logic used by the "Invite Others" card.
class OrganizationProvider extends ChangeNotifier {
  final List<OrganizationSummary> _organizations = [
    const OrganizationSummary(
      id: 'kinetic-team',
      name: 'Kinetic Team',
      memberCount: 24,
      status: 'Active',
      imageUrl:
      'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800&q=80',
      avatarUrls: [
        'https://i.pravatar.cc/100?img=1',
        'https://i.pravatar.cc/100?img=2',
        'https://i.pravatar.cc/100?img=3',
      ],
      extraMembersCount: 21,
    ),
  ];

  List<OrganizationSummary> get organizations => List.unmodifiable(_organizations);

  final String inviteLink = 'kinetic.app/join/xy7f2k';

  bool _isCopying = false;
  bool get isCopying => _isCopying;

  /// Copies the invite link to the clipboard and shows a confirmation snackbar.
  Future<void> copyInviteLink(BuildContext context) async {
    _isCopying = true;
    notifyListeners();

    await Clipboard.setData(ClipboardData(text: inviteLink));

    _isCopying = false;
    notifyListeners();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Invite link copied to clipboard'),
          backgroundColor: CustomColor.copyButtonBg(context),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  /// Placeholder for the FAB action - hook up navigation/creation flow here.
  void addOrganization() {
    // e.g. Navigator.pushNamed(context, '/create-organization');
  }

  void viewDetails(String organizationId) {
    // e.g. Navigator.pushNamed(context, '/organization/$organizationId');
  }
}