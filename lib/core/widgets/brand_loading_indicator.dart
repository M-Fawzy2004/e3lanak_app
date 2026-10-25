import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../localization/locale_keys.dart';
import '../theme/app_colors.dart';

/// Compact, reusable loading indicator built around the E3lanak brand mark.
class BrandLoadingIndicator extends StatefulWidget {
  const BrandLoadingIndicator({super.key, this.size = 56})
    : assert(size > 0);

  final double size;

  @override
  State<BrandLoadingIndicator> createState() => _BrandLoadingIndicatorState();
}

class _BrandLoadingIndicatorState extends State<BrandLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final badgeSize = widget.size * 0.66;

    return Semantics(
      label: tr(LocaleKeys.loading),
      liveRegion: true,
      child: ExcludeSemantics(
        child: SizedBox.square(
          dimension: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              RepaintBoundary(
                child: AnimatedBuilder(
                  animation: _rotationController,
                  child: CustomPaint(
                    size: Size.square(widget.size),
                    painter: const _BrandLoadingRingPainter(),
                  ),
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotationController.value * 2 * math.pi,
                      child: child,
                    );
                  },
                ),
              ),
              Container(
                width: badgeSize,
                height: badgeSize,
                decoration: BoxDecoration(
                  color: AppColors.primaryDark.withValues(alpha: 0.96),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.66),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.22),
                      blurRadius: widget.size * 0.28,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text.rich(
                    const TextSpan(
                      children: [
                        TextSpan(
                          text: 'E',
                          style: TextStyle(color: AppColors.white),
                        ),
                        TextSpan(
                          text: '3',
                          style: TextStyle(color: AppColors.accent),
                        ),
                      ],
                    ),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: widget.size * 0.29,
                      fontWeight: FontWeight.w800,
                      height: 1,
                      letterSpacing: -0.8,
                    ),
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

class _BrandLoadingRingPainter extends CustomPainter {
  const _BrandLoadingRingPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.shortestSide * 0.055;
    final bounds = Offset.zero & size;
    final ringBounds = bounds.deflate(strokeWidth / 2);

    final trackPaint = Paint()
      ..color = AppColors.white.withValues(alpha: 0.24)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawArc(ringBounds, 0, math.pi * 2, false, trackPaint);

    final progressPaint = Paint()
      ..shader = const SweepGradient(
        colors: [
          AppColors.accent,
          AppColors.white,
          AppColors.primaryLight,
          AppColors.primaryLight,
        ],
        stops: [0, 0.32, 0.72, 1],
      ).createShader(ringBounds)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    canvas.drawArc(
      ringBounds,
      -math.pi / 2,
      math.pi * 1.48,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _BrandLoadingRingPainter oldDelegate) => false;
}
