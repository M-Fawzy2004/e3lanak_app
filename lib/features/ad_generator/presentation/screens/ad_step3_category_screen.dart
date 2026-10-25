import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/localization/language_manager.dart';
import '../../../../core/localization/locale_keys.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../domain/entities/ad_category.dart';
import '../controllers/ad_step3_cubit.dart';
import '../controllers/ad_step3_state.dart';
import '../widgets/ad_category_card.dart';
import '../widgets/ad_custom_category_field.dart';
import '../widgets/ad_generate_cta_button.dart';
import '../widgets/step_progress_indicator.dart';

/// Screen: Step 3 of Ad Creation Flow (Activity & Product Category Selection).
class AdStep3CategoryScreen extends StatelessWidget {
  const AdStep3CategoryScreen({super.key});

  static const List<AdCategory> _predefinedCategories = [
    AdCategory(
      id: 'electronics',
      titleKey: LocaleKeys.adCatElectronics,
      icon: Iconsax.mobile,
    ),
    AdCategory(
      id: 'clothing',
      titleKey: LocaleKeys.adCatClothing,
      icon: Iconsax.shop,
    ),
    AdCategory(
      id: 'restaurants',
      titleKey: LocaleKeys.adCatRestaurants,
      icon: Iconsax.coffee,
    ),
    AdCategory(
      id: 'services',
      titleKey: LocaleKeys.adCatServices,
      icon: Iconsax.setting_2,
    ),
    AdCategory(
      id: 'furniture',
      titleKey: LocaleKeys.adCatFurniture,
      icon: Iconsax.home_2,
    ),
    AdCategory(
      id: 'beauty',
      titleKey: LocaleKeys.adCatBeauty,
      icon: Iconsax.heart,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdStep3Cubit>(
      create: (_) => sl<AdStep3Cubit>(),
      child: const _AdStep3CategoryView(),
    );
  }
}

class _AdStep3CategoryView extends StatelessWidget {
  const _AdStep3CategoryView();

  void _onStateNotice(BuildContext context, AdStep3State state) {
    if (state.notice == AdStep3Notice.categoryRequired) {
      AppSnackBar.showWarning(
        context,
        message: tr(LocaleKeys.adSelectCategoryRequired),
      );
    } else if (state.notice == AdStep3Notice.generationStarted) {
      AppSnackBar.showSuccess(
        context,
        message: tr(LocaleKeys.adGeneratingStatus),
      );
    }

    if (state.notice != AdStep3Notice.none) {
      context.read<AdStep3Cubit>().clearNotice();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = LanguageManager.isRtl(context);

    return BlocConsumer<AdStep3Cubit, AdStep3State>(
      listenWhen: (previous, current) =>
          previous.notice != current.notice &&
          current.notice != AdStep3Notice.none,
      listener: _onStateNotice,
      builder: (context, state) {
        final cubit = context.read<AdStep3Cubit>();

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
                                tr(LocaleKeys.adStep3Title),
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
                                tr(LocaleKeys.adStep3Subtitle),
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

                        // Section Header
                        Text(
                          tr(LocaleKeys.adSectionCategories),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                color: AppColors.darkNeutral,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        Gap(12.h),

                        // 3x2 Grid of Animated Category Cards
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 12.h,
                            crossAxisSpacing: 12.w,
                            childAspectRatio: 0.88,
                          ),
                          itemCount:
                              AdStep3CategoryScreen._predefinedCategories.length,
                          itemBuilder: (context, index) {
                            final category = AdStep3CategoryScreen
                                ._predefinedCategories[index];
                            final isSelected = !state.isCustomActive &&
                                state.selectedCategoryId == category.id;

                            return AdCategoryCard(
                              category: category,
                              isSelected: isSelected,
                              animationDelay: Duration(milliseconds: index * 60),
                              onTap: () => cubit.selectCategory(category.id),
                            );
                          },
                        ),
                        Gap(14.h),

                        // Custom / Manual Category Field
                        AdCustomCategoryField(
                          isActive: state.isCustomActive,
                          currentText: state.customCategoryText,
                          onTap: cubit.activateCustomCategory,
                          onChanged: cubit.setCustomCategoryText,
                        ),
                        Gap(24.h),

                        // In-page Bottom Primary CTA
                        AdGenerateCtaButton(
                          isLoading: state.isGenerating,
                          onTap: cubit.generateAd,
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
          const StepProgressIndicator(currentStep: 3, totalSteps: 3),
          SizedBox(width: 40.w),
        ],
      ),
    );
  }
}
