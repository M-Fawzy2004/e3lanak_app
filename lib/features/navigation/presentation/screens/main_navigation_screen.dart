import 'dart:async';

import 'package:e3lanak_app/features/home/presentation/screens/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/localization/locale_keys.dart';
import '../../../../core/theme/app_colors.dart';
import 'navigation_tab_placeholders.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  static const List<Widget> _tabs = [
    HomeScreen(),
    ExploreScreenPlaceholder(),
    MyAdsScreenPlaceholder(),
    ProfileScreenPlaceholder(),
  ];


  static const List<_NavigationDestination> _destinations = [
    _NavigationDestination(icon: Iconsax.home_2, labelKey: LocaleKeys.navHome),
    _NavigationDestination(
      icon: Iconsax.category_2,
      labelKey: LocaleKeys.navExplore,
    ),
    _NavigationDestination(
      icon: Iconsax.document_text,
      labelKey: LocaleKeys.navMyAds,
    ),
    _NavigationDestination(icon: Iconsax.user, labelKey: LocaleKeys.navProfile),
  ];

  int _selectedIndex = 0;

  void _selectTab(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);
  }

  Future<void> _openCreateActions() async {
    unawaited(HapticFeedback.mediumImpact());

    final selectedAction = await showModalBottomSheet<_CreateAction>(
      context: context,
      useSafeArea: true,
      backgroundColor: AppColors.transparent,
      builder: (sheetContext) => _CreateActionSheet(
        onSelected: (action) => Navigator.of(sheetContext).pop(action),
      ),
    );

    if (!mounted || selectedAction == null) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(tr(LocaleKeys.creationFeatureComingSoon))),
      );
  }

  Widget _buildBottomAppBar(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        height: 72.h,
        child: BottomAppBar(
          color: AppColors.surface,
          elevation: 10,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.w,
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: _buildNavigationItem(context, 0)),
                    Expanded(child: _buildNavigationItem(context, 1)),
                  ],
                ),
              ),
              SizedBox(width: 80.w),
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: _buildNavigationItem(context, 2)),
                    Expanded(child: _buildNavigationItem(context, 3)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationItem(BuildContext context, int index) {
    final destination = _destinations[index];
    final isSelected = _selectedIndex == index;
    final foregroundColor = isSelected ? AppColors.primary : AppColors.slate400;

    return Semantics(
      button: true,
      selected: isSelected,
      label: tr(destination.labelKey),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: () => _selectTab(index),
          splashFactory: NoSplash.splashFactory,
          splashColor: AppColors.transparent,
          highlightColor: AppColors.transparent,
          focusColor: AppColors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 2.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedScale(
                  scale: isSelected ? 1.04 : 1,
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  child: Icon(
                    destination.icon,
                    size: 24.sp,
                    color: foregroundColor,
                  ),
                ),
                Gap(3.h),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  width: isSelected ? 16.w : 0,
                  height: 2.h,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.transparent,
                    borderRadius: BorderRadius.circular(99.r),
                  ),
                ),
                Gap(3.h),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 160),
                  curve: Curves.easeOut,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: foregroundColor,
                    fontSize: 11.sp,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  ),
                  child: ExcludeSemantics(
                    child: Text(
                      tr(destination.labelKey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCenterFloatingActionButton(BuildContext context) {
    return Semantics(
      button: true,
      label: tr(LocaleKeys.createActionsTitle),
      child: Material(
        color: AppColors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => unawaited(_openCreateActions()),
          child: Ink(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.primary, AppColors.primaryDark],
              ),
              border: Border.all(color: AppColors.white, width: 3.w),
            ),
            child: Icon(
              Iconsax.magic_star,
              size: 28.sp,
              color: AppColors.secondary,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _selectedIndex, children: _tabs),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomAppBar(context),
      floatingActionButton: _buildCenterFloatingActionButton(context),
    );
  }
}

class _NavigationDestination {
  const _NavigationDestination({required this.icon, required this.labelKey});

  final IconData icon;
  final String labelKey;
}

enum _CreateAction { aiAd, directPost }

class _CreateActionSheet extends StatelessWidget {
  const _CreateActionSheet({required this.onSelected});

  final ValueChanged<_CreateAction> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.w, 12.h, 20.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 36.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.slate300,
                    borderRadius: BorderRadius.circular(99.r),
                  ),
                ),
              ),
              Gap(18.h),
              Text(
                tr(LocaleKeys.createActionsTitle),
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.darkNeutral,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gap(14.h),
              _CreateActionTile(
                icon: Iconsax.magic_star,
                titleKey: LocaleKeys.createAiAd,
                onTap: () => onSelected(_CreateAction.aiAd),
              ),
              Gap(10.h),
              _CreateActionTile(
                icon: Iconsax.image,
                titleKey: LocaleKeys.publishDirectAd,
                onTap: () => onSelected(_CreateAction.directPost),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateActionTile extends StatelessWidget {
  const _CreateActionTile({
    required this.icon,
    required this.titleKey,
    required this.onTap,
  });

  final IconData icon;
  final String titleKey;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primarySurface,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          child: Row(
            children: [
              Icon(icon, size: 24.sp, color: AppColors.primary),
              Gap(12.w),
              Expanded(
                child: Text(
                  tr(titleKey),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.darkNeutral,
                    fontWeight: FontWeight.w600,
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
