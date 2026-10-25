import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/localization/locale_keys.dart';
import '../../../../core/theme/app_colors.dart';

/// Interactive manual category entry field for categories outside the default grid.
class AdCustomCategoryField extends StatefulWidget {
  const AdCustomCategoryField({
    super.key,
    required this.isActive,
    required this.currentText,
    required this.onTap,
    required this.onChanged,
  });

  final bool isActive;
  final String currentText;
  final VoidCallback onTap;
  final ValueChanged<String> onChanged;

  @override
  State<AdCustomCategoryField> createState() => _AdCustomCategoryFieldState();
}

class _AdCustomCategoryFieldState extends State<AdCustomCategoryField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentText);
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant AdCustomCategoryField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentText != _controller.text) {
      _controller.text = widget.currentText;
    }
    if (widget.isActive && !oldWidget.isActive) {
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      height: 54.h,
      decoration: BoxDecoration(
        color: widget.isActive ? AppColors.primarySurface : AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: widget.isActive ? AppColors.primary : AppColors.border,
          width: widget.isActive ? 1.8 : 1.2,
        ),
        boxShadow: widget.isActive
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ]
            : [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.02),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Material(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(14.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: () {
            unawaited(HapticFeedback.selectionClick());
            widget.onTap();
            _focusNode.requestFocus();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              children: [
                // Badge icon
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: widget.isActive
                        ? AppColors.primary
                        : AppColors.slate100,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Iconsax.add,
                        size: 14.sp,
                        color: widget.isActive
                            ? AppColors.white
                            : AppColors.darkNeutral,
                      ),
                      Gap(4.w),
                      Text(
                        tr(LocaleKeys.adCatOther),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: widget.isActive
                                  ? AppColors.white
                                  : AppColors.darkNeutral,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
                Gap(10.w),

                // Text field
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    onTap: widget.onTap,
                    onChanged: widget.onChanged,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.darkNeutral,
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w600,
                        ),
                    decoration: InputDecoration(
                      hintText: tr(LocaleKeys.adCatCustomHint),
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.slate400,
                                fontSize: 13.sp,
                              ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        )
        .slideY(
          begin: 0.1,
          end: 0,
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
        );
  }
}
