# Flutter UI, UX, Accessibility, and Performance

> **Before applying any UI rule here, confirm that `app_rules.md` (project root) has been fully read.
> Section 3 of `app_rules.md` (Design System) takes precedence over everything in this file.**

---

## 1. Design System Fidelity — Non-Negotiable

### Colors
- **Zero raw hex literals** in any widget. Use `AppColors.*` tokens exclusively.
  - See the full token list in `app_rules.md § 3.1`.
- **Zero `Colors.*`** (Material color constants) in any widget file.
- If a color is not in `AppColors`, ask the user to add it — do not inline it.

### Typography
- **Zero standalone `TextStyle(...)`** calls in widgets. Use `Theme.of(context).textTheme.<slot>?.copyWith(...)`.
- **Zero `GoogleFonts.*`** calls in feature or widget files. Font families are handled in `AppTypography` and `AppTheme`.
- See the textTheme slot reference table in `app_rules.md § 3.2`.

### Icons
- **`Iconsax` (iconsax_flutter) is the sole icon library** for product UI.
- `Icons.*` (Material) is forbidden in feature/product code.
- Use `Iconsax.arrow_right` / `Iconsax.arrow_left` and toggle based on `LanguageManager.isRtl(context)`.

### Spacing
- All sizes, paddings, radii, and font sizes must use `flutter_screenutil` (`.w`, `.h`, `.r`, `.sp`).
- Established radius tokens are in `app_rules.md § 3.4`. Do not invent new radius values.
- Use `Gap(n.h)` / `Gap(n.w)` for spacing between children.

---

## 2. Responsive Layout and Localization

- Design against constraints, not a single device size. Handle narrow screens, large text, keyboard appearance, safe areas, and orientation changes.
- Use `flutter_screenutil` consistently with the app's established design baseline (`375w × 812h`).
- Support Arabic RTL and English LTR using `easy_localization` and directional layout APIs.
  - `EdgeInsetsDirectional` not `EdgeInsets` for directional padding.
  - `AlignmentDirectional` not `Alignment` for directional alignment.
  - `TextAlign.start` / `TextAlign.end` not `.left` / `.right`.
- Avoid fixed heights for text-heavy content. Use flexible constraints, scroll, and text scaling.

---

## 3. Interaction States and Accessibility

- Every asynchronous interaction must show `loading`, `success`, `empty`, and `failure` states.
- Use a `BrandLoadingIndicator` (project widget) for loading states where it exists.
- Use skeletons only when they improve perceived structure of loading content.
- Provide `Semantics` wrappers for custom interactive widgets (e.g., swipe-to-start buttons).
- Use `HapticFeedback` sparingly and only for meaningful user events (not decorative).
- Sufficient color contrast — never use `AppColors.slate300` or lighter for text on white backgrounds.
- Adequate hit targets: minimum 44×44 dp for interactive elements.

---

## 4. Widget Structure and Performance

- Extract widgets when it improves readability or enables independent rebuilds — not based on line count alone.
- Use `const` constructors and stable widget keys where they provide rebuild savings.
- No expensive work in `build()`: no loops, no date parsing, no list transformations.
- Use `ListView.builder` / `SliverList` for dynamic lists. Never `.map().toList()` inside a `Column` for large datasets.
- Dispose all `AnimationController`, `TextEditingController`, `ScrollController`, `FocusNode`, and `StreamSubscription` in `dispose()`.
- Use `AnimatedBuilder` or `AnimatedWidget` patterns for animation; avoid calling `setState` inside animation listeners.

---

## 5. Animations — flutter_animate Standard

- All entry/exit animations use `flutter_animate`: `.animate()`, `.fadeIn()`, `.slideX()`, `.scale()`.
- Duration range: `300ms` – `700ms`. Standard curve: `Curves.easeOutCubic`.
- Do **not** add animations to widgets that had none unless the user requests it.
- Do **not** remove or alter existing animations without explicit instruction.
- Respect system reduced-motion preferences where possible.

---

## 6. Review Checklist (UI Tasks)

Before marking UI work done:

- [ ] All colors use `AppColors.*` tokens — zero raw hex.
- [ ] All text uses `Theme.of(context).textTheme.*` — zero standalone `TextStyle`.
- [ ] All icons use `Iconsax.*` — zero `Icons.*`.
- [ ] All sizes use `.w`, `.h`, `.r`, `.sp` — zero raw numbers.
- [ ] All user-facing strings use `tr(LocaleKeys.*)` — zero hardcoded text.
- [ ] RTL/LTR layout uses directional APIs.
- [ ] Loading, empty, and error states are handled.
- [ ] Lifecycle (controllers, subscriptions) disposed correctly.
- [ ] No expensive work inside `build()`.
