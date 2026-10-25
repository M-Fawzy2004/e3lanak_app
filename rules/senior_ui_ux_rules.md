# Flutter UI, UX, Accessibility, and Performance

Build interfaces that are consistent with the product design system, work across supported locales and screen sizes, and expose clear interaction states.

## 1. Design system and visual fidelity

- Inspect existing theme tokens, typography, reusable components, and supplied references before creating new visual styles.
- Use shared colors, spacing, typography, radii, and component patterns where available. Add a token only when it represents a reusable design decision.
- For screenshot/reference work, match hierarchy, alignment, sizing, color, and spacing against the provided reference while preserving responsive behavior.
- Avoid decorative effects that reduce contrast, legibility, or performance. Do not add shadows, gradients, animation, or haptics without a design or interaction purpose.
- Use `iconsax_flutter` (`Iconsax`) as the standard icon library for application UI. Do not use Material `Icons`, emoji, or Unicode symbols for product interface icons. Choose the closest semantic Iconsax glyph and keep icon weight/style consistent within each component; retain platform-native icons only when a platform control requires them.

## 2. Responsive layout and localization

- Design against constraints, not a single device size. Handle narrow screens, large text, keyboard appearance, safe areas, and orientation changes where supported.
- Use `flutter_screenutil` consistently with the app's established design baseline; do not apply `.w`, `.h`, or `.sp` mechanically to every value.
- Support Arabic RTL and English LTR using localization rules and directional layout APIs.
- Avoid fixed heights for text-heavy content. Prevent overflow with appropriate scrolling, flexible constraints, and text scaling.

## 3. Interaction states and accessibility

- Every asynchronous interaction should communicate relevant loading, success, empty, and failure states without blocking unrelated navigation.
- Use a progress indicator when work is actively pending; use skeletons only when they improve the perceived structure of content that is loading.
- Make controls reachable and understandable: adequate hit targets, labels/semantics, keyboard/focus behavior where applicable, visible focus, and sufficient contrast.
- Provide validation close to the affected input and preserve user-entered data after recoverable errors.
- Use haptics and animation sparingly, respect platform behavior and reduced-motion preferences where available, and never make essential information animation-only.

## 4. Widget structure and performance

- Keep widgets cohesive and extract components when that improves readability, reuse, or independent testing; do not use a line-count threshold as the sole reason to split a widget.
- Use `const` constructors and stable keys where they provide value. Avoid unnecessary rebuilds, repeated expensive work in `build`, and unbounded image/network work.
- Use the correct lifecycle for controllers, focus nodes, subscriptions, and animations. Cancel or dispose owned resources.
- Use semantic Material/Cupertino controls where possible instead of recreating platform behavior.

## 5. Review checklist

- Does the screen follow existing product patterns and support both locales?
- Are content, controls, loading, empty, and error states understandable?
- Does it remain usable with larger text, narrow constraints, and the keyboard visible?
- Are semantics, contrast, focus, and touch targets adequate?
- Are lifecycle and performance costs appropriate for the interaction?
