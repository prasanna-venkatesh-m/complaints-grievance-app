import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../app/providers.dart';
import 'home_controller.dart';
import 'home_remote_data_source.dart';
import 'home_repository.dart';

final homeRemoteDataSourceProvider =
    Provider<HomeRemoteDataSource>((ref) {
  debugPrint(
    'HOME PROVIDER: Creating HomeRemoteDataSource',
  );

  final apiClient = ref.read(
    apiClientProvider,
  );

  debugPrint(
    'HOME PROVIDER: apiClient obtained',
  );

  return HomeRemoteDataSource(
    apiClient,
  );
});

final homeRepositoryProvider =
    Provider<HomeRepository>((ref) {
  debugPrint(
    'HOME PROVIDER: Creating HomeRepository',
  );

  final remoteDataSource = ref.read(
    homeRemoteDataSourceProvider,
  );

  debugPrint(
    'HOME PROVIDER: remoteDataSource obtained',
  );

  return HomeRepository(
    remoteDataSource,
  );
});

final homeControllerProvider =
    ChangeNotifierProvider<HomeController>((ref) {
  debugPrint(
    'HOME PROVIDER: Creating HomeController',
  );

  final repository = ref.read(
    homeRepositoryProvider,
  );

  debugPrint(
    'HOME PROVIDER: repository obtained',
  );

  final controller = HomeController(
    repository,
  );

  debugPrint(
    'HOME PROVIDER: HomeController CREATED',
  );

  return controller;
});