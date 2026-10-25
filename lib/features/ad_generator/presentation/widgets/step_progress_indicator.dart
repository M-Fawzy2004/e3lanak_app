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
  }) : assert(totalSteps > 0),
       assert(currentStep >= 1 && currentStep <= totalSteps);

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(99.r),
        border: Border.all(
          color: AppColors.slate200.withValues(alpha: 0.9),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
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
      ),
    );
  }

  Widget _buildCircle(
    BuildContext context, {
    required int step,
    required bool isActive,
    required bool isCompleted,
  }) {
    final circleSize = 28.w;

    return Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: (isActive || isCompleted)
            ? AppColors.primary
            : AppColors.slate100,
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.35),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Center(
        child: isCompleted
            ? Icon(Iconsax.tick_circle, size: 15.sp, color: AppColors.white)
            : Text(
                '$step',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: isActive ? AppColors.white : AppColors.slate400,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }

  Widget _buildConnector({required bool isPassed}) {
    return Container(
      width: 22.w,
      height: 2.5.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: isPassed ? AppColors.primary : AppColors.slate200,
        borderRadius: BorderRadius.circular(99.r),
      ),
    );
  }
}
