import 'package:flutter/material.dart';
import 'package:starterapp/l10n/l10n.dart';
import 'package:starterapp/repository/local_storage/settings/preferences_local_storage.dart';

class LocaleServiceProvider with ChangeNotifier {
  Locale? _locale;
  Locale? get locale => _locale;
  PreferenceLocalStorage preferenceLocalStorage = PreferenceLocalStorage();

  Future<void> initLocale(context) async {
    if (await preferenceLocalStorage.isSetLanguagePreferences()) {
      String languageCode =
          await preferenceLocalStorage.getLanguagePreferences();
      if (languageCode.isNotEmpty) {
        setLocale(Locale(languageCode));
      }
      return;
    }
    _locale = Locale(Localizations.localeOf(context).languageCode);
  }

  void setLocale(Locale loc) async {
    await preferenceLocalStorage.setLanguagePreferences(loc.languageCode);
    if (!L10n.allLanguagesSupported.contains(loc)) return;
    _locale = loc;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
