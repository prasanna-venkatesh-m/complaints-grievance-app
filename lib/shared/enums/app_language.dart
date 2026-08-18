import 'package:flutter/material.dart';

enum AppLanguage {
  english(
    locale: Locale('en'),
    label: 'English',
  ),

  tamil(
    locale: Locale('ta'),
    label: 'தமிழ்',
  );

  const AppLanguage({
    required this.locale,
    required this.label,
  });

  final Locale locale;
  final String label;

  String get code => locale.languageCode;

  static AppLanguage fromCode(String? code) {
    return AppLanguage.values.firstWhere(
      (language) => language.code == code,
      orElse: () => AppLanguage.english,
    );
  }
}