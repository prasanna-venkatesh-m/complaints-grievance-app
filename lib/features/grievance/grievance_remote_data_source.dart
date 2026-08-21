import 'package:tvk_grievance/core/network/api_client.dart';

import 'grievance_model.dart';

class GrievanceRemoteDataSource {
  final ApiClient apiClient;

  GrievanceRemoteDataSource(
    this.apiClient,
  );

  static const String _latestGrievancePath =
      '/grievance/latest';

  static const String _wardPath = '/ward';

  static const String _blobSasPath =
      '/blob/sas';

  static const String _createGrievancePath =
      '/grievance';

  // ============================================================
  // GET LATEST GRIEVANCES
  // ============================================================

  Future<GrievanceLatestResponse>
      getLatestGrievances({
    required String userId,
  }) async {
    try {
      final response =
          await apiClient.get<
              Map<String, dynamic>>(
        _latestGrievancePath,
        queryParameters: {
          'userId': userId,
        },
      );

      final data = response.data;

      if (data == null) {
        throw const GrievanceApiException(
          'The server returned an empty response.',
        );
      }

      return GrievanceLatestResponse
          .fromJson(data);
    } catch (error) {
      if (error
          is GrievanceApiException) {
        rethrow;
      }

      throw const GrievanceApiException(
        'Unable to load grievances.',
      );
    }
  }

  // ============================================================
  // GET WARDS
  // ============================================================

  Future<List<WardModel>> getWards() async {
    try {
      final response =
          await apiClient.get<
              Map<String, dynamic>>(
        _wardPath,
      );

      final data = response.data;

      if (data == null) {
        throw const GrievanceApiException(
          'The server returned an empty response.',
        );
      }

      final rawData = data['data'];

      if (rawData is! List) {
        return const [];
      }

      return rawData
          .whereType<Map>()
          .map(
            (item) => WardModel.fromJson(
              Map<String, dynamic>.from(
                item,
              ),
            ),
          )
          .where(
            (ward) => ward.isActive,
          )
          .toList();
    } catch (error) {
      if (error
          is GrievanceApiException) {
        rethrow;
      }

      throw const GrievanceApiException(
        'Unable to load wards.',
      );
    }
  }

  // ============================================================
  // GET BLOB SAS
  // ============================================================

  Future<String> getBlobSas() async {
    try {
      final response =
          await apiClient.get<
              Map<String, dynamic>>(
        _blobSasPath,
      );

      final data = response.data;

      if (data == null) {
        throw const GrievanceApiException(
          'The server returned an empty response.',
        );
      }

      final sas = data['data'];

      if (sas == null ||
          sas.toString().isEmpty) {
        throw const GrievanceApiException(
          'Unable to generate upload permission.',
        );
      }

      return sas.toString();
    } catch (error) {
      if (error
          is GrievanceApiException) {
        rethrow;
      }

      throw const GrievanceApiException(
        'Unable to generate upload permission.',
      );
    }
  }

  // ============================================================
  // POST GRIEVANCE
  // ============================================================

  Future<void> createGrievance({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response =
          await apiClient.post<
              Map<String, dynamic>>(
        _createGrievancePath,
        data: data,
      );

      if (response.data == null) {
        throw const GrievanceApiException(
          'The server returned an empty response.',
        );
      }
    } catch (error) {
      if (error
          is GrievanceApiException) {
        rethrow;
      }

      throw const GrievanceApiException(
        'Unable to submit grievance. Please try again.',
      );
    }
  }
}

class GrievanceApiException
    implements Exception {
  final String message;

  const GrievanceApiException(
    this.message,
  );

  @override
  String toString() => message;
}