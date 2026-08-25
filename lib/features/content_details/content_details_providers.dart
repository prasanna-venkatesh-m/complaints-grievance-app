import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tvk_grievance/app/providers.dart';

import 'content_details_controller.dart';
import 'content_details_remote_data_source.dart';
import 'content_details_repository.dart';

final contentDetailsRemoteDataSourceProvider =
    Provider<ContentDetailsRemoteDataSource>((ref) {
  final apiClient = ref.read(
    apiClientProvider,
  );

  return ContentDetailsRemoteDataSource(
    apiClient: apiClient,
  );
});

final contentDetailsRepositoryProvider =
    Provider<ContentDetailsRepository>((ref) {
  final remoteDataSource = ref.read(
    contentDetailsRemoteDataSourceProvider,
  );

  return ContentDetailsRepository(
    remoteDataSource: remoteDataSource,
  );
});

final contentDetailsControllerProvider =
    StateNotifierProvider<
        ContentDetailsController,
        ContentDetailsState>(
  (ref) {
    final repository = ref.read(
      contentDetailsRepositoryProvider,
    );

    return ContentDetailsController(
      repository: repository,
    );
  },
);