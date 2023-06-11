class LanguageLocalHelper {
  static final Map<String, Map<String, String>> isoLangs = {
    "fr": {"name": "French", "nativeName": "Français"},
    "it": {"name": "Italian", "nativeName": "Italiano"},
    "en": {"name": "English", "nativeName": "English"},
    "es": {"name": "Spanish", "nativeName": "Español"},
    "pl": {"name": "Polish", "nativeName": "Polski"},
    "pt": {"name": "Portuguese", "nativeName": "Português"},
    "de": {"name": "German", "nativeName": "Deutsch"},
  };

  Map<String, Map<String, String>> getIsoLangs() => isoLangs;

  getDisplayLanguage(key) {
    if (isoLangs.containsKey(key)) {
      return isoLangs[key];
    } else {
      throw Exception("Language key incorrect");
    }
  }

  getNativeLanguageName(countryCode) {
    return getDisplayLanguage(countryCode)["nativeName"];
  }

  getLanguageName(countryCode) {
    return getDisplayLanguage(countryCode)["name"];
  }
}