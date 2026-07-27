// import 'package:flutter/material.dart';
//
// class ResetPasswordProvider extends ChangeNotifier {
//   final formKey = GlobalKey<FormState>();
//
//   final passwordController = TextEditingController();
//   final confirmController = TextEditingController();
//
//   bool hidePassword = true;
//   bool hideConfirm = true;
//
//   double strength = 0.0;
//
//   String passwordMessage = "Password must be at least 8 characters";
//
//   Color strengthColor = Colors.red;
//
//   void togglePassword() {
//     hidePassword = !hidePassword;
//     notifyListeners();
//   }
//
//   void toggleConfirm() {
//     hideConfirm = !hideConfirm;
//     notifyListeners();
//   }
//
//   void checkStrength(String value) {
//     if (value.isEmpty) {
//       strength = 0;
//       strengthColor = Colors.red;
//     } else if (value.length < 8) {
//       strength = .25;
//       strengthColor = Colors.red;
//     } else if (value.length < 10) {
//       strength = .50;
//       strengthColor = Colors.orange;
//     } else if (value.length < 12) {
//       strength = .75;
//       strengthColor = Colors.amber;
//     } else {
//       strength = 1;
//       strengthColor = Colors.green;
//     }
//
//     notifyListeners();
//   }
//
//   String? passwordValidator(String? value) {
//     if (value == null || value.isEmpty) {
//       return "Password is required";
//     }
//
//     if (value.length < 8) {
//       return "Minimum 8 characters required";
//     }
//
//     return null;
//   }
//
//   String? confirmValidator(String? value) {
//     if (value != passwordController.text) {
//       return "Passwords do not match";
//     }
//
//     return null;
//   }
//
//   void resetPassword() {
//     if (!formKey.currentState!.validate()) return;
//
//     // API Call Here
//   }
//
//   @override
//   void dispose() {
//     passwordController.dispose();
//     confirmController.dispose();
//     super.dispose();
//   }
// }