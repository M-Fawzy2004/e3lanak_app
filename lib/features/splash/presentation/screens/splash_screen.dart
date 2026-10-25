import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/brand_loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    unawaited(_bootstrap());
  }

  Future<void> _bootstrap() async {
    final destination = _resolveDestination();
    await Future<void>.delayed(const Duration(milliseconds: 2500));

    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(destination);
  }

  String _resolveDestination() {
    try {
      return Supabase.instance.client.auth.currentSession == null
          ? AppRoutes.onboarding
          : AppRoutes.home;
    } catch (_) {
      return AppRoutes.onboarding;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.splashGradientBottom,
        resizeToAvoidBottomInset: false,
        body: DecoratedBox(
          decoration: const BoxDecoration(gradient: AppColors.splashGradient),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child:
                        Image.asset(
                              'assets/images/splash_logo.png',
                              width: 270.w,
                              fit: BoxFit.contain,
                              excludeFromSemantics: true,
                            )
                            .animate()
                            .fadeIn(duration: 600.ms)
                            .scale(
                              begin: const Offset(0.88, 0.88),
                              end: const Offset(1, 1),
                              curve: Curves.easeOutCubic,
                            ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 48.h),
                  child: BrandLoadingIndicator(size: 56.w)
                      .animate()
                      .fadeIn(delay: 600.ms, duration: 400.ms),
                ),
                SizedBox(height: 25.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
