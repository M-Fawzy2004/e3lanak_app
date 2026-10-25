import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/localization/locale_keys.dart';
import '../../../../core/theme/app_colors.dart';

class OtherToolsSection extends StatelessWidget {
  const OtherToolsSection({super.key});

  void _showComingSoon(BuildContext context, String titleKey) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            '${tr(titleKey)} - ${tr(LocaleKeys.creationFeatureComingSoon)}',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr(LocaleKeys.homeSectionOtherTools),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.darkNeutral,
              fontWeight: FontWeight.w800,
              fontSize: 18.sp,
            ),
          ),
          Gap(12.h),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _ToolItemCard(
                    icon: Iconsax.clock,
                    iconColor: AppColors.primary,
                    iconBgColor: AppColors.primarySurface,
                    titleKey: LocaleKeys.homeToolHistoryTitle,
                    descKey: LocaleKeys.homeToolHistoryDesc,
                    onTap: () => _showComingSoon(
                      context,
                      LocaleKeys.homeToolHistoryTitle,
                    ),
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: _ToolItemCard(
                    icon: Iconsax.heart,
                    iconColor: const Color(0xFFEF4444),
                    iconBgColor: const Color(0xFFFFEEF0),
                    titleKey: LocaleKeys.homeToolFavoritesTitle,
                    descKey: LocaleKeys.homeToolFavoritesDesc,
                    onTap: () => _showComingSoon(
                      context,
                      LocaleKeys.homeToolFavoritesTitle,
                    ),
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: _ToolItemCard(
                    icon: Iconsax.setting_2,
                    iconColor: AppColors.slate700,
                    iconBgColor: const Color(0xFFF1F5F9),
                    titleKey: LocaleKeys.homeToolSettingsTitle,
                    descKey: LocaleKeys.homeToolSettingsDesc,
                    onTap: () => _showComingSoon(
                      context,
                      LocaleKeys.homeToolSettingsTitle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ToolItemCard extends StatelessWidget {
  const _ToolItemCard({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.titleKey,
    required this.descKey,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String titleKey;
  final String descKey;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.slate400.withValues(alpha: 0.16)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.05),
            blurRadius: 14.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Material(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 14.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 46.w,
                  height: 46.w,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(icon, size: 22.sp, color: iconColor),
                ),
                Gap(10.h),
                Text(
                  tr(titleKey),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.darkNeutral,
                    fontWeight: FontWeight.w800,
                    fontSize: 12.5.sp,
                    height: 1.2,
                  ),
                ),
                Gap(3.h),
                Text(
                  tr(descKey),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.slate400,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
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
