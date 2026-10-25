import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/theme/app_colors.dart';

/// Stepper progress indicator for multi-step ad creation workflows.
class StepProgressIndicator extends StatelessWidget {
  const StepProgressIndicator({
    super.key,
    required this.currentStep,
    this.totalSteps = 3,
  })  : assert(totalSteps > 0),
        assert(currentStep >= 1 && currentStep <= totalSteps);

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var step = 1; step <= totalSteps; step++) ...[
          if (step > 1) _buildConnector(isPassed: step <= currentStep),
          _buildCircle(
            context,
            step: step,
            isActive: step == currentStep,
            isCompleted: step < currentStep,
          ),
        ],
      ],
    );
  }

  Widget _buildCircle(
    BuildContext context, {
    required int step,
    required bool isActive,
    required bool isCompleted,
  }) {
    final circleSize = 34.w;

    return Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: (isActive || isCompleted) ? AppColors.primary : AppColors.slate100,
      ),
      child: Center(
        child: isCompleted
            ? Icon(
                Iconsax.tick_circle,
                size: 16.sp,
                color: AppColors.white,
              )
            : Text(
                '$step',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: isActive ? AppColors.white : AppColors.textSecondary,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }

  Widget _buildConnector({required bool isPassed}) {
    return Container(
      width: 40.w,
      height: 2.5.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: isPassed ? AppColors.primary : AppColors.border,
        borderRadius: BorderRadius.circular(99.r),
      ),
    );
  }
}
