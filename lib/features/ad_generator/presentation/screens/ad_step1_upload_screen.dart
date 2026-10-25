import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/localization/language_manager.dart';
import '../../../../core/localization/locale_keys.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../controllers/ad_step1_cubit.dart';
import '../controllers/ad_step1_state.dart';
import '../widgets/ad_image_action_buttons.dart';
import '../widgets/selected_images_preview.dart';
import '../widgets/step_progress_indicator.dart';
import '../widgets/upload_dropzone_card.dart';

/// Screen: Step 1 of the Ad Creation Flow (Upload Product Photos).
///
/// Features:
/// - Clean Architecture compliant: delegates state & logic to [AdStep1Cubit]
/// - Dynamic image picking from Gallery and Camera via domain use cases
/// - Primary hero card previewing 1st image or empty dashed dropzone
/// - Preview thumbnails with quick remove actions
/// - Directional RTL/LTR safe navigation and typography
/// - Responsive sizing with flutter_screenutil and AppColors tokens
class AdStep1UploadScreen extends StatelessWidget {
  const AdStep1UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdStep1Cubit>(
      create: (_) => sl<AdStep1Cubit>(),
      child: const _AdStep1UploadView(),
    );
  }
}

class _AdStep1UploadView extends StatelessWidget {
  const _AdStep1UploadView();

  void _onStateNotice(BuildContext context, AdStep1State state) {
    switch (state.notice) {
      case AdStep1Notice.maxImagesLimitReached:
        AppSnackBar.showWarning(
          context,
          message: tr(LocaleKeys.adMaxImagesLimit),
        );
      case AdStep1Notice.imagesAddedSuccessfully:
        AppSnackBar.showSuccess(
          context,
          message: tr(LocaleKeys.adImagesAdded),
        );
      case AdStep1Notice.photoCapturedSuccessfully:
        AppSnackBar.showSuccess(
          context,
          message: tr(LocaleKeys.adPhotoCaptured),
        );
      case AdStep1Notice.atLeastOneImageRequired:
        AppSnackBar.showWarning(
          context,
          message: tr(LocaleKeys.adSelectAtLeastOneImage),
        );
      case AdStep1Notice.nextStepUnavailable:
        AppSnackBar.showInfo(
          context,
          message: tr(LocaleKeys.adNextStepUnavailable),
        );
      case AdStep1Notice.galleryFailed:
        AppSnackBar.showError(
          context,
          message: tr(LocaleKeys.adGalleryError),
        );
      case AdStep1Notice.cameraFailed:
        AppSnackBar.showError(
          context,
          message: tr(LocaleKeys.adCameraError),
        );
      case AdStep1Notice.none:
        break;
    }

    if (state.notice != AdStep1Notice.none) {
      context.read<AdStep1Cubit>().clearNotice();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = LanguageManager.isRtl(context);

    return BlocConsumer<AdStep1Cubit, AdStep1State>(
      listenWhen: (previous, current) =>
          previous.notice != current.notice &&
          current.notice != AdStep1Notice.none,
      listener: _onStateNotice,
      builder: (context, state) {
        final cubit = context.read<AdStep1Cubit>();

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              children: [
                // Top App Bar with back navigation and centered progress stepper
                _buildTopAppBar(context, isRtl),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(20.h),
                        // Title
                        Text(
                          tr(LocaleKeys.adStep1Title),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: AppColors.darkNeutral,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.3,
                              ),
                        ),
                        Gap(8.h),

                        // Subtitle
                        Text(
                          tr(LocaleKeys.adStep1Subtitle),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.45,
                              ),
                        ),
                        Gap(20.h),

                        // Hero Dropzone Card
                        UploadDropzoneCard(
                          primaryImage: state.primaryImage,
                          onTap: cubit.pickFromGallery,
                        ),
                        Gap(16.h),

                        // Dual Action Buttons (Camera & Gallery)
                        AdImageActionButtons(
                          onPickGallery: cubit.pickFromGallery,
                          onTakePhoto: cubit.capturePhoto,
                          isLoading: state.isLoading,
                        ),
                        Gap(24.h),

                        // Selected Images Section with thumbnails and delete badges
                        SelectedImagesPreview(
                          images: state.images,
                          onRemove: (index) {
                            unawaited(HapticFeedback.lightImpact());
                            cubit.removeImage(index);
                          },
                          onAddTap: cubit.pickFromGallery,
                        ),
                        Gap(24.h),
                      ],
                    ),
                  ),
                ),

                // Bottom Next CTA Button
                _buildBottomNextButton(context, state, isRtl),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopAppBar(BuildContext context, bool isRtl) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(14.w, 8.h, 14.w, 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Navigation Button
          Material(
            color: AppColors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12.r),
              onTap: () => Navigator.of(context).maybePop(),
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Icon(
                  isRtl ? Iconsax.arrow_right_3 : Iconsax.arrow_left_2,
                  size: 22.sp,
                  color: AppColors.darkNeutral,
                ),
              ),
            ),
          ),

          // 3-Step Numbered Progress Stepper
          const StepProgressIndicator(currentStep: 1, totalSteps: 3),

          // Spacer to keep stepper centered
          SizedBox(width: 40.w),
        ],
      ),
    );
  }

  Widget _buildBottomNextButton(
    BuildContext context,
    AdStep1State state,
    bool isRtl,
  ) {
    final cubit = context.read<AdStep1Cubit>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Material(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(14.r),
        elevation: 2,
        shadowColor: AppColors.primary.withValues(alpha: 0.3),
        child: InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: state.isLoading ? null : cubit.validateAndProceed,
          child: Container(
            height: 52.h,
            width: double.infinity,
            alignment: Alignment.center,
            child: state.isLoading
                ? SizedBox(
                    width: 22.w,
                    height: 22.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2.2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tr(LocaleKeys.next),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppColors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      Gap(8.w),
                      Icon(
                        isRtl ? Iconsax.arrow_left : Iconsax.arrow_right,
                        size: 18.sp,
                        color: AppColors.white,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
