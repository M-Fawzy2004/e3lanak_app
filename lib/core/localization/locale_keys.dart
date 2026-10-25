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
  static const String retry = 'common.retry';
  static const String loading = 'common.loading';
  static const String success = 'common.success';
  static const String error = 'common.error';
  static const String copiedToClipboard = 'common.copied_to_clipboard';
  static const String noInternet = 'common.no_internet';
  static const String pageNotFound = 'common.page_not_found';

  // Navigation
  static const String navHome = 'navigation.home';
  static const String navAdGenerator = 'navigation.ad_generator';
  static const String navFeed = 'navigation.feed';
  static const String navHistory = 'navigation.history';
  static const String navSubscription = 'navigation.subscription';
  static const String navSettings = 'navigation.settings';

  // Ad Generator Steps & Actions
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
  static const String adProductDescHint = 'ad_generator.product_description_hint';
  static const String adProductPriceHint = 'ad_generator.product_price_hint';

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
}
