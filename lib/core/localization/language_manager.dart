import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/app_constants.dart';

abstract final class LanguageManager {
  static const Locale arabicLocale = Locale(AppConstants.arabicLocaleCode);
  static const Locale englishLocale = Locale(AppConstants.englishLocaleCode);

  static const List<Locale> supportedLocales = [
    arabicLocale,
    englishLocale,
  ];

  // Keep locale-specific behavior here so UI and routing code do not need
  // to know how a locale maps to its language direction.
  static const Set<String> _rightToLeftLanguageCodes = {
    'ar', 'fa', 'he', 'ur', 'ps', 'sd', 'ug', 'yi', 'dv', 'ku', 'ckb',
  };

  static bool isArabicLocale(Locale locale) =>
      locale.languageCode == arabicLocale.languageCode;

  static bool isRtlLocale(Locale locale) =>
      _rightToLeftLanguageCodes.contains(locale.languageCode);

  static bool isArabic(BuildContext context) => isArabicLocale(context.locale);

  static bool isRtl(BuildContext context) => isRtlLocale(context.locale);

  static Future<void> toggleLanguage(BuildContext context) async {
    if (isArabic(context)) {
      await context.setLocale(englishLocale);
    } else {
      await context.setLocale(arabicLocale);
    }
  }

  static Future<void> setLocale(BuildContext context, Locale locale) async {
    await context.setLocale(locale);
  }
}
