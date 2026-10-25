/// Global application constants and configuration values.
abstract final class AppConstants {
  static const String appName = 'E3lanak';
  static const String appVersion = '1.0.0';

  // Responsive Design Baseline (iPhone 14 logical points: 390 x 844)
  static const double designWidth = 390.0;
  static const double designHeight = 844.0;

  // Supabase Configuration from --dart-define
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://e3lanak-placeholder.supabase.co',
  );
  static const String supabasePublishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
    defaultValue: String.fromEnvironment(
      'SUPABASE_ANON_KEY',
      defaultValue:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImUzbGFuYWsiLCJyb2xlIjoiYW5vbiIsImlhdCI6MTY4NTUzNzIwMCwiZXhwIjoyMDAxMTEzMjAwfQ.dGVzdF9zaWduYXR1cmVfZm9yX2RldmVsb3BtZW50',
    ),
  );
  static const String supabaseAnonKey = supabasePublishableKey;

  // Localization
  static const String translationsPath = 'assets/translations';
  static const String arabicLocaleCode = 'ar';
  static const String englishLocaleCode = 'en';

  // Storage Keys
  static const String tokenStorageKey = 'e3lanak_secure_token';
  static const String userPrefsStorageKey = 'e3lanak_user_prefs';
}
