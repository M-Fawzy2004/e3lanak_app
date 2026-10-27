/// Static string keys corresponding strictly to assets/translations/ar.json and en.json.
/// Use with easy_localization tr() extension: tr(LocaleKeys.appTitle).
abstract final class LocaleKeys {
  // App
  static const String appTitle = 'app.title';
  static const String appTagline = 'app.tagline';
  static const String appDescription = 'app.description';

  // Common
  static const String cancel = 'common.cancel';
  static const String confirm = 'common.confirm';
  static const String copy = 'common.copy';
  static const String share = 'common.share';
  static const String save = 'common.save';
  static const String edit = 'common.edit';
  static const String delete = 'common.delete';
  static const String back = 'common.back';
  static const String next = 'common.next';
  static const String previous = 'common.previous';
  static const String retry = 'common.retry';
  static const String loading = 'common.loading';
  static const String success = 'common.success';
  static const String error = 'common.error';
  static const String copiedToClipboard = 'common.copied_to_clipboard';
  static const String noInternet = 'common.no_internet';
  static const String pageNotFound = 'common.page_not_found';

  // Navigation
  static const String navHome = 'navigation.home';
  static const String navExplore = 'navigation.explore';
  static const String navMyAds = 'navigation.my_ads';
  static const String navProfile = 'navigation.profile';
  static const String navAdGenerator = 'navigation.ad_generator';
  static const String navFeed = 'navigation.feed';
  static const String navHistory = 'navigation.history';
  static const String navSubscription = 'navigation.subscription';
  static const String navSettings = 'navigation.settings';
  static const String navigationComingSoon = 'navigation.coming_soon';
  static const String createActionsTitle = 'navigation.create_actions_title';
  static const String createAiAd = 'navigation.create_ai_ad';
  static const String createAiAdSubtitle = 'navigation.create_ai_ad_subtitle';
  static const String publishDirectAd = 'navigation.publish_direct_ad';
  static const String publishDirectAdSubtitle =
      'navigation.publish_direct_ad_subtitle';
  static const String creationFeatureComingSoon =
      'navigation.creation_feature_coming_soon';
  static const String close = 'navigation.close';

  // Ad Generator Steps & Actions
  static const String adStep1Title = 'ad_generator.step1_title';
  static const String adStep1Subtitle = 'ad_generator.step1_subtitle';
  static const String adUploadBoxClick = 'ad_generator.upload_box_click';
  static const String adUploadBoxDrag = 'ad_generator.upload_box_drag';
  static const String adTakePhotoCamera = 'ad_generator.take_photo_camera';
  static const String adImagesAdded = 'ad_generator.images_added';
  static const String adPhotoCaptured = 'ad_generator.photo_captured';
  static const String adGalleryError = 'ad_generator.gallery_error';
  static const String adCameraError = 'ad_generator.camera_error';
  static const String adPrimaryImage = 'ad_generator.primary_image';
  static const String adChangeImage = 'ad_generator.change_image';
  static const String adNextStepUnavailable =
      'ad_generator.next_step_unavailable';
  static const String adSelectedImagesTitle =
      'ad_generator.selected_images_title';
  static const String adMaxImagesLimit = 'ad_generator.max_images_limit';
  static const String adSelectAtLeastOneImage =
      'ad_generator.select_at_least_one_image';

  static const String adStepUpload = 'ad_generator.step_upload';
  static const String adStepUploadDesc = 'ad_generator.step_upload_desc';
  static const String adStepDetails = 'ad_generator.step_details';
  static const String adStepDetailsDesc = 'ad_generator.step_details_desc';
  static const String adStepTone = 'ad_generator.step_tone';
  static const String adStepToneDesc = 'ad_generator.step_tone_desc';
  static const String adStepGenerate = 'ad_generator.step_generate';
  static const String adStepGenerateDesc = 'ad_generator.step_generate_desc';

  static const String adUploadImageAction = 'ad_generator.upload_image_action';
  static const String adSelectFromGallery = 'ad_generator.select_from_gallery';
  static const String adTakePhoto = 'ad_generator.take_photo';
  static const String adProductNameHint = 'ad_generator.product_name_hint';
  static const String adProductDescHint =
      'ad_generator.product_description_hint';
  static const String adProductPriceHint = 'ad_generator.product_price_hint';

  static const String adStep2Title = 'ad_generator.step2_title';
  static const String adStep2Subtitle = 'ad_generator.step2_subtitle';
  static const String adProductNameLabel = 'ad_generator.product_name_label';
  static const String adProductNameRequired =
      'ad_generator.product_name_required';
  static const String adOriginalPriceLabel =
      'ad_generator.original_price_label';
  static const String adOriginalPriceHint = 'ad_generator.original_price_hint';
  static const String adOriginalPriceRequired =
      'ad_generator.original_price_required';
  static const String adDiscountPriceLabel =
      'ad_generator.discount_price_label';
  static const String adDiscountPriceHint = 'ad_generator.discount_price_hint';
  static const String adDiscountPriceInvalid =
      'ad_generator.discount_price_invalid';
  static const String adSavingsBanner = 'ad_generator.savings_banner';
  static const String adBrandFeaturesLabel =
      'ad_generator.brand_features_label';
  static const String adBrandFeaturesHint = 'ad_generator.brand_features_hint';
  static const String adCurrencyEgp = 'ad_generator.currency_egp';

