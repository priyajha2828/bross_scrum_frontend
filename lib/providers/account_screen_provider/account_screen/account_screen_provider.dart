import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountScreenProvider with ChangeNotifier {
  String _userName = "Priya Jha";
  String _userEmail = "priyajhaguriya@gmail.com";
  String _siteName = 'priyajhaa';
  final List<String> _sites = [];

  String get userName => _userName;
  String get userEmail => _userEmail;
  String get siteName => _siteName;
  List<String> get sites => List.unmodifiable(_sites);

  void updateProfile({required String name, required String email}) {
    if (name.trim().isEmpty || email.trim().isEmpty) return;
    _userEmail = email.trim();
    _userName = name.trim();
    notifyListeners();
  }

  void addSites(String newSite) {
    final cleanSite = newSite.trim();
    if (cleanSite.isEmpty) return;
    _sites.add(cleanSite);
    notifyListeners();
  }

  Future<void> redirectToPlayStore() async {
    const String packageName = "com.example.BrossScrum";

    final Uri playStoreUri = Uri.parse("market://details?id=$packageName");
    final Uri webPackageUri = Uri.parse("https://play.google.com/store/apps/details?id=$packageName");

    try {
      if (await canLaunchUrl(playStoreUri)) {
        await launchUrl(playStoreUri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(webPackageUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint("Could not launch Play Store layout: $e");
    }
  }
}