import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/localization/locale_keys.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../controllers/auth_cubit.dart';
import '../controllers/auth_state.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_social_button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => sl<AuthCubit>(),
      child: const _AuthScreenView(),
    );
  }
}

class _AuthScreenView extends StatelessWidget {
  const _AuthScreenView();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.isAuthenticated) {
                Navigator.of(context).pushReplacementNamed(AppRoutes.main);
              } else if (state.status == AuthStatus.failure &&
                  state.errorMessage != null) {
                AppSnackBar.showError(
                  context,
                  message: tr(state.errorMessage!),
                );
              }
            },
            builder: (context, state) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final screenHeight = constraints.maxHeight;
                  final isCompact = screenHeight < 680;
                  final illustrationHeight = isCompact ? 190.h : 240.h;

                  return SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: screenHeight),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                            horizontal: 24.w,
                            vertical: 20.h,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const AuthHeader(),
                                Gap(12.h),
                                SizedBox(
                                  height: illustrationHeight,
                                  width: double.infinity,
                                  child: Image.asset(
                                    AppAssets.authImage,
                                    fit: BoxFit.contain,
                                    alignment: Alignment.center,
                                  )
                                      .animate()
                                      .fadeIn(duration: 500.ms)
                                      .scale(
                                        begin: const Offset(0.95, 0.95),
                                        end: const Offset(1, 1),
                                        duration: 600.ms,
                                        curve: Curves.easeOutCubic,
                                      ),
                                ),
                                Gap(14.h),
                                Text(
                                  tr(LocaleKeys.authSignInPrompt),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: AppColors.slate700,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15.sp,
                                      ),
                                )
                                    .animate(delay: 150.ms)
                                    .fadeIn(duration: 400.ms)
                                    .slideY(
                                      begin: 0.1,
                                      end: 0,
                                      curve: Curves.easeOutCubic,
                                    ),
                                Gap(16.h),
                                AuthSocialButton(
                                  type: AuthSocialType.google,
                                  text: tr(LocaleKeys.authContinueWithGoogle),
                                  isLoading: state.isGoogleLoading,
                                  onPressed: () => context
                                      .read<AuthCubit>()
                                      .signInWithGoogle(),
                                )
                                    .animate(delay: 200.ms)
                                    .fadeIn(duration: 450.ms)
                                    .slideY(
                                      begin: 0.1,
                                      end: 0,
                                      curve: Curves.easeOutCubic,
                                    ),
                                Gap(12.h),
                                AuthSocialButton(
                                  type: AuthSocialType.apple,
                                  text: tr(LocaleKeys.authContinueWithApple),
                                  isLoading: state.isAppleLoading,
                                  onPressed: () => context
                                      .read<AuthCubit>()
                                      .signInWithApple(),
                                )
                                    .animate(delay: 250.ms)
                                    .fadeIn(duration: 450.ms)
                                    .slideY(
                                      begin: 0.1,
                                      end: 0,
                                      curve: Curves.easeOutCubic,
                                    ),
                                Gap(18.h),
                                Semantics(
                                  button: true,
                                  label: tr(LocaleKeys.authBrowseAsGuest),
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      context
                                          .read<AuthCubit>()
                                          .continueAsGuest();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 6.h,
                                        horizontal: 16.w,
                                      ),
                                      child: Text(
                                        tr(LocaleKeys.authBrowseAsGuest),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15.sp,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor:
                                                  AppColors.primary,
                                              decorationThickness: 2.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                )
                                    .animate(delay: 300.ms)
                                    .fadeIn(duration: 400.ms),
                              Gap(16.h),
                              Text(
                                tr(LocaleKeys.authTermsNotice),
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AppColors.slate400,
                                      fontSize: 10.5.sp,
                                      height: 1.4,
                                    ),
                              )
                                  .animate(delay: 350.ms)
                                  .fadeIn(duration: 400.ms),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
