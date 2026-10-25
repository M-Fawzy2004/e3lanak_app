import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/localization/locale_keys.dart';
import '../../../../core/theme/app_colors.dart';

class _RecentAdItem {
  const _RecentAdItem({
    required this.titleKey,
    required this.timeKey,
    required this.iconAsset,
    required this.statusKey,
    required this.isReady,
  });

  final String titleKey;
  final String timeKey;
  final String iconAsset;
  final String statusKey;
  final bool isReady;
}

class RecentAdsSection extends StatelessWidget {
  const RecentAdsSection({super.key});

  static const List<_RecentAdItem> _items = [
    _RecentAdItem(
      titleKey: LocaleKeys.homeRecentAdFbTitle,
      timeKey: LocaleKeys.homeRecentAdFbTime,
      iconAsset: AppAssets.iconFacebook,
      statusKey: LocaleKeys.homeStatusReady,
      isReady: true,
    ),
    _RecentAdItem(
      titleKey: LocaleKeys.homeRecentAdTiktokTitle,
      timeKey: LocaleKeys.homeRecentAdTiktokTime,
      iconAsset: AppAssets.iconTiktok,
      statusKey: LocaleKeys.homeStatusReady,
      isReady: true,
    ),
    _RecentAdItem(
      titleKey: LocaleKeys.homeRecentAdInstaTitle,
      timeKey: LocaleKeys.homeRecentAdInstaTime,
      iconAsset: AppAssets.iconInstagram,
      statusKey: LocaleKeys.homeStatusDraft,
      isReady: false,
    ),
  ];

  void _showSnack(BuildContext context, String message, int seconds) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: seconds),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                tr(LocaleKeys.homeSectionRecentActivity),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.darkNeutral,
                  fontWeight: FontWeight.w800,
                  fontSize: 18.sp,
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20.r),
                onTap: () => _showSnack(
                  context,
                  '${tr(LocaleKeys.homeViewAll)} - ${tr(LocaleKeys.creationFeatureComingSoon)}',
                  2,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    tr(LocaleKeys.homeViewAll),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 11.5.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Gap(12.h),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _items.length,
            separatorBuilder: (_, _) => Gap(10.h),
            itemBuilder: (context, index) {
              final item = _items[index];
              return _RecentAdCard(
                item: item,
                onTap: () => _showSnack(
                  context,
                  '${tr(item.titleKey)} - ${tr(LocaleKeys.creationFeatureComingSoon)}',
                  2,
                ),
                onCopy: () {
                  Clipboard.setData(ClipboardData(text: tr(item.titleKey)));
                  _showSnack(context, tr(LocaleKeys.copiedToClipboard), 1);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _RecentAdCard extends StatelessWidget {
  const _RecentAdCard({
    required this.item,
    required this.onTap,
    required this.onCopy,
  });

  final _RecentAdItem item;
  final VoidCallback onTap;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final statusColor = item.isReady ? AppColors.success : AppColors.slate600;
    final statusBg = item.isReady
        ? AppColors.success.withValues(alpha: 0.1)
        : AppColors.slate200;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.slate400.withValues(alpha: 0.18)),
      ),
      child: Material(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(18.r),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(18.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12.w, 12.h, 6.w, 12.h),
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F6FB),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Image.asset(
                    item.iconAsset,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        tr(item.titleKey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.darkNeutral,
                          fontWeight: FontWeight.w800,
                          fontSize: 13.5.sp,
                          height: 1.2,
                        ),
                      ),
                      Gap(6.h),
                      Row(
                        children: [
                          Icon(
                            Iconsax.clock,
                            size: 12.sp,
                            color: AppColors.slate400,
                          ),
                          Gap(4.w),
                          Flexible(
                            child: Text(
                              tr(item.timeKey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: AppColors.slate400,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          Gap(8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: statusBg,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 5.w,
                                  height: 5.w,
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Gap(4.w),
                                Text(
                                  tr(item.statusKey),
                                  style: TextStyle(
                                    color: statusColor,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onCopy,
                  tooltip: tr(LocaleKeys.copy),
                  visualDensity: VisualDensity.compact,
                  icon: Icon(
                    Iconsax.copy,
                    size: 18.sp,
                    color: AppColors.slate500,
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
