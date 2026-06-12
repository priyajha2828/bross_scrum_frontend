import 'package:BrossScrum/resources/color/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/account_screen_provider/settings/manage_account/manage_account_provider.dart';

class ManageAccountPage extends StatelessWidget {
  const ManageAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = CustomColor.isDark(context);

    return ChangeNotifierProvider(
      create: (_) => ManageAccountProvider(),
      child: Consumer<ManageAccountProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: CustomColor.bg_color(context),
            appBar: AppBar(
              backgroundColor: CustomColor.appbar(context),
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: CustomColor.arrowback(context),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                'Manage account',
                style: TextStyle(
                  color: CustomColor.textPrimary(context),
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: CustomColor.card_bg(context),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Review accounts on browser',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: CustomColor.textPrimary(context),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Review logged in accounts and remove them from the browser. You won\'t be logged out from the app.',
                              style: TextStyle(
                                fontSize: 15,
                                color: CustomColor.textMutedLabel(context),
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 24),
                            GestureDetector(
                              onTap: provider.isLoading
                                  ? null
                                  : () => provider.performGoToBrowser(),
                              child: Text(
                                'Go to browser',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? const Color(0xFF3B82F6) : CustomColor.introbg,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: CustomColor.card_bg(context),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Delete account',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: CustomColor.textPrimary(context),
                              ),
                            ),
                            const SizedBox(height: 12),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 15,
                                  color: CustomColor.textMutedLabel(context),
                                  height: 1.4,
                                  fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'When you delete your account, you lose access to all your Atlassian account services and we permanently delete your personal data. You can cancel the deletion within 14 days. ',
                                  ),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.baseline,
                                    baseline: TextBaseline.alphabetic,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        'Learn more about deleting an account',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: isDark ? const Color(0xFF3B82F6) : CustomColor.introbg,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            GestureDetector(
                              onTap: provider.isLoading
                                  ? null
                                  : () async {
                                // Connect to backend account deletion code if needed later
                              },
                              child: Text(
                                'Delete account',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: CustomColor.logout_text(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (provider.isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.15),
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0052CC)),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}