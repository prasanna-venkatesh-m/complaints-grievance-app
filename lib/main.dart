import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'app/providers.dart';
import 'core/services/language_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(
      allowList: <String>{
        LanguageStorage.languageKey,
      },
    ),
  );

  final languageStorage = LanguageStorage(preferences);

  runApp(
    ProviderScope(
      overrides: [
        languageStorageProvider.overrideWithValue(languageStorage),
      ],
      child: const MainApp(),
    ),
  );
}