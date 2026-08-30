import 'package:flutter_riverpod/legacy.dart';
import 'package:tvk_grievance/features/content/content_repository.dart';
import 'package:tvk_grievance/features/home/home_model.dart';

class ContentListController extends StateNotifier<ContentListState> {
  final ContentRepository repository;

  ContentListController({
    required this.repository,
  }) : super(
          const ContentListState(),
        );

  Future<void> loadContents() async {
    if (state.isLoading) {
      return;
    }

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      final contents = await repository.getAllContents();

      state = state.copyWith(
        isLoading: false,
        contents: contents,
        errorMessage: null,
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getUserFriendlyError(error),
      );
    }
  }

  Future<void> refreshContents() async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      final contents = await repository.getAllContents();

      state = state.copyWith(
        isLoading: false,
        contents: contents,
        errorMessage: null,
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getUserFriendlyError(error),
      );
    }
  }

  String _getUserFriendlyError(Object error) {
    if (error is FormatException) {
      return 'Unable to load content. Please try again.';
    }

    return 'Something went wrong while loading content. Please try again.';
  }
}

class ContentListState {
  final bool isLoading;
  final List<Content> contents;
  final String? errorMessage;

  const ContentListState({
    this.isLoading = false,
    this.contents = const [],
    this.errorMessage,
  });

  ContentListState copyWith({
    bool? isLoading,
    List<Content>? contents,
    String? errorMessage,
  }) {
    return ContentListState(
      isLoading: isLoading ?? this.isLoading,
      contents: contents ?? this.contents,
      errorMessage: errorMessage,
    );
  }
}
