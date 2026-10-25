import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/localization/locale_keys.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/ad_image.dart';
import 'dashed_rect_painter.dart';

/// Large hero card for Step 1:
/// - If an image is selected, displays the primary (1st) image prominently
///   with a localized primary badge and tap-to-change action.
/// - If no photo has been selected yet, renders a dashed dropzone invitation.
class UploadDropzoneCard extends StatelessWidget {
  const UploadDropzoneCard({
    super.key,
    required this.primaryImage,
    required this.onTap,
  });

  final AdImage? primaryImage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (primaryImage != null) {
      return _buildPrimaryPreview(context);
    }
    return _buildEmptyDropzone(context);
  }

  Widget _buildPrimaryPreview(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 300.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.primaryLight, width: 1.5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Display Image
              kIsWeb
                  ? Image.network(primaryImage!.path, fit: BoxFit.cover)
                  : Image.file(File(primaryImage!.path), fit: BoxFit.cover),

              // Gradient vignette for badge and action button readability
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.black.withValues(alpha: 0.35),
                      AppColors.transparent,
                      AppColors.black.withValues(alpha: 0.45),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),

              // Top Primary Badge
              PositionedDirectional(
                top: 12.h,
                start: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
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
                        tr(LocaleKeys.adPrimaryImage),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.white,
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Change / Tap to Replace overlay hint
              PositionedDirectional(
                bottom: 12.h,
                end: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.15),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Iconsax.edit_2,
                        size: 13.sp,
                        color: AppColors.primary,
                      ),
                      Gap(4.w),
                      Text(
                        tr(LocaleKeys.adChangeImage),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.primary,
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyDropzone(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 172.h,
        decoration: BoxDecoration(
          color: AppColors.primarySurface,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: CustomPaint(
          painter: const DashedRectPainter(
            color: AppColors.primaryLight,
            strokeWidth: 1.5,
            dash: 6.0,
            gap: 4.0,
            radius: 16.0,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Upload Icon Container
                Container(
                  width: 58.w,
                  height: 58.w,
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Center(
                    child: Icon(
                      Iconsax.gallery_add,
                      size: 32.sp,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Gap(12.h),

                // Text line 1: اضغط هنا لإضافة الصور
                Text(
                  tr(LocaleKeys.adUploadBoxClick),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.darkNeutral,
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gap(4.h),

                // Text line 2: يمكنك اختيار حتى 3 صور من جهازك
                Text(
                  tr(LocaleKeys.adUploadBoxDrag),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
