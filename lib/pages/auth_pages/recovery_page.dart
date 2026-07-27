import 'package:BrossScrum/providers/auth_provider/auth_provider.dart';
import 'package:BrossScrum/resources/color/custom_color.dart';
import 'package:BrossScrum/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../resources/text_field/text_field.dart';

class RecoveryPage extends StatelessWidget {
  const RecoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    return Consumer<AuthProvider>(
      builder: (context, provider, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: topPadding + 24,
                      bottom: 12,
                      left: 24,
                      right: 24,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        // child: Container(
                        //   padding: const EdgeInsets.all(28),
                        //   decoration: BoxDecoration(
                        //     color: CustomColor.logincontainer(context),
                        //     borderRadius: BorderRadius.circular(28),
                        //   ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 256,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/brslogo.png",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            Center(
                              child: Text(
                                "Can't log in",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: CustomColor.tileTextPrimary(context),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "We'll send a recovery link to",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: CustomColor.bross_scrum(context),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFromFieldWithPrefixSuffix(
                              controller: provider.recoveryEmailController,
                              hintText: "Enter your email",
                              hintTextColor: CustomColor.textMutedLabel(
                                context,
                              ),
                              fillColor: CustomColor.card_bg(context),
                              borderRadius: 4,
                              applyPrefix: false,
                              keyboardType: TextInputType.emailAddress,
                              enabledBorderColor: provider.emailError == null
                                  ? const Color(0xFF0052CC)
                                  : Colors.red.shade800,
                              focusedBorderColor: provider.emailError == null
                                  ? const Color(0xFF0052CC)
                                  : Colors.red.shade800,
                              errorBorderColor: Colors.red,
                              validator: (value) => null,
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: provider.isLoading
                                  ? null
                                  : () async {
                                      final success = await provider
                                          .sendRecoveryLink();
                                      if (success && context.mounted) {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoute.otp,
                                        );
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0052CC),
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 44),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                elevation: 0,
                              ),
                              child: provider.isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'Send recovery link',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 16),

                            Center(
                              child: TextButton(
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  AppRoute.login,
                                ),
                                child: Text(
                                  "Back to log in",
                                  style: TextStyle(
                                    color: CustomColor.bross_scrum(context),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: TextButton(
                                onPressed: () =>
                                    Navigator.pushNamed(context, AppRoute.otp),
                                child: Text(
                                  "otp screen ",
                                  style: TextStyle(
                                    color: CustomColor.bross_scrum(context),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: TextButton(
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  AppRoute.resetpasswordscreen,
                                ),
                                child: Text(
                                  "reset screen  ",
                                  style: TextStyle(
                                    color: CustomColor.bross_scrum(context),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
