import 'package:flutter/material.dart';

import '../constants.dart';
import '../datasource/shared_preference.dart';

class LocalizationProvider extends ChangeNotifier {
  Locale _appLocale = Locale(LANG_EN);

  /// Get current Locale supported
  Locale get appLocal => _appLocale;

  String get currentLanguage => appLocal.languageCode;

  fetchLocale() async {
    var prefs = await SpUtil.getInstance();

    /// check if the application is first start or not
    if (prefs.getBool(KEY_FIRST_START) == null) {
      /// set first start is true
      await prefs.putBool(KEY_FIRST_START, true);
    }
    if (prefs.getString(KEY_LANGUAGE) == null) {
      _appLocale = Locale(LANG_AR);
      await prefs.putString(KEY_LANGUAGE, LANG_AR);
      return Null;
    }
    _appLocale = Locale(prefs.getString(KEY_LANGUAGE));
    return Null;
  }

  Future<void> changeLanguage(Locale type, BuildContext context) async {
    var prefs = await SpUtil.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale(LANG_AR)) {
      _appLocale = Locale(LANG_AR);
      await prefs.putString(KEY_LANGUAGE, LANG_AR);
    } else {
      _appLocale = Locale(LANG_EN);
      await prefs.putString(KEY_LANGUAGE, LANG_EN);
    }
    notifyListeners();
  }
}
