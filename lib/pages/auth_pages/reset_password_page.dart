// reset_password_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider/auth_provider.dart';
import '../../resources/color/custom_color.dart';
import '../../routes/app_route.dart'; // adjust path to wherever AppRoute is defined

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Form(
            key: provider.resetPasswordFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Reset Password",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: CustomColor.textPrimary(context),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 35),

                Text(
                  "Please enter your new password below.",
                  style: TextStyle(
                    fontSize: 16,
                    color: CustomColor.smalltext(context),
                  ),
                ),
                const SizedBox(height: 35),

                const Text(
                  "New Password",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: provider.resetPasswordController,
                  obscureText: provider.hideResetPassword,
                  onChanged: provider.checkResetPasswordStrength,
                  validator: provider.resetPasswordValidator,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: provider.toggleResetPassword,
                      icon: Icon(
                        provider.hideResetPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                LinearProgressIndicator(
                  value: provider.resetStrength,
                  minHeight: 7,
                  color: provider.resetStrengthColor,
                  backgroundColor: CustomColor.secondaryContainerBlue,
                  borderRadius: BorderRadius.circular(10),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 18,
                      color: CustomColor.smalltext(context),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        provider.resetPasswordMessage,
                        style: TextStyle(
                          color: CustomColor.smalltext(context),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                const Text(
                  "Confirm New Password",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: provider.resetConfirmController,
                  obscureText: provider.hideResetConfirm,
                  validator: provider.resetConfirmValidator,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: provider.toggleResetConfirm,
                      icon: Icon(
                        provider.hideResetConfirm
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                if (provider.serverError != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    provider.serverError!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ],

                const SizedBox(height: 45),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: provider.isLoading
                        ? null
                        : () async {
                      final success = await provider.resetPassword();

                      if (success && context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoute.login,
                              (_) => false,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColor.primaryButtonBg(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: provider.isLoading
                        ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                        : const Text(
                      "Reset Password",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.login),
                    label: const Text(
                      "Back to Login",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
    );
  }
}