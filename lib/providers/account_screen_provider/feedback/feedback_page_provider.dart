import 'package:flutter/material.dart';

class SendFeedbackProvider with ChangeNotifier {
  final TextEditingController feedbackController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool _isLoading = false;
  String _feedbackType = 'Bug';
  bool _canContact = false;

  bool get isLoading => _isLoading;
  String get feedbackType => _feedbackType;
  bool get canContact => _canContact;

  void setFeedbackType(String value) {
    _feedbackType = value;
    notifyListeners();
  }

  void setCanContact(bool value) {
    _canContact = value;
    notifyListeners();
  }

  Future<bool> sendFeedback() async {
    if (feedbackController.text.trim().isEmpty) return false;
    if (_canContact && emailController.text.trim().isEmpty) return false;

    _setLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    _setLoading(false);

    feedbackController.clear();
    emailController.clear();
    _canContact = false;
    _feedbackType = 'Bug';
    notifyListeners();
    return true;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    feedbackController.dispose();
    emailController.dispose();
    super.dispose();
  }
}