import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/locale_keys.dart';
import '../../../../core/theme/app_colors.dart';

/// Dynamic savings percentage badge displayed in Step 2 when discount price is entered.
class AdSavingsBadge extends StatelessWidget {
  const AdSavingsBadge({
    super.key,
    required this.percentage,
  });

  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColors.success.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Text(
        tr(LocaleKeys.adSavingsBanner, args: [percentage.toString()]),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.success,
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
