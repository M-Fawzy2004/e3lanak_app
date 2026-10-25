import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/localization/locale_keys.dart';
import '../../../../core/theme/app_colors.dart';

/// In-page CTA button triggering the AI ad generation process with premium visuals.
class AdGenerateCtaButton extends StatelessWidget {
  const AdGenerateCtaButton({
    super.key,
    required this.onTap,
    this.isLoading = false,
  });

  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(14.r),
      elevation: 3,
      shadowColor: AppColors.primary.withValues(alpha: 0.35),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: isLoading ? null : onTap,
        child: Container(
          height: 52.h,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: isLoading
              ? SizedBox(
                  width: 22.w,
                  height: 22.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2.2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.magicpen, size: 20.sp, color: AppColors.white)
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                        )
                        .scale(
                          begin: const Offset(0.9, 0.9),
                          end: const Offset(1.1, 1.1),
                          duration: const Duration(milliseconds: 1200),
                          curve: Curves.easeInOut,
                        ),
                    Gap(8.w),
                    Text(
                      tr(LocaleKeys.adGenerateAiAd),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
