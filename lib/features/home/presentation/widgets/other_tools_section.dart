import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/localization/locale_keys.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';

class _ToolItem {
  const _ToolItem({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.titleKey,
    required this.descKey,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String titleKey;
  final String descKey;
}

class OtherToolsSection extends StatelessWidget {
  const OtherToolsSection({super.key});

  static const List<_ToolItem> _items = [
    _ToolItem(
      icon: Iconsax.clock,
      iconColor: AppColors.primary,
      iconBgColor: AppColors.primarySurface,
      titleKey: LocaleKeys.homeToolHistoryTitle,
      descKey: LocaleKeys.homeToolHistoryDesc,
    ),
    _ToolItem(
      icon: Iconsax.heart,
      iconColor: Color(0xFFEF4444),
      iconBgColor: Color(0xFFFFEEF0),
      titleKey: LocaleKeys.homeToolFavoritesTitle,
      descKey: LocaleKeys.homeToolFavoritesDesc,
    ),
    _ToolItem(
      icon: Iconsax.setting_2,
      iconColor: AppColors.slate700,
      iconBgColor: Color(0xFFF1F5F9),
      titleKey: LocaleKeys.homeToolSettingsTitle,
      descKey: LocaleKeys.homeToolSettingsDesc,
    ),
  ];

  void _showComingSoon(BuildContext context, String titleKey) {
    AppSnackBar.showInfo(
      context,
      message: '${tr(titleKey)} - ${tr(LocaleKeys.creationFeatureComingSoon)}',
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
                for (var i = 0; i < _items.length; i++) ...[
                  if (i > 0) Gap(10.w),
                  Expanded(
                    child: _ToolItemCard(
                      item: _items[i],
                      onTap: () => _showComingSoon(context, _items[i].titleKey),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ToolItemCard extends StatelessWidget {
  const _ToolItemCard({required this.item, required this.onTap});

  final _ToolItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.slate400.withValues(alpha: 0.18)),
      ),
      child: Material(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
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
                    color: item.iconBgColor,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(item.icon, size: 22.sp, color: item.iconColor),
                ),
                Gap(10.h),
                Text(
                  tr(item.titleKey),
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
                  tr(item.descKey),
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
