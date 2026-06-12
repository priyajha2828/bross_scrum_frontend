import 'package:flutter/material.dart';

class InviteContactProvider with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> submitEmail(BuildContext context) async {
    final String email = emailController.text.trim();
    if (email.isEmpty) return;

    _setLoading(true);

    await Future.delayed(const Duration(seconds: 2));

    _setLoading(false);
    emailController.clear();
  }

  Future<void> pickFromPhoneContacts() async {
    _setLoading(true);

    await Future.delayed(const Duration(milliseconds: 800));

    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}