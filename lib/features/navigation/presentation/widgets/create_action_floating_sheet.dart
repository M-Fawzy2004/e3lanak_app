import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/localization/locale_keys.dart';
import '../../../../core/theme/app_colors.dart';

/// Available actions when tapping the primary create button.
enum CreateActionType {
  aiAd,
  directPost,
}

/// A floating modal overlay displaying two independent floating cards
/// and a floating circular close button at the bottom.
class CreateActionFloatingSheet extends StatelessWidget {
  const CreateActionFloatingSheet({
    super.key,
    required this.onSelected,
  });

  final ValueChanged<CreateActionType> onSelected;

  @override
  Widget build(BuildContext context) {
    final isRtl = context.locale.languageCode == 'ar';

    return SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 20.w,
          end: 20.w,
          bottom: 18.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Floating Card 1: AI Ad Generation
            _FloatingActionCard(
              icon: Iconsax.magic_star,
              iconColor: AppColors.primary,
              iconBgColor: AppColors.primarySurface,
              titleKey: LocaleKeys.createAiAd,
              subtitleKey: LocaleKeys.createAiAdSubtitle,
              isRtl: isRtl,
              onTap: () => onSelected(CreateActionType.aiAd),
            )
                .animate()
                .fadeIn(duration: 260.ms, delay: 50.ms)
                .slideY(
                  begin: 0.35,
                  end: 0,
                  curve: Curves.easeOutCubic,
                  duration: 320.ms,
                ),

            Gap(12.h),

            // Floating Card 2: Direct Post
            _FloatingActionCard(
              icon: Iconsax.image,
              iconColor: AppColors.primaryDark,
              iconBgColor: AppColors.primarySurface,
              titleKey: LocaleKeys.publishDirectAd,
              subtitleKey: LocaleKeys.publishDirectAdSubtitle,
              isRtl: isRtl,
              onTap: () => onSelected(CreateActionType.directPost),
            )
                .animate()
                .fadeIn(duration: 260.ms, delay: 110.ms)
                .slideY(
                  begin: 0.35,
                  end: 0,
                  curve: Curves.easeOutCubic,
                  duration: 320.ms,
                ),

            Gap(22.h),

            // Floating Close Button
            Center(
              child: Semantics(
                button: true,
                label: tr(LocaleKeys.close),
                child: Material(
                  color: AppColors.surface,
                  shape: const CircleBorder(),
                  elevation: 8,
                  shadowColor: AppColors.black.withValues(alpha: 0.22),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      unawaited(HapticFeedback.lightImpact());
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 56.w,
                      height: 56.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.slate200,
                          width: 1.5.w,
                        ),
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        size: 26.sp,
                        color: AppColors.slate700,
                      ),
                    ),
                  ),
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 220.ms, delay: 170.ms)
                .scale(
                  begin: const Offset(0.7, 0.7),
                  end: const Offset(1, 1),
                  curve: Curves.easeOutBack,
                  duration: 280.ms,
                ),
          ],
        ),
      ),
    );
  }
}

class _FloatingActionCard extends StatelessWidget {
  const _FloatingActionCard({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.titleKey,
    required this.subtitleKey,
    required this.isRtl,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String titleKey;
  final String subtitleKey;
  final bool isRtl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      elevation: 10,
      shadowColor: AppColors.black.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        onTap: () {
          unawaited(HapticFeedback.lightImpact());
          onTap();
        },
        child: Container(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: AppColors.slate200.withValues(alpha: 0.85),
              width: 1.2.w,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Center(
                  child: Icon(icon, size: 24.sp, color: iconColor),
                ),
              ),
              Gap(14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr(titleKey),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppColors.darkNeutral,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                          ),
                    ),
                    Gap(4.h),
                    Text(
                      tr(subtitleKey),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.slate500,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
              ),
              Gap(8.w),
              Icon(
                isRtl ? Iconsax.arrow_left_2 : Iconsax.arrow_right_3,
                size: 16.sp,
                color: AppColors.slate400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
