import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/localization/language_manager.dart';
import '../../../../core/localization/locale_keys.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../controllers/ad_step2_cubit.dart';
import '../controllers/ad_step2_state.dart';
import '../widgets/ad_labeled_text_field.dart';
import '../widgets/ad_savings_badge.dart';
import '../widgets/ad_step2_bottom_actions.dart';
import '../widgets/step_progress_indicator.dart';

/// Screen: Step 2 of Ad Creation Flow (Product Details and Pricing).
class AdStep2DetailsScreen extends StatelessWidget {
  const AdStep2DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdStep2Cubit>(
      create: (_) => sl<AdStep2Cubit>(),
      child: const _AdStep2DetailsView(),
    );
  }
}

class _AdStep2DetailsView extends StatefulWidget {
  const _AdStep2DetailsView();

  @override
  State<_AdStep2DetailsView> createState() => _AdStep2DetailsViewState();
}

class _AdStep2DetailsViewState extends State<_AdStep2DetailsView> {
  late final TextEditingController _productNameController;
  late final TextEditingController _originalPriceController;
  late final TextEditingController _discountPriceController;
  late final TextEditingController _brandFeaturesController;

  @override
  void initState() {
    super.initState();
    _productNameController = TextEditingController();
    _originalPriceController = TextEditingController();
    _discountPriceController = TextEditingController();
    _brandFeaturesController = TextEditingController();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _originalPriceController.dispose();
    _discountPriceController.dispose();
    _brandFeaturesController.dispose();
    super.dispose();
  }

  void _onStateNotice(BuildContext context, AdStep2State state) {
    if (state.notice == AdStep2Notice.validationError) {
      if (!state.isProductNameValid) {
        AppSnackBar.showWarning(
          context,
          message: tr(LocaleKeys.adProductNameRequired),
        );
      } else if (!state.isOriginalPriceValid) {
        AppSnackBar.showWarning(
          context,
          message: tr(LocaleKeys.adOriginalPriceRequired),
        );
      } else if (!state.isDiscountPriceValid) {
        AppSnackBar.showWarning(
          context,
          message: tr(LocaleKeys.adDiscountPriceInvalid),
        );
      }
    } else if (state.notice == AdStep2Notice.stepCompleted) {
      Navigator.of(context).pushNamed(AppRoutes.adGeneratorStep3);
    }

    if (state.notice != AdStep2Notice.none) {
      context.read<AdStep2Cubit>().clearNotice();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = LanguageManager.isRtl(context);

    return BlocConsumer<AdStep2Cubit, AdStep2State>(
      listenWhen: (previous, current) =>
          previous.notice != current.notice &&
          current.notice != AdStep2Notice.none,
      listener: _onStateNotice,
      builder: (context, state) {
        final cubit = context.read<AdStep2Cubit>();

        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              children: [
                _buildTopAppBar(context, isRtl),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(20.h),
                        // Centered Title & Subtitle
                        Center(
                          child: Column(
                            children: [
                              Text(
                                tr(LocaleKeys.adStep2Title),
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      color: AppColors.darkNeutral,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                              Gap(8.h),
                              Text(
                                tr(LocaleKeys.adStep2Subtitle),
                                textAlign: TextAlign.center,
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
                            ],
                          ),
                        ),
                        Gap(22.h),

                        // 1. Product Name Field
                        AdLabeledTextField(
                          label: tr(LocaleKeys.adProductNameLabel),
                          isRequired: true,
                          controller: _productNameController,
                          hintText: tr(LocaleKeys.adProductNameHint),
                          maxLength: AdStep2State.maxProductNameLength,
                          currentLength: state.productName.length,
                          hasError: state.showValidationErrors &&
                              !state.isProductNameValid,
                          onChanged: cubit.setProductName,
                        ),
                        Gap(16.h),

                        // 2. Original Price Field
                        AdLabeledTextField(
                          label: tr(LocaleKeys.adOriginalPriceLabel),
                          isRequired: true,
                          controller: _originalPriceController,
                          hintText: tr(LocaleKeys.adOriginalPriceHint),
                          currencyText: tr(LocaleKeys.adCurrencyEgp),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*'),
                            ),
                          ],
                          hasError: state.showValidationErrors &&
                              !state.isOriginalPriceValid,
                          onChanged: cubit.setOriginalPrice,
                        ),
                        Gap(16.h),

                        // 3. Discount Price Field (Optional)
                        AdLabeledTextField(
                          label: tr(LocaleKeys.adDiscountPriceLabel),
                          isRequired: false,
                          controller: _discountPriceController,
                          hintText: tr(LocaleKeys.adDiscountPriceHint),
                          currencyText: tr(LocaleKeys.adCurrencyEgp),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*'),
                            ),
                          ],
                          hasError: state.showValidationErrors &&
                              !state.isDiscountPriceValid,
                          onChanged: cubit.setDiscountPrice,
                        ),

                        // Dynamic Savings Percentage Badge
                        if (state.savingsPercentage != null) ...[
                          Gap(10.h),
                          AdSavingsBadge(percentage: state.savingsPercentage!),
                        ],
                        Gap(16.h),

                        // 4. Additional Brand Features Field (Optional)
                        AdLabeledTextField(
                          label: tr(LocaleKeys.adBrandFeaturesLabel),
                          isRequired: false,
                          controller: _brandFeaturesController,
                          hintText: tr(LocaleKeys.adBrandFeaturesHint),
                          maxLines: 6,
                          minLines: 4,
                          maxLength: AdStep2State.maxBrandFeaturesLength,
                          currentLength: state.brandFeatures.length,
                          onChanged: cubit.setBrandFeatures,
                        ),
                        Gap(24.h),

                        // In-page Bottom Action Buttons
                        AdStep2BottomActions(
                          onNext: cubit.validateAndProceed,
                          onPrevious: () => Navigator.of(context).maybePop(),
                        ),
                        Gap(24.h),
                      ],
                    ),
                  ),
                ),
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
          Material(
            color: AppColors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12.r),
              onTap: () => Navigator.of(context).maybePop(),
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Icon(
                  isRtl ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                  size: 22.sp,
                  color: AppColors.darkNeutral,
                ),
              ),
            ),
          ),
          const StepProgressIndicator(currentStep: 2, totalSteps: 3),
          SizedBox(width: 40.w),
        ],
      ),
    );
  }
}
