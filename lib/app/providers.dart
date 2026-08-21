import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tvk_grievance/core/network/api_client.dart';
import 'package:tvk_grievance/core/network/dio_provider.dart';

import '../core/services/language_storage.dart';
import '../shared/enums/app_language.dart';

final languageStorageProvider = Provider<LanguageStorage>((ref) {
  throw UnimplementedError(
    'languageStorageProvider must be overridden in main.dart',
  );
});

final languageProvider =
    NotifierProvider<LanguageNotifier, AppLanguage>(
  LanguageNotifier.new,
);

class LanguageNotifier extends Notifier<AppLanguage> {
  @override
  AppLanguage build() {
    final storage = ref.read(languageStorageProvider);

    final savedCode = storage.getLanguageCode();

    return AppLanguage.fromCode(savedCode);
  }

  Future<void> setLanguage(AppLanguage language) async {
    if (state == language) {
      return;
    }

    // Update UI immediately.
    state = language;

    // Persist the new selection.
    final storage = ref.read(languageStorageProvider);

    await storage.saveLanguageCode(language.code);
  }

  Future<void> setEnglish() {
    return setLanguage(AppLanguage.english);
  }

  Future<void> setTamil() {
    return setLanguage(AppLanguage.tamil);
  }
}

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(
    ref.watch(dioProvider),
  );
});