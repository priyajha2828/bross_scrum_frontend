import 'package:BrossScrum/resources/color/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/account_screen_provider/invite_people/invite_people_provider.dart';


class InviteContactPage extends StatelessWidget {
  const InviteContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InviteContactProvider(),
      child: Consumer<InviteContactProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: CustomColor.bg_color(context),
            appBar: AppBar(
              backgroundColor: CustomColor.card_bg(context),
              elevation: 0,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(
                  color: CustomColor.dividerColor(context),
                  height: 1.0,
                ),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: CustomColor.arrowback(context),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: TextField(
                controller: provider.emailController,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => provider.submitEmail(context),
                style: TextStyle(
                  color: CustomColor.textPrimary(context),
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter an email address',
                  hintStyle: TextStyle(
                    color: CustomColor.inputHintDefault(context),
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
            ),
            body: Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    InkWell(
                      onTap: provider.isLoading
                          ? null
                          : () => provider.pickFromPhoneContacts(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_add_alt_1_rounded,
                              color: const Color(0xFF00AA6E),
                              size: 26,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                'Select from phone contacts',
                                style: TextStyle(
                                  color: CustomColor.tileText(context),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (provider.isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.1),
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          CustomColor.introbg,
                        ),
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