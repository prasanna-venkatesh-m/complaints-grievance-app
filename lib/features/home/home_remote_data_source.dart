import 'package:dio/dio.dart';
import 'package:tvk_grievance/core/network/api_client.dart';

import 'home_model.dart';

class HomeRemoteDataSource {
  final ApiClient apiClient;

  HomeRemoteDataSource(this.apiClient);

  Future<List<Alert>> getActiveAlerts() async {
    try {
      final Response<dynamic> response = await apiClient.get<dynamic>(
        'alert',
      );

      final data = response.data;

      if (data is! Map) {
        throw const HomeApiException(
          'Invalid alert response.',
        );
      }

      final rawData = data['data'];

      if (rawData is! List) {
        return const [];
      }

      return rawData
          .whereType<Map>()
          .map(
            (item) => Alert.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .where((alert) => alert.isCurrentlyActive)
          .toList();
    } on DioException catch (error) {
      throw HomeApiException(
        _mapDioError(error),
      );
    } on HomeApiException {
      rethrow;
    } catch (_) {
      throw const HomeApiException(
        'Unable to load alerts.',
      );
    }
  }

  Future<List<Content>> getLatestContents({
    int limit = 5,
  }) async {
    try {
      final Response<dynamic> response =
          await apiClient.get<dynamic>(
        'content/latest',
        queryParameters: {
          'limit': limit,
        },
      );

      final data = response.data;

      if (data is! Map) {
        throw const HomeApiException(
          'Invalid latest content response.',
        );
      }

      final rawData = data['data'];

      if (rawData is! List) {
        return const [];
      }

      return rawData
          .whereType<Map>()
          .map(
            (item) => Content.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList();
    } on DioException catch (error) {
      throw HomeApiException(
        _mapDioError(error),
      );
    } on HomeApiException {
      rethrow;
    } catch (_) {
      throw const HomeApiException(
        'Unable to load latest updates.',
      );
    }
  }

  String _mapDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timed out. Please check your internet connection.';

      case DioExceptionType.sendTimeout:
        return 'Request timed out. Please try again.';

      case DioExceptionType.receiveTimeout:
        return 'Server took too long to respond. Please try again.';

      case DioExceptionType.connectionError:
        return 'Unable to connect to the server. Please check your internet connection.';

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;

        if (statusCode != null && statusCode >= 500) {
          return 'Server error. Please try again later.';
        }

        if (statusCode == 401 || statusCode == 403) {
          return 'You are not authorized to access this information.';
        }

        if (statusCode == 404) {
          return 'The requested information was not found.';
        }

        return 'Unable to load information from the server.';

      case DioExceptionType.cancel:
        return 'Request was cancelled.';

      case DioExceptionType.badCertificate:
        return 'Secure connection could not be established.';

      case DioExceptionType.unknown:
        return 'Something went wrong while connecting to the server.';

      case DioExceptionType.transformTimeout:
        return 'The server response took too long to process.';
    }
  }
}

class HomeApiException implements Exception {
  final String message;

  const HomeApiException(this.message);

  @override
  String toString() => message;
}