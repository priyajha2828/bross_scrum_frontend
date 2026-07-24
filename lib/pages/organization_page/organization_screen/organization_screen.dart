import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/organization_provider/organization_provider.dart';
import '../../../resources/card/invite_card.dart';
import '../../../resources/card/organization_card.dart';
import '../../../resources/color/custom_color.dart';
import '../../../routes/app_route.dart';
import '../create_organization/create_organization.dart';

class OrganizationsScreen extends StatefulWidget {
  const OrganizationsScreen({super.key});

  @override
  State<OrganizationsScreen> createState() => _OrganizationsScreenState();
}

class _OrganizationsScreenState extends State<OrganizationsScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<OrganizationProvider>().loadOrganizations();
    });
  }



  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OrganizationProvider>();

    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      appBar: AppBar(
        backgroundColor: CustomColor.appbar(context),
        elevation: 0,

        title: Text(
          'Organizations',
          style: TextStyle(
            color: CustomColor.textPrimary(context),
            fontWeight: FontWeight.w700,
          ),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColor.fabBg(context),
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.createorgscreen);
        },
        child: Icon(
          Icons.add,
          color: CustomColor.fabIcon(context),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
          children: [
            Text(
              'Your Organizations',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: CustomColor.textPrimary(context),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Manage and monitor your team structures.',
              style: TextStyle(
                fontSize: 14,
                color: CustomColor.textMutedLabel(context),
              ),
            ),
            const SizedBox(height: 20),

            for (final org in provider.organizations) ...[
              OrganizationCard(
                organization: org,
                onViewDetails: () => provider.viewDetails(org.id),
              ),
              const SizedBox(height: 16),
            ],

            InviteOthersCard(
              inviteLink: provider.inviteLink,
              isCopying: provider.isCopying,
              onCopy: () => provider.copyInviteLink(context),
            ),

            const SizedBox(height: 24),

            Center(
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: CustomColor.addOrgGhostBg(context),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add_business_outlined,
                    color: CustomColor.addOrgGhostIcon(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
