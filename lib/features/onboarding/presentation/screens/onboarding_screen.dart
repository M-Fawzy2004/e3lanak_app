import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/localization/language_manager.dart';
import '../../../../core/localization/locale_keys.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isRtl = LanguageManager.isRtl(context);
    final slideStart = isRtl ? 0.14 : -0.14;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.slate50,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxHeight < 700;
              final illustrationHeight =
                  constraints.maxHeight * (compact ? 0.44 : 0.58);

              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      16.w,
                      25.h,
                      16.w,
                      25.h,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: illustrationHeight,
                              width: double.infinity,
                              child:
                                  Image.asset(
                                        'assets/images/onboarding_screen.png',
                                        fit: BoxFit.contain,
                                        alignment: Alignment.center,
                                      )
                                      .animate()
                                      .fadeIn(duration: 600.ms)
                                      .slideX(
                                        begin: slideStart,
                                        end: 0,
                                        duration: 650.ms,
                                        curve: Curves.easeOutCubic,
                                      )
                                      .scale(
                                        begin: const Offset(0.96, 0.96),
                                        end: const Offset(1, 1),
                                        duration: 700.ms,
                                        curve: Curves.easeOutCubic,
                                      ),
                            ),
                            SizedBox(height: 30.h),
                            Text(
                                  tr(LocaleKeys.onboardingTitle),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.tajawal(
                                    fontSize: 25.sp,
                                    height: 1.25,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.darkNeutral,
                                  ),
                                )
                                .animate(delay: 100.ms)
                                .fadeIn(duration: 450.ms)
                                .slideX(
                                  begin: slideStart * 0.7,
                                  end: 0,
                                  duration: 500.ms,
                                  curve: Curves.easeOutCubic,
                                ),
                            SizedBox(height: 15.h),
                            Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                  ),
                                  child: Text(
                                    tr(LocaleKeys.onboardingDescription),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.tajawal(
                                      fontSize: 14.5.sp,
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.slate700,
                                    ),
                                  ),
                                )
                                .animate(delay: 190.ms)
                                .fadeIn(duration: 450.ms)
                                .slideX(
                                  begin: slideStart * 0.55,
                                  end: 0,
                                  duration: 500.ms,
                                  curve: Curves.easeOutCubic,
                                ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16.h),
                          child:
                              _SwipeToStartButton(
                                    onCompleted: () => Navigator.of(context)
                                        .pushReplacementNamed(AppRoutes.auth),
                                  )
                                  .animate(delay: 330.ms)
                                  .fadeIn(duration: 450.ms)
                                  .slideX(
                                    begin: slideStart * 0.45,
                                    end: 0,
                                    duration: 500.ms,
                                    curve: Curves.easeOutCubic,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SwipeToStartButton extends StatefulWidget {
  const _SwipeToStartButton({required this.onCompleted});

  final VoidCallback onCompleted;

  @override
  State<_SwipeToStartButton> createState() => _SwipeToStartButtonState();
}

class _SwipeToStartButtonState extends State<_SwipeToStartButton>
    with SingleTickerProviderStateMixin {
  static const double _completeThreshold = 0.8;
  static const Duration _settleDuration = Duration(milliseconds: 250);

  bool _completed = false;

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _settleDuration);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details, double maxDrag, bool isRtl) {
    if (_completed || maxDrag <= 0) return;
    _controller.stop();
    final delta = isRtl ? -details.delta.dx : details.delta.dx;
    _controller.value = (_controller.value + delta / maxDrag)
        .clamp(0.0, 1.0)
        .toDouble();
  }

  Future<void> _complete() async {
    if (_completed) return;
    _completed = true;
    unawaited(HapticFeedback.mediumImpact());
    await _controller.animateTo(
      1,
      duration: _settleDuration,
      curve: Curves.easeOutCubic,
    );
    if (mounted) widget.onCompleted();
  }

  Future<void> _onDragEnd(DragEndDetails details) async {
    if (_completed) return;

    if (_controller.value >= _completeThreshold) {
      await _complete();
      return;
    }

    await _controller.animateBack(
      0,
      duration: _settleDuration,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = LanguageManager.isRtl(context);
    final screenHeight = MediaQuery.sizeOf(context).height;
    final buttonHeight = (screenHeight * 0.07).clamp(56.0, 72.0).toDouble();
    const padding = 7.0;
    final knobSize = buttonHeight - padding * 2;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxDrag = (constraints.maxWidth - knobSize - padding * 2)
            .clamp(0.0, double.infinity)
            .toDouble();
        final label = Padding(
          padding: EdgeInsets.symmetric(horizontal: knobSize + 16),
          child: ExcludeSemantics(
            child: Text(
              tr(LocaleKeys.onboardingGetStarted),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: GoogleFonts.tajawal(
                fontSize: 16.sp.clamp(14.0, 20.0).toDouble(),
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
          ),
        );

        return Semantics(
          button: true,
          label: tr(LocaleKeys.onboardingGetStarted),
          onTap: _complete,
          child: Container(
            width: double.infinity,
            height: buttonHeight,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: AnimatedBuilder(
              animation: _controller,
              child: label,
              builder: (context, label) {
                final progress = _controller.value;

                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: (1 - progress * 1.4).clamp(0.0, 1.0).toDouble(),
                      child: label,
                    ),
                    PositionedDirectional(
                      start: padding + progress * maxDrag,
                      top: padding,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onHorizontalDragUpdate: (details) =>
                            _onDragUpdate(details, maxDrag, isRtl),
                        onHorizontalDragEnd: _onDragEnd,
                        child: Container(
                          width: knobSize,
                          height: knobSize,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            isRtl
                                ? Icons.arrow_forward_ios_outlined
                                : Icons.arrow_back_ios_new_outlined,
                            color: AppColors.primary,
                            size: knobSize * 0.3,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
