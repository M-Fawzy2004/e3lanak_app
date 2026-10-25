import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/ad_category.dart';

/// Interactive, animated Category selection card with rich micro-interactions and haptics.
class AdCategoryCard extends StatelessWidget {
  const AdCategoryCard({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
    this.animationDelay = Duration.zero,
  });

  final AdCategory category;
  final bool isSelected;
  final VoidCallback onTap;
  final Duration animationDelay;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primarySurface : AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.border,
          width: isSelected ? 1.8 : 1.2,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.16),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.02),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Material(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            unawaited(HapticFeedback.selectionClick());
            onTap();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon with subtle animated scale on selection
                AnimatedScale(
                  scale: isSelected ? 1.12 : 1.0,
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.easeOutBack,
                  child: Container(
                    width: 46.w,
                    height: 46.w,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.slate100,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Icon(
                        category.icon,
                        size: 24.sp,
                        color: isSelected ? AppColors.white : AppColors.darkNeutral,
                      ),
                    ),
                  ),
                ),
                Gap(10.h),

                // Category Title
                Text(
                  tr(category.titleKey),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.darkNeutral,
                        fontSize: 12.5.sp,
                        fontWeight:
                            isSelected ? FontWeight.w800 : FontWeight.w600,
                        height: 1.25,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          delay: animationDelay,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        )
        .slideY(
          begin: 0.1,
          end: 0,
          delay: animationDelay,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
        );
  }
}
