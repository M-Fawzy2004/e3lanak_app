import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/localization/locale_keys.dart';
import '../../../../core/theme/app_colors.dart';

/// Side-by-side action buttons for capturing with camera or selecting from gallery.
class AdImageActionButtons extends StatelessWidget {
  const AdImageActionButtons({
    super.key,
    required this.onPickGallery,
    required this.onTakePhoto,
    this.isLoading = false,
  });

  final VoidCallback onPickGallery;
  final VoidCallback onTakePhoto;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildButton(
            context: context,
            icon: Iconsax.camera,
            label: tr(LocaleKeys.adTakePhotoCamera),
            onTap: isLoading ? null : onTakePhoto,
          ),
        ),
        Gap(12.w),
        Expanded(
          child: _buildButton(
            context: context,
            icon: Iconsax.gallery,
            label: tr(LocaleKeys.adSelectFromGallery),
            onTap: isLoading ? null : onPickGallery,
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
  }) {
    final isDisabled = onTap == null;

    return Material(
      color: isDisabled ? AppColors.slate50 : AppColors.white,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onTap,
        child: Container(
          height: 52.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: isDisabled ? AppColors.slate50 : AppColors.white,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: isDisabled ? AppColors.slate200 : AppColors.primaryLight,
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20.sp,
                color: isDisabled ? AppColors.slate400 : AppColors.primary,
              ),
              Gap(8.w),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: isDisabled ? AppColors.slate400 : AppColors.primary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
