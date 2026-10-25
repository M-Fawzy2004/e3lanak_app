import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/localization/locale_keys.dart';
import '../widgets/home_header.dart';
import '../widgets/marketing_tip_banner.dart';
import '../widgets/other_tools_section.dart';
import '../widgets/platform_action_card.dart';
import '../widgets/recent_ads_section.dart';
import '../widgets/trending_templates_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // Top Header Greeting
            SliverToBoxAdapter(
              child: const HomeHeader()
                  .animate()
                  .fadeIn(duration: 350.ms)
                  .slideY(begin: -0.05, end: 0, curve: Curves.easeOut),
            ),

            // Daily AI Smart Tip Banner (Placed immediately after header)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                child: const MarketingTipBanner(),
              ),
            ),

            // 2x2 Grid for the 4 Main Platform Cards
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              sliver: SliverGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 1.1,
                children: const [
                  PlatformActionCard(
                    assetPath: AppAssets.iconFacebook,
                    titleKey: LocaleKeys.homeActionFacebookTitle,
                    descKey: LocaleKeys.homeActionFacebookDesc,
                    borderColors: [
                      Color(0xFF1877F2),
                      Color(0x301877F2),
                      Color(0x001877F2),
                      Color(0x501877F2),
                      Color(0xFF1877F2),
                    ],
                  ),
                  PlatformActionCard(
                    assetPath: AppAssets.iconTiktok,
                    titleKey: LocaleKeys.homeActionTiktokTitle,
                    descKey: LocaleKeys.homeActionTiktokDesc,
                    borderColors: [
                      Color(0xFFFE2C55),
                      Color(0xFF25F4EE),
                      Color(0x10FE2C55),
                      Color(0x00000000),
                      Color(0xFFFE2C55),
                    ],
                  ),
                  PlatformActionCard(
                    assetPath: AppAssets.iconWhatsapp,
                    titleKey: LocaleKeys.homeActionWhatsappTitle,
                    descKey: LocaleKeys.homeActionWhatsappDesc,
                    borderColors: [
                      Color(0xFF25D366),
                      Color(0x3025D366),
                      Color(0x0025D366),
                      Color(0x5025D366),
                      Color(0xFF25D366),
                    ],
                  ),
                  PlatformActionCard(
                    assetPath: AppAssets.iconInstagram,
                    titleKey: LocaleKeys.homeActionInstagramTitle,
                    descKey: LocaleKeys.homeActionInstagramDesc,
                    borderColors: [
                      Color(0xFF833AB4),
                      Color(0xFFFD1D1D),
                      Color(0xFFFCAF45),
                      Color(0x00FD1D1D),
                      Color(0xFF833AB4),
                    ],
                  ),
                ],
              ),
            ),

            // Other Tools Section (History, Favorites, Settings)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 14.h, bottom: 8.h),
                child: const OtherToolsSection(),
              ),
            ),

            // Trending Templates Horizontal Carousel
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 14.h, bottom: 8.h),
                child: const TrendingTemplatesSection(),
              ),
            ),

            // Recent Generated Ads Activity
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 14.h, bottom: 8.h),
                child: const RecentAdsSection(),
              ),
            ),

            // Bottom clearance for floating navigation bar
            SliverToBoxAdapter(child: Gap(100.h)),
          ],
        ),
      ),
    );
  }
}
