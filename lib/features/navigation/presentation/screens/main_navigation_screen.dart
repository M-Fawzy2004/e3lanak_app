import 'dart:async';

import 'package:e3lanak_app/features/home/presentation/screens/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/localization/locale_keys.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import 'navigation_tab_placeholders.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _beamController;

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

  @override
  void initState() {
    super.initState();
    _beamController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 12000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _beamController.dispose();
    super.dispose();
  }

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

    if (selectedAction == _CreateAction.aiAd) {
      unawaited(Navigator.of(context).pushNamed(AppRoutes.adGeneratorStep1));
    } else {
      AppSnackBar.showInfo(
        context,
        message: tr(LocaleKeys.creationFeatureComingSoon),
      );
    }
  }

  Widget _buildBottomAppBar(BuildContext context) {
    final notchMargin = 8.w;
    final fabRadius = 32.w; // Half of 64.w FAB

    return SafeArea(
      top: false,
      child: SizedBox(
        height: 72.h,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // The notched BottomAppBar
            Positioned.fill(
              child: BottomAppBar(
                color: AppColors.surface,
                elevation: 6,
                shadowColor: Colors.black.withValues(alpha: 0.12),
                shape: const CircularNotchedRectangle(),
                notchMargin: notchMargin,
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

            // Animated glowing blue beam sweeping across the top border and notch
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: _beamController,
                  builder: (context, _) {
                    return CustomPaint(
                      painter: _NotchedBorderBeamPainter(
                        progress: _beamController.value,
                        notchMargin: notchMargin,
                        fabRadius: fabRadius,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
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
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.transparent,
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

/// Custom painter that renders:
/// 1. A clean static top border tracing the top edge and the circular notch
///    so the floating button and cutout are always crisp against white backgrounds.
/// 2. An animated glowing electric-blue laser beam that glides back and forth
///    smoothly along the contour, hugging the notch curve with an intense spark.
class _NotchedBorderBeamPainter extends CustomPainter {
  const _NotchedBorderBeamPainter({
    required this.progress,
    required this.notchMargin,
    required this.fabRadius,
  });

  final double progress;
  final double notchMargin;
  final double fabRadius;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    const shape = CircularNotchedRectangle();
    final host = Rect.fromLTWH(0, 0, size.width, size.height);
    final guest = Rect.fromCircle(
      center: Offset(size.width / 2, 0),
      radius: fabRadius + notchMargin,
    );

    final fullPath = shape.getOuterPath(host, guest);
    final metricsList = fullPath.computeMetrics().toList();
    if (metricsList.isEmpty) return;

    final metrics = metricsList.first;
    final totalLength = metrics.length;
    final topContourLength = totalLength - (2 * size.height + size.width);
    if (topContourLength <= 0) return;

    final topPath = metrics.extractPath(0, topContourLength);

    // 1. Static base border along the top and notch curve (crisp contrast on white)
    final baseBorderPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawPath(topPath, baseBorderPaint);

    // 2. Animated shiny blue beam that travels back and forth calmly
    final beamLength = topContourLength * 0.22; // 22% of top contour
    final travelDistance = topContourLength - beamLength;
    final smoothProgress = Curves.easeInOutSine.transform(progress);
    final startDistance = travelDistance * smoothProgress;
    final endDistance = startDistance + beamLength;

    final beamPath = metrics.extractPath(startDistance, endDistance);

    // Outer neon glow
    final glowPaint = Paint()
      ..color = const Color(0xFF38BDF8).withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.6
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.0);
    canvas.drawPath(beamPath, glowPaint);

    // Core electric royal blue beam
    final corePaint = Paint()
      ..color = const Color(0xFF0D5EF4)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;
    canvas.drawPath(beamPath, corePaint);

    // Brilliant white-cyan sparkle at the center of the beam
    final centerOffset = startDistance + (beamLength / 2);
    final tangent = metrics.getTangentForOffset(centerOffset);
    if (tangent != null) {
      final sparkPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawCircle(tangent.position, 1.8, sparkPaint);
    }
  }

  @override
  bool shouldRepaint(_NotchedBorderBeamPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
