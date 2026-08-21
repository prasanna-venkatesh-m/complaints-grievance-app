import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../app/providers.dart';
import 'helpdesk_controller.dart';
import 'helpdesk_remote_datasource.dart';
import 'helpdesk_repository.dart';

final helpdeskRemoteDataSourceProvider =
    Provider<HelpdeskRemoteDataSource>((ref) {
  return HelpdeskRemoteDataSource(
    ref.watch(apiClientProvider),
  );
});

final helpdeskRepositoryProvider =
    Provider<HelpdeskRepository>((ref) {
  return HelpdeskRepository(
    ref.watch(helpdeskRemoteDataSourceProvider),
  );
});

final helpdeskControllerProvider =
    ChangeNotifierProvider<HelpdeskController>((ref) {
  return HelpdeskController(
    ref.watch(helpdeskRepositoryProvider),
  );
});