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
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.border,
          width: isSelected ? 1.8 : 1.2,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.16),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ]
            : [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.02),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Material(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(14.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: () {
            unawaited(HapticFeedback.selectionClick());
            onTap();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon or Image with subtle animated scale on selection
                AnimatedScale(
                  scale: isSelected ? 1.08 : 1.0,
                  duration: const Duration(milliseconds: 240),
                  curve: Curves.easeOutBack,
                  child: Container(
                    width: 38.w,
                    height: 38.w,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.slate100,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: category.imageUrl != null
                          ? Image.network(
                              category.imageUrl!,
                              width: 24.w,
                              height: 24.w,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                category.icon,
                                size: 19.sp,
                                color: isSelected
                                    ? AppColors.white
                                    : AppColors.darkNeutral,
                              ),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Icon(
                                  category.icon,
                                  size: 19.sp,
                                  color: isSelected
                                      ? AppColors.white
                                      : AppColors.slate400,
                                );
                              },
                            )
                          : Icon(
                              category.icon,
                              size: 19.sp,
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.darkNeutral,
                            ),
                    ),
                  ),
                ),
                Gap(6.h),

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
                        fontSize: 11.sp,
                        fontWeight:
                            isSelected ? FontWeight.w800 : FontWeight.w600,
                        height: 1.2,
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
