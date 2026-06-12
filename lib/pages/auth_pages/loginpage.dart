import 'package:BrossScrum/providers/auth_provider/auth_provider.dart';
import 'package:BrossScrum/resources/color/custom_color.dart';
import 'package:BrossScrum/resources/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../resources/bottom/signin_bottom.dart';
import '../../routes/app_route.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    final bool isDark = CustomColor.isDark(context);

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
                        child: Container(
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: CustomColor.logincontainer(context),
                            borderRadius: BorderRadius.circular(28),
                          ),
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
                              const SizedBox(height: 16),
                              Center(
                                child: Text(
                                  'Login to Continue',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColor.tileTextPrimary(context),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),
                              Row(
                                children: [
                                  Text(
                                    "Email ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: CustomColor.tileTextPrimary(context),
                                    ),
                                  ),
                                  const Text(
                                    "*",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              TextFromFieldWithPrefixSuffix(
                                controller: provider.emailController,
                                hintText: "Enter your email",
                                hintTextColor: CustomColor.textMutedLabel(context),
                                fillColor: CustomColor.card_bg(context),
                                borderRadius: 4.0,
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
                              if (provider.emailError != null) ...[
                                const SizedBox(height: 6),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.warning,
                                      color: Colors.red,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        provider.emailError!,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              const SizedBox(height: 16),
                              InkWell(
                                onTap: () => provider.toggleRememberMe(null),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Checkbox(
                                        value: provider.rememberMe,
                                        onChanged: (val) => provider.toggleRememberMe(val),
                                        activeColor: const Color(0xFF0052CC),
                                        side: BorderSide(
                                          color: isDark ? Colors.grey.shade400 : Colors.grey,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Remember me",
                                      style: TextStyle(
                                        color: CustomColor.tileTextPrimary(context), // Changes cleanly across dark/light contexts
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Icon(
                                      Icons.info,
                                      color: CustomColor.bross_scrum,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 32),
                              ElevatedButton(
                                onPressed: provider.isLoading
                                    ? null
                                    : () async {
                                  bool loginSuccess = await provider.login();
                                  if (loginSuccess && context.mounted) {
                                    Navigator.pushNamed(context, AppRoute.otp);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0052CC),
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(double.infinity, 48),
                                  disabledBackgroundColor: const Color(0xFF0052CC).withOpacity(0.6),
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
                                  'Continue',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 24.0, left: 24.0, right: 24.0),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Center(
                          child: Text(
                            'Or continue with:',
                            style: TextStyle(
                              color: CustomColor.bross_scrum,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Column(
                          children: [
                            loginpageButton(
                              label: 'Google',
                              iconData: Icons.g_mobiledata,
                              iconColor: Colors.red,
                              onPressed: () => provider.LoginWithGoogle(),
                            ),
                            const SizedBox(height: 12),
                            loginpageButton(
                              label: 'Apple',
                              iconData: Icons.apple,
                              iconColor: isDark ? Colors.white : Colors.black,
                              onPressed: () => provider.LoginWithApple(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoute.recovery);
                                },
                                child: Text(
                                  "Can't log in",
                                  style: TextStyle(
                                    color: CustomColor.bross_scrum,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoute.signup);
                                },
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                    color: CustomColor.bross_scrum,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                            ),
                            TextButton(
                              onPressed: (){
                                Navigator.pushNamed(context, AppRoute.homescreen);
                              },
                              child: Text(
                                "Skip Login",
                                style: TextStyle(
                                  color: CustomColor.bross_scrum,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}