import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../features/ad_generator/presentation/screens/ad_step1_upload_screen.dart';
import '../../features/ad_generator/presentation/screens/ad_step2_details_screen.dart';
import '../../features/ad_generator/presentation/screens/ad_step3_category_screen.dart';
import '../../features/navigation/presentation/screens/main_navigation_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../localization/language_manager.dart';
import '../localization/locale_keys.dart';
import 'app_routes.dart';

abstract final class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final Widget screen = switch (settings.name) {
      AppRoutes.splash => const SplashScreen(),
      AppRoutes.onboarding => const OnboardingScreen(),
      AppRoutes.main => const MainNavigationScreen(),
      AppRoutes.home => const MainNavigationScreen(),
      AppRoutes.adGeneratorStep1 => const AdStep1UploadScreen(),
      AppRoutes.adGeneratorStep2 => const AdStep2DetailsScreen(),
      AppRoutes.adGeneratorStep3 => const AdStep3CategoryScreen(),
      _ => const _RouteNotFoundScreen(),
    };

    return PageRouteBuilder<dynamic>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: settings.name == AppRoutes.onboarding
          ? const Duration(milliseconds: 560)
          : const Duration(milliseconds: 300),
      reverseTransitionDuration: settings.name == AppRoutes.onboarding
          ? const Duration(milliseconds: 480)
          : const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        if (settings.name == AppRoutes.onboarding) {
          final isRtl = LanguageManager.isRtl(context);
          final beginOffset = isRtl ? const Offset(1, 0) : const Offset(-1, 0);
          final slideAnimation = animation.drive(
            Tween<Offset>(
              begin: beginOffset,
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeOutCubic)),
          );

          return SlideTransition(
            position: slideAnimation,
            child: FadeTransition(opacity: animation, child: child),
          );
        }

        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}

class _RouteNotFoundScreen extends StatelessWidget {
  const _RouteNotFoundScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          tr(LocaleKeys.pageNotFound),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
