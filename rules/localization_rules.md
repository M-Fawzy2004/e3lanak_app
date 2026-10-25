# Localization and Internationalization

The app uses `easy_localization`, Arabic (`ar`) as the default/fallback locale, and English (`en`) as the other supported locale.

## 1. Source of truth

- Store translations in `assets/translations/ar.json` and `assets/translations/en.json`.
- Use `LocaleKeys` constants for application translation lookups. Avoid inline key strings and raw user-facing copy in widgets.
- Add each new user-visible string to both locale files in the same change. Keep key paths and interpolation parameters equivalent across locales.
- Use clear nested namespaces such as `common`, `navigation`, `auth`, and feature-specific namespaces. Do not reuse a key merely because the English text happens to match; meanings may diverge across locales.
- Keep server/API codes separate from user-facing translated messages. Map known errors to localized copy at the presentation boundary.

## 2. Translation quality and interpolation

- Write natural, concise Arabic and English. Do not machine-translate product terms blindly; preserve approved brand names and terminology consistently.
- Use named interpolation arguments for dynamic values where practical. Never concatenate untrusted data into a translated sentence when a parameterized translation is clearer.
- Translate labels, validation messages, empty/error/loading states, accessibility labels, tooltips, dialogs, notifications, and form hints. Do not localize internal identifiers, route names, logs, or developer diagnostics.
- Avoid assembling a sentence from fragments; grammar and word order differ by locale.

## 3. RTL, layout, and typography

- Let the active locale drive `Directionality`. Do not hardcode global text direction inside individual features.
- Prefer directional APIs such as `EdgeInsetsDirectional`, `AlignmentDirectional`, and direction-aware icons for content whose meaning depends on reading direction.
- Use physical left/right positioning only for genuinely physical placement, such as an image composition that must remain fixed.
- Use the existing typography/theme configuration. Ensure Arabic glyphs, diacritics, line height, truncation, and mixed Arabic/Latin content render correctly.
- Do not assume translated text has the same length as its source. Verify wrapping, overflow, and layout at supported screen sizes.

## 4. Locale behavior and verification

- Preserve the configured Arabic startup and fallback behavior unless the user requests a product change.
- Locale changes must update the active app tree through the localization framework without requiring a restart.
- When localization verification is requested, check JSON validity, key parity, interpolation parity, RTL/LTR layout behavior, and representative long/short strings.
