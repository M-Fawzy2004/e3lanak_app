import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:e3lanak_app/core/constants/app_constants.dart';
import 'package:e3lanak_app/core/theme/app_colors.dart';
import 'package:e3lanak_app/core/localization/language_manager.dart';
import 'package:e3lanak_app/core/errors/failures.dart';

void main() {
  group('Bootstrap & Core Configuration Tests', () {
    test('AppConstants contains expected baseline configuration', () {
      expect(AppConstants.appName, 'E3lanak');
      expect(AppConstants.designWidth, 390.0);
      expect(AppConstants.designHeight, 844.0);
      expect(AppConstants.arabicLocaleCode, 'ar');
      expect(AppConstants.englishLocaleCode, 'en');
    });

    test('AppColors tokens define Royal Blue, Accent Yellow, and Deep Slate Black', () {
      expect(AppColors.primary, const Color(0xFF0D5EF4));
      expect(AppColors.primaryDark, const Color(0xFF0946C2));
      expect(AppColors.secondary, const Color(0xFFFFB800));
      expect(AppColors.accent, const Color(0xFFFFB800));
      expect(AppColors.darkNeutral, const Color(0xFF0F172A));
      expect(AppColors.textPrimary, const Color(0xFF0F172A));
      expect(AppColors.textSecondary, const Color(0xFF64748B));
      expect(AppColors.background, const Color(0xFFF8FAFC));
      expect(AppColors.border, const Color(0xFFE2E8F0));
      expect(AppColors.surface, Colors.white);
      expect(AppColors.darkBackground, const Color(0xFF0F172A));
      expect(AppColors.darkSurface, const Color(0xFF1E293B));
    });

    test('LanguageManager specifies Arabic as primary supported locale', () {
      expect(LanguageManager.arabicLocale, const Locale('ar'));
      expect(LanguageManager.englishLocale, const Locale('en'));
      expect(LanguageManager.supportedLocales.length, 2);
      expect(LanguageManager.supportedLocales.first, const Locale('ar'));
    });

    test('Failures support equality and custom messaging', () {
      const failure1 = ServerFailure(message: 'Server Error', statusCode: 500);
      const failure2 = ServerFailure(message: 'Server Error', statusCode: 500);
      const failure3 = ServerFailure(message: 'Other Error', statusCode: 400);

      expect(failure1, equals(failure2));
      expect(failure1 == failure3, isFalse);
    });
  });
}
