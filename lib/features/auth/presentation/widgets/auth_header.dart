import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/localization/locale_keys.dart';
import '../../../../core/theme/app_colors.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  static const String _megaphoneSvg = '''
<svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
  <g transform="rotate(-20 32 32)">
    <path d="M42 16L24 25H16C13.7909 25 12 26.7909 12 29V35C12 37.2091 13.7909 39 16 39H24L42 48C43.8 48.9 46 47.6 46 45.6V18.4C46 16.4 43.8 15.1 42 16Z" fill="currentColor"/>
    <path d="M22 39V49C22 51.2 20.2 53 18 53C15.8 53 14 51.2 14 49V39" stroke="currentColor" stroke-width="4.5" stroke-linecap="round" stroke-linejoin="round"/>
    <rect x="44" y="17" width="4.5" height="30" rx="2.25" fill="currentColor"/>
    <path d="M52 24C53.8 26.2 55 29 55 32C55 35 53.8 37.8 52 40" stroke="currentColor" stroke-width="3.5" stroke-linecap="round"/>
    <path d="M58 19C61 22.8 63 27.2 63 32C63 36.8 61 41.2 58 45" stroke="currentColor" stroke-width="3.5" stroke-linecap="round"/>
  </g>
</svg>
''';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 52.w,
          height: 52.w,
          child: SvgPicture.string(
            _megaphoneSvg,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryDark,
              BlendMode.srcIn,
            ),
            fit: BoxFit.contain,
          ),
        )
            .animate()
            .fadeIn(duration: 450.ms)
            .scale(
              begin: const Offset(0.85, 0.85),
              end: const Offset(1, 1),
              curve: Curves.easeOutCubic,
              duration: 500.ms,
            ),
        Gap(12.h),
        Text(
          tr(LocaleKeys.authTitle),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.darkNeutral,
                fontSize: 27.sp,
                letterSpacing: -0.3,
              ),
        )
            .animate(delay: 80.ms)
            .fadeIn(duration: 400.ms)
            .slideY(begin: 0.15, end: 0, curve: Curves.easeOutCubic),
        Gap(6.h),
        Text(
          tr(LocaleKeys.authSubtitle),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.slate500,
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w500,
                height: 1.35,
              ),
        )
            .animate(delay: 140.ms)
            .fadeIn(duration: 400.ms)
            .slideY(begin: 0.15, end: 0, curve: Curves.easeOutCubic),
      ],
    );
  }
}
