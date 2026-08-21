import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../app/providers.dart';
import 'home_controller.dart';
import 'home_remote_data_source.dart';
import 'home_repository.dart';

final homeRemoteDataSourceProvider =
    Provider<HomeRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);

  return HomeRemoteDataSource(apiClient);
});

final homeRepositoryProvider =
    Provider<HomeRepository>((ref) {
  final remoteDataSource =
      ref.watch(homeRemoteDataSourceProvider);

  return HomeRepository(remoteDataSource);
});

final homeControllerProvider =
    ChangeNotifierProvider<HomeController>((ref) {
  final repository =
      ref.watch(homeRepositoryProvider);

  return HomeController(repository);
});