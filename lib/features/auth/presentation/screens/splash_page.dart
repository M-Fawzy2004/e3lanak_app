import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/localization/locale_keys.dart';
import '../../../../core/localization/language_manager.dart';

/// Cleanly styled splash and onboarding entry screen.
/// Adheres strictly to the Zero Hardcoded Strings policy.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.slate50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: () => LanguageManager.toggleLanguage(context),
            icon: Icon(
              Icons.language,
              size: 20.sp,
              color: AppColors.primary,
            ),
            label: Text(
              LanguageManager.isArabic(context) ? 'English' : 'العربية',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          SizedBox(width: 12.w),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),

              // Brand Icon Card
              Container(
                width: 96.w,
                height: 96.w,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.auto_awesome,
                    size: 48.sp,
                    color: AppColors.white,
                  ),
                ),
              )
                  .animate()
                  .scale(duration: 600.ms, curve: Curves.easeOutBack)
                  .fadeIn(duration: 400.ms),

              SizedBox(height: 24.h),

              // App Title (Translated)
              Text(
                tr(LocaleKeys.appTitle),
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.white : AppColors.slate900,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 500.ms)
                  .slideY(begin: 0.2, end: 0),

              SizedBox(height: 8.h),

              // App Tagline (Translated)
              Text(
                tr(LocaleKeys.appTagline),
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(delay: 350.ms, duration: 500.ms)
                  .slideY(begin: 0.2, end: 0),

              SizedBox(height: 12.h),

              // App Description (Translated)
              Text(
                tr(LocaleKeys.appDescription),
                style: TextStyle(
                  fontSize: 13.sp,
                  color: isDark ? AppColors.slate400 : AppColors.slate600,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(delay: 500.ms, duration: 500.ms),

              const Spacer(),

              // Loading Spinner & Status (Translated)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 18.w,
                    height: 18.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2.2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    tr(LocaleKeys.splashLoadingReady),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isDark ? AppColors.slate400 : AppColors.slate500,
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(delay: 600.ms, duration: 400.ms),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
