import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/localization/locale_keys.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';

class PlatformActionCard extends StatefulWidget {
  const PlatformActionCard({
    super.key,
    required this.assetPath,
    required this.titleKey,
    required this.descKey,
    required this.borderColors,
    this.onTap,
  });

  final String assetPath;
  final String titleKey;
  final String descKey;
  final List<Color> borderColors;
  final VoidCallback? onTap;

  @override
  State<PlatformActionCard> createState() => _PlatformActionCardState();
}

class _PlatformActionCardState extends State<PlatformActionCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          foregroundPainter: _AnimatedBorderPainter(
            progress: _controller.value,
            gradientColors: widget.borderColors,
            borderRadius: 16.r,
            strokeWidth: 1.5,
          ),
          child: child,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: const [
            BoxShadow(color: AppColors.slate100, blurRadius: 10),
          ],
        ),
        child: Material(
          color: AppColors.transparent,
          borderRadius: BorderRadius.circular(16.r),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            borderRadius: BorderRadius.circular(16.r),
            onTap:
                widget.onTap ??
                () {
                  AppSnackBar.showInfo(
                    context,
                    message:
                        '${tr(widget.titleKey)} - ${tr(LocaleKeys.creationFeatureComingSoon)}',
                  );
                },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    widget.assetPath,
                    width: 48.w,
                    height: 48.w,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                  Gap(12.h),
                  Text(
                    tr(widget.titleKey),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.darkNeutral,
                      fontWeight: FontWeight.w800,
                      fontSize: 13.sp,
                      height: 1.2,
                    ),
                  ),
                  Gap(3.h),
                  Text(
                    tr(widget.descKey),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.slate400,
                      fontSize: 10.5.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedBorderPainter extends CustomPainter {
  const _AnimatedBorderPainter({
    required this.progress,
    required this.gradientColors,
    required this.borderRadius,
    required this.strokeWidth,
  });

  final double progress;
  final List<Color> gradientColors;
  final double borderRadius;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final rect = Offset.zero & size;
    final halfStroke = strokeWidth / 2;
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        halfStroke,
        halfStroke,
        size.width - strokeWidth,
        size.height - strokeWidth,
      ),
      Radius.circular(math.max(0, borderRadius - halfStroke)),
    );

    // Subtle background frame border
    final basePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = AppColors.slate400.withValues(alpha: 0.16);
    canvas.drawRRect(rrect, basePaint);

    // Animated dynamic gradient sweep beam
    final sweepGradient = SweepGradient(
      colors: gradientColors,
      transform: GradientRotation(progress * 2 * math.pi),
    );

    final beamPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = sweepGradient.createShader(rect);

    canvas.drawRRect(rrect, beamPaint);
  }

  @override
  bool shouldRepaint(_AnimatedBorderPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.gradientColors != gradientColors ||
      oldDelegate.borderRadius != borderRadius ||
      oldDelegate.strokeWidth != strokeWidth;
}
