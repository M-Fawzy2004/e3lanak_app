import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/constants/app_constants.dart';
import 'core/di/injection_container.dart' as di;
import 'core/localization/language_manager.dart';
import 'core/routes/app_router.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialize Localization engine
  await EasyLocalization.ensureInitialized();

  // 2. Initialize Supabase Backend
  try {
    await Supabase.initialize(
      url: AppConstants.supabaseUrl,
      publishableKey: AppConstants.supabasePublishableKey,
    );
  } catch (error) {
    debugPrint('Supabase initialization notice: $error');
  }

  // 3. Initialize Service Locator (Dependency Injection)
  await di.init();

  runApp(
    EasyLocalization(
      supportedLocales: LanguageManager.supportedLocales,
      path: AppConstants.translationsPath,
      fallbackLocale: LanguageManager.arabicLocale,
      startLocale: LanguageManager.arabicLocale,
      child: const E3lanakApp(),
    ),
  );
}

/// Root Application Widget with ScreenUtil responsiveness, dynamic localization, and theme management.
class E3lanakApp extends StatelessWidget {
  const E3lanakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(AppConstants.designWidth, AppConstants.designHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme(context.locale),
          darkTheme: AppTheme.darkTheme(context.locale),
          themeMode: ThemeMode.system,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          builder: (context, widget) {
            return Directionality(
              textDirection: LanguageManager.isRtl(context)
                  ? ui.TextDirection.rtl
                  : ui.TextDirection.ltr,
              child: widget ?? const SizedBox.shrink(),
            );
          },
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}
