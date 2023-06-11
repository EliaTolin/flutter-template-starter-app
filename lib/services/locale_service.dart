import 'package:flutter/material.dart';
import 'package:starterapp/constants/shared_pref_keys/settings/app_settings_keys.dart';
import 'package:starterapp/helper/shared_pref_helper.dart';
import 'package:starterapp/l10n/l10n.dart';

class LocaleProvider with ChangeNotifier {
  Locale? _locale;
  Locale? get locale => _locale;

  Future<void> initLocale(context) async {
    SharedPrefHelper sharedPrefHelper = SharedPrefHelper();
    if (await sharedPrefHelper.exist(AppSettingsKeys.languagePreferencesKey)) {
      String languageCode =
          await sharedPrefHelper.read(AppSettingsKeys.languagePreferencesKey);
      if (languageCode.isNotEmpty) {
        setLocale(Locale(languageCode));
      }
      return;
    }
    _locale = Locale(Localizations.localeOf(context).languageCode);
  }

  void setLocale(Locale loc) {
    SharedPrefHelper sharedPrefHelper = SharedPrefHelper();
    sharedPrefHelper.save(
        AppSettingsKeys.languagePreferencesKey, loc.languageCode);
    if (!L10n.allLanguagesSupported.contains(loc)) return;
    _locale = loc;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
