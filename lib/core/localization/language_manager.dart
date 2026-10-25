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

  static bool isArabic(BuildContext context) =>
      context.locale.languageCode == AppConstants.arabicLocaleCode;

  static bool isRtl(BuildContext context) => isArabic(context);

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
