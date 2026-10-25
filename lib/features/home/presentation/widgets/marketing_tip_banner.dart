import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/localization/locale_keys.dart';
import '../../../../core/theme/app_colors.dart';

/// Senior UI/UX Smart Marketing Tip Banner.
///
/// Features:
/// - Rich Royal Navy gradient with guaranteed visibility directly on the outer container
/// - High-contrast WCAG AAA typography (pure white title & crisp Slate-200 body)
/// - Directional RTL/LTR support with directional ambient accents
/// - Glassmorphic AI pill badge with amber spark
/// - High-converting tactile CTA button with directional arrow feedback
class MarketingTipBanner extends StatelessWidget {
  const MarketingTipBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient: const LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [
              Color(0xFF0F52E0), // Vibrant Royal Blue
              Color(0xFF0A359E), // Rich Navy
              Color(0xFF071E58), // Midnight Indigo
            ],
            stops: [0.0, 0.55, 1.0],
          ),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.16),
            width: 1.2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22.r),
          child: Stack(
            children: [
              // Ambient soft top-start glow for depth
              PositionedDirectional(
                top: -30.h,
                start: -20.w,
                child: Container(
                  width: 160.w,
                  height: 160.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.12),
                        Colors.white.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),

              // Subtle watermark AI star in trailing corner
              PositionedDirectional(
                bottom: -20.h,
                end: -15.w,
                child: IgnorePointer(
                  child: Opacity(
                    opacity: 0.06,
                    child: Icon(
                      Iconsax.magic_star,
                      size: 140.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Foreground content
              Padding(
                padding: EdgeInsets.all(18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Badge & Title Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Glassmorphic AI Badge
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(
                              color: AppColors.secondary.withValues(
                                alpha: 0.35,
                              ),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Iconsax.magic_star,
                                size: 13.sp,
                                color: AppColors.secondary,
                              ),
                              Gap(5.w),
                              Text(
                                tr(LocaleKeys.homeBannerBadge),
                                style: TextStyle(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11.5.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(10.w),
                        Expanded(
                          child: Text(
                            tr(LocaleKeys.homeBannerTitle),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14.5.sp,
                                  letterSpacing: 0.2,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Gap(12.h),

                    // Tip Subtitle / Body Copy with high contrast and readable line-height
                    Text(
                      tr(LocaleKeys.homeBannerSubtitle),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFFE2E8F0),
                        fontSize: 13.sp,
                        height: 1.55,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gap(16.h),

                    // High-Conversion Tactile CTA Button
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Material(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(12.r),
                        elevation: 3,
                        shadowColor: Colors.black.withValues(alpha: 0.25),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12.r),
                          onTap: () {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  content: Text(
                                    tr(LocaleKeys.creationFeatureComingSoon),
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  tr(LocaleKeys.homeBannerCta),
                                  style: TextStyle(
                                    color: AppColors.darkNeutral,
                                    fontSize: 12.5.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Gap(6.w),
                                Icon(
                                  isRtl
                                      ? Iconsax.arrow_left
                                      : Iconsax.arrow_right,
                                  size: 14.sp,
                                  color: AppColors.darkNeutral,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
