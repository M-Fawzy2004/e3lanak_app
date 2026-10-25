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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Label
        Text(
          tr(LocaleKeys.adCatOtherLabel),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.darkNeutral,
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w700,
              ),
        ),
        Gap(8.h),

        // Text field container matching Step 2 design
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          height: 52.h,
          decoration: BoxDecoration(
            color: widget.isActive
                ? AppColors.primarySurface.withValues(alpha: 0.35)
                : AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: widget.isActive ? AppColors.primary : AppColors.border,
              width: widget.isActive ? 1.6 : 1.2,
            ),
            boxShadow: widget.isActive
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.02),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Material(
            color: AppColors.transparent,
            borderRadius: BorderRadius.circular(12.r),
            child: InkWell(
              borderRadius: BorderRadius.circular(12.r),
              onTap: () {
                unawaited(HapticFeedback.selectionClick());
                widget.onTap();
                _focusNode.requestFocus();
              },
              child: Row(
                children: [
                  // Prefix Icon Container
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: 12.w,
                      end: 10.w,
                    ),
                    child: Container(
                      width: 32.w,
                      height: 32.w,
                      decoration: BoxDecoration(
                        color: widget.isActive
                            ? AppColors.primary
                            : AppColors.slate100,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Icon(
                          Iconsax.edit_2,
                          size: 16.sp,
                          color: widget.isActive
                              ? AppColors.white
                              : AppColors.darkNeutral,
                        ),
                      ),
                    ),
                  ),

                  // Text Field
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      onTap: () {
                        widget.onTap();
                        _focusNode.requestFocus();
                      },
                      onChanged: (val) {
                        setState(() {});
                        widget.onChanged(val);
                      },
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.darkNeutral,
                            fontSize: 14.sp,
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

                  // Optional clear button
                  if (_controller.text.isNotEmpty && widget.isActive)
                    IconButton(
                      icon: Icon(
                        Icons.close_rounded,
                        size: 18.sp,
                        color: AppColors.slate400,
                      ),
                      onPressed: () {
                        _controller.clear();
                        setState(() {});
                        widget.onChanged('');
                      },
                    )
                  else
                    Gap(12.w),
                ],
              ),
            ),
          ),
        ),
      ],
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
