import 'package:flutter/material.dart';
import '../localization/language_manager.dart';

/// Ergonomic BuildContext extensions for Clean Architecture presentation code.
extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  bool get isArabic => LanguageManager.isArabic(this);
  bool get isRtl => LanguageManager.isRtl(this);

  double get screenHeight => MediaQuery.sizeOf(this).height;
  double get screenWidth => MediaQuery.sizeOf(this).width;
}
