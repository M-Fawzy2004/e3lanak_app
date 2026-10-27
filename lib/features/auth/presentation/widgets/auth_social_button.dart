import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';

enum AuthSocialType { google, apple }

class AuthSocialButton extends StatelessWidget {
  final AuthSocialType type;
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const AuthSocialButton({
    super.key,
    required this.type,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  static const String _googleSvg = '''
<svg viewBox="0 0 24 24" width="24" height="24">
  <path fill="#4285F4" d="M23.745 12.27c0-.7-.06-1.4-.19-2.07H12v4.51h6.6c-.29 1.52-1.14 2.8-2.4 3.66v3.05h3.88c2.27-2.09 3.66-5.17 3.66-9.15z"/>
  <path fill="#34A853" d="M12 24c3.24 0 5.95-1.08 7.93-2.91l-3.88-3.05c-1.08.72-2.45 1.16-4.05 1.16-3.12 0-5.77-2.1-6.72-4.93H1.25v3.15C3.26 21.36 7.33 24 12 24z"/>
  <path fill="#FBBC05" d="M5.28 14.27a7.2 7.2 0 0 1 0-4.54V6.58H1.25a11.97 11.97 0 0 0 0 10.84l4.03-3.15z"/>
  <path fill="#EA4335" d="M12 4.75c1.77 0 3.35.61 4.6 1.8l3.42-3.42C17.95 1.19 15.24 0 12 0 7.33 0 3.26 2.64 1.25 6.58l4.03 3.15c.95-2.83 3.6-4.98 6.72-4.98z"/>
</svg>
''';

  static const String _appleSvg = '''
<svg viewBox="0 0 170 170" width="22" height="22" fill="currentColor">
  <path d="M150.37 130.25c-2.45 5.66-5.35 10.87-8.71 15.66-4.58 6.53-8.33 11.05-11.22 13.56-4.48 4.12-9.28 6.23-14.42 6.35-3.69 0-8.14-1.05-13.32-3.18-5.19-2.12-9.97-3.17-14.34-3.17-4.58 0-9.49 1.05-14.75 3.17-5.26 2.13-9.5 3.24-12.74 3.35-4.35.13-9.16-1.9-14.42-6.08-3.7-3.04-7.6-7.85-11.71-14.43-6.52-10.45-11.75-22.02-15.69-34.72-3.94-12.7-5.91-24.59-5.91-35.68 0-14.9 3.58-27.14 10.74-36.72 7.16-9.58 16.32-14.44 27.48-14.57 5.23 0 10.73 1.34 16.51 4.02 5.78 2.68 9.77 4.07 11.96 4.17 1.74 0 5.8-1.4 12.18-4.2 6.38-2.8 11.89-4.07 16.51-3.8 12.3.67 22.18 5.48 29.62 14.44-10.74 6.5-16.03 15.54-15.86 27.13.17 9.17 3.68 16.92 10.53 23.25 6.84 6.33 14.89 9.88 24.14 10.66-2.13 6.78-4.78 13.78-7.95 21zM119.22 31.84c0-7.39 2.65-14.28 7.95-20.67 5.3-6.39 11.78-10.28 19.45-11.17.43 1.13.65 2.23.65 3.3 0 7.39-2.73 14.44-8.19 21.15-5.46 6.71-12 10.68-19.63 11.91-.12-1.52-.23-3.03-.23-4.52z"/>
</svg>
''';

  @override
  Widget build(BuildContext context) {
    final isGoogle = type == AuthSocialType.google;
    final backgroundColor = isGoogle ? AppColors.white : AppColors.darkNeutral;
    final textColor = isGoogle ? AppColors.darkNeutral : AppColors.white;
    final borderColor = isGoogle ? AppColors.slate200 : AppColors.transparent;

    return Semantics(
      button: true,
      label: text,
      enabled: !isLoading,
      child: Container(
        width: double.infinity,
        height: 52.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(28.r),
          border: Border.all(color: borderColor, width: 1.2),
          boxShadow: isGoogle
              ? [
                  BoxShadow(
                    color: AppColors.slate200.withValues(alpha: 0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: AppColors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(28.r),
            onTap: isLoading ? null : onPressed,
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 22.w,
                      height: 22.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.2,
                        valueColor: AlwaysStoppedAnimation<Color>(textColor),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 22.w,
                          height: 22.w,
                          child: SvgPicture.string(
                            isGoogle ? _googleSvg : _appleSvg,
                            colorFilter: isGoogle
                                ? null
                                : ColorFilter.mode(textColor, BlendMode.srcIn),
                            fit: BoxFit.contain,
                          ),
                        ),
                        Gap(12.w),
                        Text(
                          text,
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: textColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.5.sp,
                                  ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
