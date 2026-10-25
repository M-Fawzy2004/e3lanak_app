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

/// Thumbnail section displaying 3 image slots:
/// - Selected photo previews with clear delete badges
/// - Empty dashed slots that invite the user to pick more photos
class SelectedImagesPreview extends StatelessWidget {
  const SelectedImagesPreview({
    super.key,
    required this.images,
    required this.onRemove,
    required this.onAddTap,
  });

  final List<AdImage> images;
  final ValueChanged<int> onRemove;
  final VoidCallback onAddTap;

  @override
  Widget build(BuildContext context) {
    final count = images.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${tr(LocaleKeys.adSelectedImagesTitle)} ($count/3)',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.darkNeutral,
            fontSize: 14.5.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        Gap(12.h),
        // 3 Slots Row
        LayoutBuilder(
          builder: (context, constraints) {
            final slotWidth = (constraints.maxWidth - 24.w) / 3;

            return Row(
              children: [
                for (var i = 0; i < 3; i++) ...[
                  if (i > 0) Gap(12.w),
                  Expanded(
                    child: SizedBox(
                      height: slotWidth,
                      child: i < images.length
                          ? _buildImageThumbnail(image: images[i], index: i)
                          : _buildEmptySlot(),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildImageThumbnail({required AdImage image, required int index}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Thumbnail Image Container
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.border, width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: kIsWeb
                  ? Image.network(image.path, fit: BoxFit.cover)
                  : Image.file(File(image.path), fit: BoxFit.cover),
            ),
          ),
        ),

        // Delete badge in the top-end corner
        PositionedDirectional(
          top: -6.w,
          end: -6.w,
          child: Semantics(
            button: true,
            label: tr(LocaleKeys.delete),
            child: Material(
              color: AppColors.transparent,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => onRemove(index),
                child: Container(
                  width: 22.w,
                  height: 22.w,
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.18),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Iconsax.close_circle,
                      size: 13.sp,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptySlot() {
    return Semantics(
      button: true,
      label: tr(LocaleKeys.adUploadBoxClick),
      child: Material(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: onAddTap,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.slate50,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: CustomPaint(
              painter: const DashedRectPainter(
                color: AppColors.slate300,
                strokeWidth: 1.2,
                dash: 4.0,
                gap: 3.0,
                radius: 12.0,
              ),
              child: Center(
                child: Icon(
                  Iconsax.add,
                  size: 22.sp,
                  color: AppColors.slate400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
