import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/localization/locale_keys.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await Future.wait<void>([
      Future<void>.delayed(const Duration(milliseconds: 2500)),
      _verifySession(),
    ]);

    if (!mounted) return;
    _navigate();
  }

  Future<void> _verifySession() async {
    try {
      _isAuthenticated =
          Supabase.instance.client.auth.currentSession != null;
    } catch (_) {
      _isAuthenticated = false;
    }
  }

  void _navigate() {
    final destination =
        _isAuthenticated ? AppRoutes.home : AppRoutes.onboarding;
    Navigator.of(context).pushReplacementNamed(destination);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashGradientBottom,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.splashGradient),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/splash_logo.png',
                    width: 270.w,
                    fit: BoxFit.contain,
                  )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .scale(
                        begin: const Offset(0.88, 0.88),
                        end: const Offset(1, 1),
                        curve: Curves.easeOutCubic,
                      ),
                  SizedBox(height: 28.h),
                  Text(
                    tr(LocaleKeys.splashSlogan),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.tajawal(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white.withValues(alpha: 0.9),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 350.ms, duration: 500.ms)
                      .slideY(begin: 0.15, end: 0),
                ],
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 48.h),
                child: SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppColors.white.withValues(alpha: 0.7),
                  ),
                )
                    .animate()
                    .fadeIn(delay: 600.ms, duration: 400.ms),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
