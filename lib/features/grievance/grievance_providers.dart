import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../app/providers.dart';
import 'grievance_controller.dart';
import 'grievance_remote_data_source.dart';
import 'grievance_repository.dart';

final grievanceRemoteDataSourceProvider =
    Provider<GrievanceRemoteDataSource>(
  (ref) {
    final apiClient =
        ref.watch(apiClientProvider);

    return GrievanceRemoteDataSource(
      apiClient,
    );
  },
);

final grievanceRepositoryProvider =
    Provider<GrievanceRepository>(
  (ref) {
    final remoteDataSource = ref.watch(
      grievanceRemoteDataSourceProvider,
    );

    return GrievanceRepository(
      remoteDataSource,
    );
  },
);

final grievanceControllerProvider =
    ChangeNotifierProvider<
        GrievanceController>(
  (ref) {
    final repository = ref.watch(
      grievanceRepositoryProvider,
    );

    return GrievanceController(
      repository,
    );
  },
);