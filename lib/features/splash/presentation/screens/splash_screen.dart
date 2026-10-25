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
      _isAuthenticated = Supabase.instance.client.auth.currentSession != null;
    } catch (_) {
      _isAuthenticated = false;
    }
  }

  void _navigate() {
    final destination = _isAuthenticated
        ? AppRoutes.home
        : AppRoutes.onboarding;
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
                ],
              ),
              const Spacer(),
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
    );
  }
}
