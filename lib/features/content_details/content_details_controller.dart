import 'package:dio/dio.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tvk_grievance/features/home/home_model.dart';

import 'content_details_repository.dart';

class ContentDetailsController extends StateNotifier<ContentDetailsState> {
  final ContentDetailsRepository repository;

  ContentDetailsController({
    required this.repository,
  }) : super(const ContentDetailsState());

  Future<void> loadContent(
    String contentId,
  ) async {
    if (contentId.trim().isEmpty) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Invalid content.',
      );
      return;
    }

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      final content =
          await repository.getContentById(
        contentId,
      );

      state = state.copyWith(
        isLoading: false,
        content: content,
        errorMessage: null,
      );
    } on DioException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getDioErrorMessage(e),
      );
    } on FormatException {
      state = state.copyWith(
        isLoading: false,
        errorMessage:
            'Unable to read the content. Please try again.',
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage:
            'Unable to load this content. Please try again.',
      );
    }
  }

  Future<void> refreshContent(
    String contentId,
  ) async {
    await loadContent(contentId);
  }

  String _getDioErrorMessage(
    DioException error,
  ) {
    final statusCode = error.response?.statusCode;

    if (statusCode == 404) {
      return 'Content not found.';
    }

    if (statusCode == 401 ||
        statusCode == 403) {
      return 'You are not authorized to view this content.';
    }

    if (statusCode != null &&
        statusCode >= 500) {
      return 'Server error. Please try again later.';
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please try again.';

      case DioExceptionType.connectionError:
        return 'Unable to connect to the server. Please check your internet connection.';

      default:
        return 'Unable to load this content. Please try again.';
    }
  }
}

class ContentDetailsState {
  final bool isLoading;
  final Content? content;
  final String? errorMessage;

  const ContentDetailsState({
    this.isLoading = false,
    this.content,
    this.errorMessage,
  });

  bool get hasContent => content != null;

  bool get hasError =>
      errorMessage != null &&
      errorMessage!.isNotEmpty;

  ContentDetailsState copyWith({
    bool? isLoading,
    Content? content,
    String? errorMessage,
    bool clearContent = false,
    bool clearError = false,
  }) {
    return ContentDetailsState(
      isLoading: isLoading ?? this.isLoading,
      content:
          clearContent ? null : content ?? this.content,
      errorMessage: clearError
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }
}