  static const String adStep3Title = 'ad_generator.step3_title';
  static const String adStep3Subtitle = 'ad_generator.step3_subtitle';
  static const String adSectionCategories = 'ad_generator.section_categories';
  static const String adCatElectronics = 'ad_generator.cat_electronics';
  static const String adCatClothing = 'ad_generator.cat_clothing';
  static const String adCatCars = 'ad_generator.cat_cars';
  static const String adCatRealEstate = 'ad_generator.cat_real_estate';
  static const String adCatRestaurants = 'ad_generator.cat_restaurants';
  static const String adCatFurniture = 'ad_generator.cat_furniture';
  static const String adCatBeauty = 'ad_generator.cat_beauty';
  static const String adCatHomeAppliances = 'ad_generator.cat_home_appliances';
  static const String adCatSports = 'ad_generator.cat_sports';
  static const String adCatServices = 'ad_generator.cat_services';
  static const String adCatAccessories = 'ad_generator.cat_accessories';
  static const String adCatKids = 'ad_generator.cat_kids';
  static const String adCatPets = 'ad_generator.cat_pets';
  static const String adCatHealth = 'ad_generator.cat_health';
  static const String adCatEducation = 'ad_generator.cat_education';
  static const String adCatOther = 'ad_generator.cat_other';
  static const String adCatOtherLabel = 'ad_generator.cat_other_label';
  static const String adCatCustomHint = 'ad_generator.cat_custom_hint';
  static const String adSelectCategoryRequired =
      'ad_generator.select_category_required';
  static const String adGenerateAiAd = 'ad_generator.generate_ai_ad';

  static const String adTonePersuasive = 'ad_generator.tone_persuasive';
  static const String adToneFormal = 'ad_generator.tone_formal';
  static const String adToneFriendly = 'ad_generator.tone_friendly';
  static const String adToneUrgent = 'ad_generator.tone_urgent';

  static const String adGenerateAction = 'ad_generator.generate_action';
  static const String adGeneratingStatus = 'ad_generator.generating_status';
  static const String adGenerationComplete = 'ad_generator.generation_complete';

  // Splash
  static const String splashWelcome = 'splash.welcome';
  static const String splashLoadingReady = 'splash.loading_ready';
  static const String splashSlogan = 'splash.slogan';

  // Onboarding
  static const String onboardingTitle = 'onboarding.title';
  static const String onboardingDescription = 'onboarding.description';
  static const String onboardingGetStarted = 'onboarding.get_started';

  // Home Screen
  static const String homeGreeting = 'home.greeting';
  static const String homeSubtitle = 'home.subtitle';
  static const String homeActionFacebookTitle = 'home.action_facebook_title';
  static const String homeActionFacebookDesc = 'home.action_facebook_desc';
  static const String homeActionTiktokTitle = 'home.action_tiktok_title';
  static const String homeActionTiktokDesc = 'home.action_tiktok_desc';
  static const String homeActionWhatsappTitle = 'home.action_whatsapp_title';
  static const String homeActionWhatsappDesc = 'home.action_whatsapp_desc';
  static const String homeActionInstagramTitle = 'home.action_instagram_title';
  static const String homeActionInstagramDesc = 'home.action_instagram_desc';
  static const String homeSectionOtherTools = 'home.section_other_tools';
  static const String homeToolHistoryTitle = 'home.tool_history_title';
  static const String homeToolHistoryDesc = 'home.tool_history_desc';
  static const String homeToolFavoritesTitle = 'home.tool_favorites_title';
  static const String homeToolFavoritesDesc = 'home.tool_favorites_desc';
  static const String homeToolSettingsTitle = 'home.tool_settings_title';
  static const String homeToolSettingsDesc = 'home.tool_settings_desc';
  static const String homeBannerBadge = 'home.banner_badge';
  static const String homeBannerTitle = 'home.banner_title';
  static const String homeBannerSubtitle = 'home.banner_subtitle';
  static const String homeBannerCta = 'home.banner_cta';

  static const String homeSectionTrending = 'home.section_trending';
  static const String homeTemplateFlashSale = 'home.template_flash_sale';
  static const String homeTemplateNewProduct = 'home.template_new_product';
  static const String homeTemplateSocialProof = 'home.template_social_proof';
  static const String homeTemplateDiscount = 'home.template_discount';
  static const String homeSectionRecentActivity = 'home.section_recent_activity';
  static const String homeRecentAdFbTitle = 'home.recent_ad_fb_title';
  static const String homeRecentAdFbTime = 'home.recent_ad_fb_time';
  static const String homeRecentAdTiktokTitle = 'home.recent_ad_tiktok_title';
  static const String homeRecentAdTiktokTime = 'home.recent_ad_tiktok_time';
  static const String homeRecentAdInstaTitle = 'home.recent_ad_insta_title';
  static const String homeRecentAdInstaTime = 'home.recent_ad_insta_time';
  static const String homeStatusReady = 'home.status_ready';
  static const String homeStatusDraft = 'home.status_draft';
  static const String homeViewAll = 'home.view_all';

  // Auth Screen
  static const String authTitle = 'auth.title';
  static const String authSubtitle = 'auth.subtitle';
  static const String authSignInPrompt = 'auth.sign_in_prompt';
  static const String authContinueWithGoogle = 'auth.continue_with_google';
  static const String authContinueWithApple = 'auth.continue_with_apple';
  static const String authBrowseAsGuest = 'auth.browse_as_guest';
  static const String authTermsNotice = 'auth.terms_notice';
  static const String authErrorGoogle = 'auth.error_google';
  static const String authErrorApple = 'auth.error_apple';
  static const String authErrorGeneric = 'auth.error_generic';
}

