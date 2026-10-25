import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';

/// Reusable input field component for Ad Generator forms with label, required asterisk,
/// optional currency indicator, counter, and error styling.
class AdLabeledTextField extends StatelessWidget {
  const AdLabeledTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.isRequired = false,
    this.currencyText,
    this.maxLength,
    this.currentLength,
    this.maxLines = 1,
    this.minLines,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.hasError = false,
    this.onChanged,
  });

  final String label;
  final bool isRequired;
  final TextEditingController controller;
  final String hintText;
  final String? currencyText;
  final int? maxLength;
  final int? currentLength;
  final int maxLines;
  final int? minLines;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool hasError;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with optional required asterisk
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.darkNeutral,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            if (isRequired) ...[
              Gap(4.w),
              Text(
                '*',
                style: TextStyle(
                  color: AppColors.error,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        ),
        Gap(8.h),

        // Text field container
        Container(
          height: maxLines == 1 ? 52.h : null,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: hasError ? AppColors.error : AppColors.border,
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              if (currencyText != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Text(
                    currencyText!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.darkNeutral,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  inputFormatters: inputFormatters,
                  maxLength: maxLength,
                  maxLines: maxLines,
                  minLines: minLines,
                  onChanged: onChanged,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.darkNeutral,
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w600,
                        height: maxLines > 1 ? 1.45 : null,
                      ),
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: hintText,
                    hintStyle:
                        Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.slate400,
                              fontSize: 13.5.sp,
                              height: maxLines > 1 ? 1.45 : null,
                            ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: maxLines > 1 ? 12.h : 14.h,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Character counter below field
        if (maxLength != null && currentLength != null) ...[
          Gap(4.h),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              '$currentLength/$maxLength',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 11.5.sp,
                  ),
            ),
          ),
        ],
      ],
    );
  }
}
