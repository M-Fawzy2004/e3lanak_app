import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../core/localization/locale_keys.dart';
import '../../../../core/theme/app_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.w, 5.h, 16.w, 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tr(LocaleKeys.homeGreeting),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.darkNeutral,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
                Text(
                  tr(LocaleKeys.homeSubtitle),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.slate500,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: AppColors.white,
            shape: const CircleBorder(),
            elevation: 2,
            shadowColor: AppColors.black.withValues(alpha: 0.08),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(tr(LocaleKeys.creationFeatureComingSoon)),
                      duration: const Duration(seconds: 2),
                    ),
                  );
              },
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Icon(
                  Iconsax.notification,
                  size: 22.sp,
                  color: AppColors.darkNeutral,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
