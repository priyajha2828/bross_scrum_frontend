import 'dart:io';
import 'package:BrossScrum/config/api_constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../../services/dio_client.dart';
import '../../../providers/organization_provider/create_organization_provider.dart';
import '../../../pages/organization_page/create_organization/organization_repository.dart';
import '../providers/organization_provider/organization_provider.dart';

class OrganizationApiRepository implements OrganizationRepository {
  final Dio _dio = DioClient.dio;

  @override
  Future<Organization> createOrganization(
      CreateOrganizationRequest request) async {
    try {
      final response = await _dio.post(
        ApiConstant.createorg,
        data: request.toJson(),
      );
      debugPrint('Inside create organization');
      debugPrint(response.data.toString());


      return Organization.fromJson(response.data["data"]);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to create organization",
      );
    }
  }

  Future<List<OrganizationSummary>> getOrganizations() async {
    try {
      final response = await _dio.get(ApiConstant.getOrganization);
      debugPrint(response.data.toString());

      return (response.data["data"] as List)
          .map(
            (e) => OrganizationSummary.fromJson(
          e as Map<String, dynamic>,
        ),
      )
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to load organizations",
      );
    }
  }

  @override
  Future<bool> isSlugAvailable(String slug) async {
    try {
      final response = await _dio.get(
        "/organizations/check-slug/$slug",
      );

      return response.data["data"]["available"];
    } on DioException {
      return false;
    }
  }

  @override
  Future<String> uploadLogo(File file) async {
    try {
      final formData = FormData.fromMap({
        "logo": await MultipartFile.fromFile(file.path),
      });

      final response = await _dio.post(
        "/organizations/upload-logo",
        data: formData,
      );

      return response.data["data"]["url"];
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Logo upload failed",
      );
    }
  }
}