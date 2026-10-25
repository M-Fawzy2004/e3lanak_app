import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/localization/locale_keys.dart';
import '../../../../core/theme/app_colors.dart';

/// In-page action buttons for Step 2 containing Next and Previous CTAs.
class AdStep2BottomActions extends StatelessWidget {
  const AdStep2BottomActions({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Next Button (Start in RTL)
        Expanded(
          child: Material(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(14.r),
            elevation: 2,
            shadowColor: AppColors.primary.withValues(alpha: 0.3),
            child: InkWell(
              borderRadius: BorderRadius.circular(14.r),
              onTap: onNext,
              child: Container(
                height: 50.h,
                alignment: Alignment.center,
                child: Text(
                  tr(LocaleKeys.next),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ),
          ),
        ),
        Gap(12.w),

        // Previous Button (End in RTL)
        Expanded(
          child: Material(
            color: AppColors.primarySurface,
            borderRadius: BorderRadius.circular(14.r),
            child: InkWell(
              borderRadius: BorderRadius.circular(14.r),
              onTap: onPrevious,
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: AppColors.primaryLight.withValues(alpha: 0.4),
                    width: 1.2,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  tr(LocaleKeys.previous),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.primary,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
