import 'dart:io';
import 'dart:math';
import '../../../providers/organization_provider/create_organization_provider.dart';
import '../../../providers/organization_provider/organization_provider.dart' hide Organization;
import 'organization_enums.dart';

abstract class OrganizationRepository {
  Future<Organization> createOrganization(CreateOrganizationRequest request);

  /// Returns true if [slug] is not already taken.
  Future<bool> isSlugAvailable(String slug);

  /// Uploads the picked logo file and returns the resulting public URL.
  Future<String> uploadLogo(File file);
}

/// Mock implementation for local development / previewing the UI without
/// a backend. Replace with a real implementation that calls your API
/// (which in turn talks to Prisma) once the endpoint exists.
class MockOrganizationRepository implements OrganizationRepository {
  final Set<String> _takenSlugs = {'acme', 'kinetic-team', 'admin'};

  @override
  Future<bool> isSlugAvailable(String slug) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return !_takenSlugs.contains(slug.toLowerCase());
  }

  @override
  Future<Organization> createOrganization(
      CreateOrganizationRequest request) async {
    await Future.delayed(const Duration(seconds: 1));

    if (_takenSlugs.contains(request.slug.toLowerCase())) {
      throw OrganizationSlugTakenException(request.slug);
    }

    _takenSlugs.add(request.slug.toLowerCase());

    return Organization(
      id: _generateId(),
      name: request.name,
      slug: request.slug,
      logoUrl: request.logoUrl,
      ownerId: 'current-user-id',
      planTier: request.planTier,
      subscriptionStatus: SubscriptionStatus.trialing,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<String> uploadLogo(File file) async {
    // Simulates uploading to storage (e.g. S3 / Supabase / Cloudinary).
    // Replace with a real multipart upload once the endpoint exists.
    await Future.delayed(const Duration(milliseconds: 800));
    final fileName = file.path.split(Platform.pathSeparator).last;
    return 'https://cdn.kinetic.app/logos/$fileName';
  }

  String _generateId() {
    final rand = Random();
    return List.generate(8, (_) => rand.nextInt(16).toRadixString(16)).join();
  }
}

class OrganizationSlugTakenException implements Exception {
  final String slug;
  OrganizationSlugTakenException(this.slug);

  @override
  String toString() => 'The slug "$slug" is already taken.';
}