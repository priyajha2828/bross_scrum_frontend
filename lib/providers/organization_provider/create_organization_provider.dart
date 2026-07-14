import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../pages/organization_page/create_organization/organization_enums.dart';
import '../../pages/organization_page/create_organization/organization_repository.dart';


class Organization {
  final String id;
  final String name;
  final String slug;
  final String? logoUrl;
  final String ownerId;
  final PlanTier planTier;
  final SubscriptionStatus subscriptionStatus;
  final DateTime createdAt;

  const Organization({
    required this.id,
    required this.name,
    required this.slug,
    required this.ownerId,
    required this.planTier,
    required this.subscriptionStatus,
    required this.createdAt,
    this.logoUrl,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      logoUrl: json['logoUrl'] as String?,
      ownerId: json['ownerId'] as String,
      planTier: PlanTierX.fromApiValue(json['planTier'] as String),
      subscriptionStatus: SubscriptionStatus.values.firstWhere(
            (s) => s.apiValue == json['subscriptionStatus'],
        orElse: () => SubscriptionStatus.trialing,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
    'logoUrl': logoUrl,
    'ownerId': ownerId,
    'planTier': planTier.apiValue,
    'subscriptionStatus': subscriptionStatus.apiValue,
    'createdAt': createdAt.toIso8601String(),
  };
}

/// Payload sent to the backend when creating a new organization.
/// (ownerId is derived server-side from the authenticated user;
/// subscriptionStatus defaults to TRIALING and isn't user-selectable.)
class CreateOrganizationRequest {
  final String name;
  final String slug;
  final String? logoUrl;
  final PlanTier planTier;

  const CreateOrganizationRequest({
    required this.name,
    required this.slug,
    required this.planTier,
    this.logoUrl,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'slug': slug,
    'logoUrl': logoUrl,
    'planTier': planTier.apiValue,
  };
}

enum SlugStatus { idle, checking, available, taken, invalid }

class CreateOrganizationProvider extends ChangeNotifier {
  CreateOrganizationProvider({OrganizationRepository? repository})
      : _repository = repository ?? MockOrganizationRepository();

  final OrganizationRepository _repository;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController slugController = TextEditingController();

  File? logoFile;
  PlanTier selectedPlan = PlanTier.free;

  final ImagePicker _imagePicker = ImagePicker();

  bool _slugEditedManually = false;
  SlugStatus slugStatus = SlugStatus.idle;
  Timer? _debounce;

  bool isSubmitting = false;
  String? submitError;

  static final RegExp _slugPattern = RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$');

  /// Call on every keystroke of the name field.
  void onNameChanged(String value) {
    if (!_slugEditedManually) {
      final generated = _slugify(value);
      slugController.value = TextEditingValue(
        text: generated,
        selection: TextSelection.collapsed(offset: generated.length),
      );
      _scheduleSlugCheck(generated);
    }
    notifyListeners();
  }

  /// Call whenever the user edits the slug field directly.
  void onSlugChanged(String value) {
    _slugEditedManually = true;
    final normalized = _slugify(value);
    if (normalized != value) {
      slugController.value = TextEditingValue(
        text: normalized,
        selection: TextSelection.collapsed(offset: normalized.length),
      );
    }
    _scheduleSlugCheck(normalized);
  }

  void selectPlan(PlanTier tier) {
    selectedPlan = tier;
    notifyListeners();
  }

  /// Opens the phone gallery and lets the user pick a logo image.
  Future<void> pickLogoFromGallery() async {
    final picked = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1024,
      maxHeight: 1024,
    );
    if (picked == null) return;

    logoFile = File(picked.path);
    notifyListeners();
  }

  void clearLogo() {
    logoFile = null;
    notifyListeners();
  }

  void _scheduleSlugCheck(String slug) {
    _debounce?.cancel();

    if (slug.isEmpty) {
      slugStatus = SlugStatus.idle;
      notifyListeners();
      return;
    }

    if (!_slugPattern.hasMatch(slug)) {
      slugStatus = SlugStatus.invalid;
      notifyListeners();
      return;
    }

    slugStatus = SlugStatus.checking;
    notifyListeners();

    _debounce = Timer(const Duration(milliseconds: 450), () async {
      final available = await _repository.isSlugAvailable(slug);
      if (slugController.text != slug) return; // stale check, ignore
      slugStatus = available ? SlugStatus.available : SlugStatus.taken;
      notifyListeners();
    });
  }

  String _slugify(String input) {
    final lower = input.trim().toLowerCase();
    final replaced = lower.replaceAll(RegExp(r'[^a-z0-9]+'), '-');
    return replaced.replaceAll(RegExp(r'^-+|-+$'), '');
  }

  bool get canSubmit =>
      nameController.text.trim().length >= 2 &&
          slugStatus != SlugStatus.taken &&
          slugStatus != SlugStatus.invalid &&
          slugController.text.isNotEmpty &&
          !isSubmitting;

  Future<Organization?> submit() async {
    if (!canSubmit) return null;

    isSubmitting = true;
    submitError = null;
    notifyListeners();

    try {
      String? uploadedLogoUrl;
      if (logoFile != null) {
        uploadedLogoUrl = await _repository.uploadLogo(logoFile!);
      }

      final org = await _repository.createOrganization(
        CreateOrganizationRequest(
          name: nameController.text.trim(),
          slug: slugController.text.trim(),
          logoUrl: uploadedLogoUrl,
          planTier: selectedPlan,
        ),
      );
      isSubmitting = false;
      notifyListeners();
      return org;
    } catch (e) {
      isSubmitting = false;
      submitError = e is OrganizationSlugTakenException
          ? 'That slug was just taken — try another.'
          : 'Something went wrong. Please try again.';
      notifyListeners();
      return null;
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    nameController.dispose();
    slugController.dispose();
    super.dispose();
  }
}