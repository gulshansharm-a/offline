import 'package:shared_preferences/shared_preferences.dart';

import 'language_model.dart';

class LanguageManager {
  static const String kLanguageCodeKey = 'languageCode';
  static const String kCountryCodeKey = 'countryCode';

  static Future<LanguageModel> getSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString(kLanguageCodeKey) ?? 'en';
    String countryCode = prefs.getString(kCountryCodeKey) ?? 'US';

    return LanguageModel(
      languageCode: languageCode,
      countryCode: countryCode,
      languageName: '',
    );
  }

  static Future<void> setSelectedLanguage(LanguageModel language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(kLanguageCodeKey, language.languageCode);
    await prefs.setString(kCountryCodeKey, language.countryCode);
  }
}
