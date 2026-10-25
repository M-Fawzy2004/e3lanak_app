# LOCALIZATION & MULTI-LANGUAGE RULES (E3LANAK)

## 1. Core Architecture & Standards
- Multi-language support is strictly managed using `easy_localization`.
- **Default & Fallback Locale:** Arabic (`Locale('ar')`) is the primary language and fallback locale for the application.
- **Supported Locales:** Arabic (`ar`) and English (`en`).
- **Translation Path:** All localization files must reside strictly in `assets/translations/`.
  - `assets/translations/ar.json`
  - `assets/translations/en.json`
- Both JSON files must maintain identical key structures at all times. Nested namespaces (e.g. `common`, `auth`, `ad_generator`, `navigation`, `errors`) must be strictly synchronized.

## 2. Zero Hardcoded Strings Policy
- **No hardcoded text strings in UI widgets:** Never write raw strings like `Text('Submit')` or `Text('إرسال')` inside the presentation layer or UI components.
- All strings must be resolved using:
  - `tr(LocaleKeys.someKey)` or `LocaleKeys.someKey.tr()`
  - Or formatted with arguments: `LocaleKeys.welcomeUser.tr(args: [userName])` or `namedArgs: {'name': userName}`.
- Any new label, tooltip, error message, button text, dialog title, or placeholder must be added to both `ar.json` and `en.json` before widget implementation.
- Type-safe keys via `LocaleKeys` (generated or structured constants class) are required for all UI string lookups.

## 3. Bidirectional (RTL / LTR) Layout Standards
- Arabic is an RTL (Right-to-Left) language, while English is LTR (Left-to-Right).
- **Directional UI APIs:**
  - Avoid hardcoded `EdgeInsets.only(left: ..., right: ...)`. Use `EdgeInsetsDirectional.only(start: ..., end: ...)` or `EdgeInsetsDirectional.fromSTEB(...)`.
  - Avoid `Alignment.topLeft` or `Alignment.topRight` when positioning directional content; use `AlignmentDirectional.topStart` or `AlignmentDirectional.topEnd`.
  - Use directional icons where applicable (e.g., back arrows, chevrons) so they automatically flip based on text direction or check `context.locale.languageCode == 'ar'`.
- **MaterialApp Configuration:**
  - Wrap top-level app or pass delegates to ensure `Directionality` dynamically responds to `context.locale`.
  - Locale switches must trigger an immediate reactive widget rebuild across the entire tree without requiring an application restart.

## 4. Typography & Font Integration
- Arabic text must render using Google Fonts **Cairo** (or **Tajawal** for specialized headings) with appropriate line heights to prevent character clipping.
- English text renders using Google Fonts **Inter** or standard Latin typography fallback.
- `flutter_screenutil` responsive font scaling (`.sp`) must be used for all text styles defined in `AppTypography` / `AppTheme`.

## 5. Verification & Code Review Checklist
1. Are all strings extracted into `ar.json` and `en.json`?
2. Does switching language from Arabic to English instantly flip text and layout direction without app restart?
3. Are all paddings and alignments using directional variants (`start`/`end`) instead of absolute (`left`/`right`)?
4. Is `Locale('ar')` verified as the default fallback locale?
