import 'package:shared_preferences/shared_preferences.dart';

class LanguageStorage {
  LanguageStorage(this._preferences);

  static const String languageKey = 'app_language';

  final SharedPreferencesWithCache _preferences;

  String? getLanguageCode() {
    return _preferences.getString(languageKey);
  }

  Future<void> saveLanguageCode(String languageCode) async {
    await _preferences.setString(languageKey, languageCode);
  }
}