import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../theme/app_colors.dart';

/// Semantic types for [AppTopSnackBar].
enum AppSnackBarType {
  info,
  success,
  warning,
  error,
}

/// A premium, reusable Top SnackBar / HUD Notification Widget.
///
/// Can be used as a standalone widget in any layout or displayed
/// as a floating top overlay via [AppSnackBar.show].
class AppTopSnackBar extends StatelessWidget {
  const AppTopSnackBar({
    super.key,
    required this.message,
    this.title,
    this.type = AppSnackBarType.info,
    this.onDismiss,
  });

  final String message;
  final String? title;
  final AppSnackBarType type;
  final VoidCallback? onDismiss;

  Color get _accentColor {
    switch (type) {
      case AppSnackBarType.success:
        return AppColors.success;
      case AppSnackBarType.warning:
        return AppColors.warning;
      case AppSnackBarType.error:
        return AppColors.error;
      case AppSnackBarType.info:
        return AppColors.primaryLight;
    }
  }

  IconData get _icon {
    switch (type) {
      case AppSnackBarType.success:
        return Iconsax.tick_circle;
      case AppSnackBarType.warning:
        return Iconsax.warning_2;
      case AppSnackBarType.error:
        return Iconsax.danger;
      case AppSnackBarType.info:
        return Iconsax.info_circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A), // Deep Slate Navy
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: _accentColor.withValues(alpha: 0.35),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _accentColor.withValues(alpha: 0.18),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Glowing Icon Badge
            Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: _accentColor.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: _accentColor.withValues(alpha: 0.25),
                  width: 1,
                ),
              ),
              child: Icon(_icon, size: 20.sp, color: _accentColor),
            ),
            Gap(12.w),

            // Message / Title Text Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title != null && title!.trim().isNotEmpty) ...[
                    Text(
                      title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                    Gap(2.h),
                  ],
                  Text(
                    message,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: title != null
                          ? const Color(0xFFCBD5E1)
                          : Colors.white,
                      fontSize: 12.5.sp,
                      fontWeight:
                          title != null ? FontWeight.w400 : FontWeight.w600,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),

            // Dismiss Button
            if (onDismiss != null) ...[
              Gap(8.w),
              InkWell(
                borderRadius: BorderRadius.circular(20.r),
                onTap: onDismiss,
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Icon(
                    Iconsax.close_circle,
                    size: 18.sp,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Global helper to show the custom [AppTopSnackBar] from anywhere in the app.
abstract final class AppSnackBar {
  static OverlayEntry? _activeEntry;
  static Timer? _activeTimer;
  static _TopSnackBarOverlayWidgetState? _activeState;

  /// Shows a custom top snackbar.
  ///
  /// - [type]: [AppSnackBarType.info], [AppSnackBarType.success],
  ///   [AppSnackBarType.warning], or [AppSnackBarType.error].
  /// - [duration]: Time before auto-dismiss (defaults to 3 seconds).
  static void show(
    BuildContext context, {
    required String message,
    String? title,
    AppSnackBarType type = AppSnackBarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    // Dismiss any existing active snackbar immediately
    dismiss();

    final overlay =
        Overlay.maybeOf(context, rootOverlay: true) ?? Overlay.maybeOf(context);
    if (overlay == null) return;

    late final OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) {
        return _TopSnackBarOverlayWidget(
          message: message,
          title: title,
          type: type,
          onDismiss: () => dismiss(),
          onCreated: (state) => _activeState = state,
        );
      },
    );

    _activeEntry = entry;
    overlay.insert(entry);

    _activeTimer = Timer(duration, () {
      dismiss();
    });
  }

  /// Convenience helper for success notifications.
  static void showSuccess(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      title: title,
      type: AppSnackBarType.success,
      duration: duration,
    );
  }

  /// Convenience helper for error notifications.
  static void showError(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      title: title,
      type: AppSnackBarType.error,
      duration: duration,
    );
  }

  /// Convenience helper for warning notifications.
  static void showWarning(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      title: title,
      type: AppSnackBarType.warning,
      duration: duration,
    );
  }

  /// Convenience helper for info notifications.
  static void showInfo(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      title: title,
      type: AppSnackBarType.info,
      duration: duration,
    );
  }

  /// Dismisses the active top snackbar with reverse animation.
  static void dismiss() {
    _activeTimer?.cancel();
    _activeTimer = null;

    final state = _activeState;
    final entry = _activeEntry;

    _activeState = null;
    _activeEntry = null;

    if (state != null && state.mounted) {
      state.animateOut().then((_) {
        if (entry != null && entry.mounted) {
          entry.remove();
        }
      });
    } else if (entry != null && entry.mounted) {
      entry.remove();
    }
  }
}

/// Internal animated container for the overlay entry.
class _TopSnackBarOverlayWidget extends StatefulWidget {
  const _TopSnackBarOverlayWidget({
    required this.message,
    this.title,
    required this.type,
    required this.onDismiss,
    required this.onCreated,
  });

  final String message;
  final String? title;
  final AppSnackBarType type;
  final VoidCallback onDismiss;
  final void Function(_TopSnackBarOverlayWidgetState state) onCreated;

  @override
  _TopSnackBarOverlayWidgetState createState() =>
      _TopSnackBarOverlayWidgetState();
}

class _TopSnackBarOverlayWidgetState extends State<_TopSnackBarOverlayWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    widget.onCreated(this);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
      reverseDuration: const Duration(milliseconds: 240),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
        reverseCurve: Curves.easeInCubic,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
    );

    _controller.forward();
  }

  Future<void> animateOut() async {
    if (!mounted) return;
    await _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top + 10.h;

    return Positioned(
      top: topPadding,
      left: 0,
      right: 0,
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          // Swipe up to dismiss immediately
          if (details.primaryDelta != null && details.primaryDelta! < -4) {
            widget.onDismiss();
          }
        },
        child: SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: AppTopSnackBar(
              message: widget.message,
              title: widget.title,
              type: widget.type,
              onDismiss: widget.onDismiss,
            ),
          ),
        ),
      ),
    );
  }
}
