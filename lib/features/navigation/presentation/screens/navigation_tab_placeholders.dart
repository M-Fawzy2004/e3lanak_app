import 'package:e3lanak_app/features/home/presentation/screens/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/localization/locale_keys.dart';
import '../../../../core/theme/app_colors.dart';

class FeedScreenPlaceholder extends StatelessWidget {
  const FeedScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context) => const HomeScreen();
}


class ExploreScreenPlaceholder extends StatelessWidget {
  const ExploreScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context) => const _NavigationTabPlaceholder(
    titleKey: LocaleKeys.navExplore,
    icon: Iconsax.category_2,
  );
}

class MyAdsScreenPlaceholder extends StatelessWidget {
  const MyAdsScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context) => const _NavigationTabPlaceholder(
    titleKey: LocaleKeys.navMyAds,
    icon: Iconsax.document_text,
  );
}

class ProfileScreenPlaceholder extends StatelessWidget {
  const ProfileScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context) => const _NavigationTabPlaceholder(
    titleKey: LocaleKeys.navProfile,
    icon: Iconsax.user,
  );
}

class _NavigationTabPlaceholder extends StatelessWidget {
  const _NavigationTabPlaceholder({required this.titleKey, required this.icon});

  final String titleKey;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final title = tr(titleKey);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: const BoxDecoration(
                    color: AppColors.primarySurface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 36.sp, color: AppColors.primary),
                ),
                Gap(16.h),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.darkNeutral,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gap(8.h),
                Text(
                  tr(LocaleKeys.navigationComingSoon),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: AppColors.textSecondary, height: 1.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
