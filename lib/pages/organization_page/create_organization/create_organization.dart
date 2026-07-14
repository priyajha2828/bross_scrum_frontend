import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/organization_provider/create_organization_provider.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/org/org_namefield.dart';
import '../../../resources/org/org_slugfield.dart';
import '../../../resources/org/plan_tier_selector.dart';
import 'org_logo_picker.dart';

class CreateOrganizationScreen extends StatelessWidget {
  const CreateOrganizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateOrganizationProvider(),
      child: const _CreateOrganizationView(),
    );
  }
}

class _CreateOrganizationView extends StatefulWidget {
  const _CreateOrganizationView();

  @override
  State<_CreateOrganizationView> createState() =>
      _CreateOrganizationViewState();
}

class _CreateOrganizationViewState extends State<_CreateOrganizationView> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _handleCreate(CreateOrganizationProvider provider) async {
    if (!_formKey.currentState!.validate()) return;
    if (!provider.canSubmit) return;

    final org = await provider.submit();
    if (!mounted) return;

    if (org != null) {
      Navigator.of(context).pop(org);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CreateOrganizationProvider>();

    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      appBar: AppBar(
        backgroundColor: CustomColor.appbar(context),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: CustomColor.arrowback(context)),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          'Create Organization',
          style: TextStyle(
            color: CustomColor.textPrimary(context),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
            children: [
              OrgLogoPicker(
                logoFile: provider.logoFile,
                onPick: () => provider.pickLogoFromGallery(),
              ),
              const SizedBox(height: 24),
              OrgNameField(
                controller: provider.nameController,
                onChanged: provider.onNameChanged,
              ),
              const SizedBox(height: 18),
              OrgSlugField(
                controller: provider.slugController,
                onChanged: provider.onSlugChanged,
                status: provider.slugStatus,
              ),
              const SizedBox(height: 22),
              PlanTierSelector(
                selected: provider.selectedPlan,
                onChanged: provider.selectPlan,
              ),
              if (provider.submitError != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: CustomColor.formErrorBg(context),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline,
                          size: 18,
                          color: CustomColor.formErrorText(context)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          provider.submitError!,
                          style: TextStyle(
                            color: CustomColor.formErrorText(context),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 26),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: provider.canSubmit
                      ? () => _handleCreate(provider)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: provider.canSubmit
                        ? CustomColor.primaryButtonBg(context)
                        : CustomColor.primaryButtonDisabledBg(context),
                    foregroundColor: provider.canSubmit
                        ? CustomColor.primaryButtonText(context)
                        : CustomColor.primaryButtonDisabledText(context),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: provider.isSubmitting
                      ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: CustomColor.primaryButtonText(context),
                    ),
                  )
                      : const Text(
                    'Create Organization',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}