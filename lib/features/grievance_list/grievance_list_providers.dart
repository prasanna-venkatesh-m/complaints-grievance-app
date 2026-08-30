import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tvk_grievance/app/providers.dart';
import 'package:tvk_grievance/features/grievance_list/grievance_list_controller.dart';
import 'package:tvk_grievance/features/grievance_list/grievance_list_remote_data_source.dart';
import 'package:tvk_grievance/features/grievance_list/grievance_list_repository.dart';

final grievanceListRemoteDataSourceProvider =
    Provider<GrievanceListRemoteDataSource>((ref) {
  final apiClient = ref.read(apiClientProvider);

  return GrievanceListRemoteDataSource(
    apiClient: apiClient,
  );
});

final grievanceListRepositoryProvider =
    Provider<GrievanceListRepository>((ref) {
  final remoteDataSource =
      ref.read(grievanceListRemoteDataSourceProvider);

  return GrievanceListRepository(
    remoteDataSource: remoteDataSource,
  );
});

final grievanceListControllerProvider =
    ChangeNotifierProvider<GrievanceListController>((ref) {
  final repository =
      ref.read(grievanceListRepositoryProvider);

  return GrievanceListController(
    repository: repository,
  );
});
