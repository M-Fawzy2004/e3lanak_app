import 'package:e3lanak_app/core/localization/language_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/localization/locale_keys.dart';
import '../../../../core/theme/app_colors.dart';

class _TemplateItem {
  const _TemplateItem({
    required this.titleKey,
    required this.icon,
    required this.colors,
  });

  final String titleKey;
  final IconData icon;
  final List<Color> colors;
}

class TrendingTemplatesSection extends StatelessWidget {
  const TrendingTemplatesSection({super.key});

  static const List<_TemplateItem> _items = [
    _TemplateItem(
      titleKey: LocaleKeys.homeTemplateFlashSale,
      icon: Iconsax.flash_1,
      colors: [Color(0xFFFF8A4C), Color(0xFFFF4D6D)],
    ),
    _TemplateItem(
      titleKey: LocaleKeys.homeTemplateNewProduct,
      icon: Iconsax.box,
      colors: [Color(0xFF38BDF8), Color(0xFF2563EB)],
    ),
    _TemplateItem(
      titleKey: LocaleKeys.homeTemplateSocialProof,
      icon: Iconsax.star_1,
      colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
    ),
    _TemplateItem(
      titleKey: LocaleKeys.homeTemplateDiscount,
      icon: Iconsax.discount_shape,
      colors: [Color(0xFF34D399), Color(0xFF059669)],
    ),
  ];

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
    final cardWidth = (MediaQuery.of(context).size.width * 0.42)
        .clamp(140.0, 200.0)
        .toDouble();
    final listHeight = (cardWidth * 0.62).clamp(88.0, 120.0).toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                tr(LocaleKeys.homeSectionTrending),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.darkNeutral,
                  fontWeight: FontWeight.w800,
                  fontSize: 18.sp,
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20.r),
                onTap: () => _showComingSoon(context, LocaleKeys.homeViewAll),
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
        ),
        Gap(14.h),
        SizedBox(
          height: listHeight,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _items.length,
            separatorBuilder: (_, _) => Gap(12.w),
            itemBuilder: (context, index) {
              final item = _items[index];
              return _TemplateCard(
                width: cardWidth,
                item: item,
                onTap: () => _showComingSoon(context, item.titleKey),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TemplateCard extends StatefulWidget {
  const _TemplateCard({
    required this.width,
    required this.item,
    required this.onTap,
  });

  final double width;
  final _TemplateItem item;
  final VoidCallback onTap;

  @override
  State<_TemplateCard> createState() => _TemplateCardState();
}

class _TemplateCardState extends State<_TemplateCard> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return AnimatedScale(
      scale: _pressed ? 0.96 : 1.0,
      duration: const Duration(milliseconds: 140),
      curve: Curves.easeOut,
      child: Container(
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.r),
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: item.colors,
          ),
        ),
        child: Material(
          color: AppColors.transparent,
          borderRadius: BorderRadius.circular(22.r),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            borderRadius: BorderRadius.circular(22.r),
            onTap: widget.onTap,
            onTapDown: (_) => _setPressed(true),
            onTapCancel: () => _setPressed(false),
            onTapUp: (_) => _setPressed(false),
            child: Stack(
              children: [
                PositionedDirectional(
                  end: -18.w,
                  top: -18.w,
                  child: Container(
                    width: 74.w,
                    height: 74.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white.withValues(alpha: 0.14),
                    ),
                  ),
                ),
                PositionedDirectional(
                  end: 12.w,
                  bottom: -22.w,
                  child: Container(
                    width: 54.w,
                    height: 54.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white.withValues(alpha: 0.10),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          item.icon,
                          size: 19.sp,
                          color: AppColors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              tr(item.titleKey),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13.sp,
                                    height: 1.25,
                                  ),
                            ),
                          ),
                          Gap(6.w),
                          Container(
                            width: 24.w,
                            height: 24.w,
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.9),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              LanguageManager.isRtl(context)
                                  ? Iconsax.arrow_left_2
                                  : Iconsax.arrow_right_3,
                              size: 13.sp,
                              color: item.colors.last,
                            ),
                          ),
                        ],
                      ),
                    ],
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
