import 'grievance_model.dart';
import 'grievance_remote_data_source.dart';

class GrievanceRepository {
  final GrievanceRemoteDataSource remoteDataSource;

  GrievanceRepository(
    this.remoteDataSource,
  );

  // ============================================================
  // GET LATEST GRIEVANCES
  // ============================================================

  Future<GrievanceLatestResponse>
      getLatestGrievances({
    required String userId,
  }) async {
    try {
      return await remoteDataSource
          .getLatestGrievances(
        userId: userId,
      );
    } on GrievanceApiException {
      rethrow;
    } catch (_) {
      throw const GrievanceRepositoryException(
        'Unable to load grievances.',
      );
    }
  }

  // ============================================================
  // GET WARDS
  // ============================================================

  Future<List<WardModel>> getWards() async {
    try {
      return await remoteDataSource
          .getWards();
    } on GrievanceApiException {
      rethrow;
    } catch (_) {
      throw const GrievanceRepositoryException(
        'Unable to load wards.',
      );
    }
  }

  // ============================================================
  // GET BLOB SAS
  // ============================================================

  Future<String> getBlobSas() async {
    try {
      return await remoteDataSource
          .getBlobSas();
    } on GrievanceApiException {
      rethrow;
    } catch (_) {
      throw const GrievanceRepositoryException(
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
      await remoteDataSource.createGrievance(
        data: data,
      );
    } on GrievanceApiException {
      rethrow;
    } catch (_) {
      throw const GrievanceRepositoryException(
        'Unable to submit grievance.',
      );
    }
  }
}

class GrievanceRepositoryException
    implements Exception {
  final String message;

  const GrievanceRepositoryException(
    this.message,
  );

  @override
  String toString() => message;
}