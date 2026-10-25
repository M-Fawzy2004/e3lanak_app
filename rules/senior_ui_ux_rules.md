# SENIOR FLUTTER UI/UX & INTERFACE ENGINEERING RULES

## 1. Visual Hierarchy & Design System
- **Clean Aesthetic:** Use modern cards, subtle shadows (`BoxShadow` with low opacity `0.04 - 0.08`), and consistent border radii (standardize: 12px for inputs, 16px for cards, 24px for bottom sheets).
- **RTL & Arabic Typography:** 
  - Ensure first-class Right-to-Left (RTL) alignment across all screens.
  - Use high-legibility Arabic typography with proportional `lineHeight` (minimum 1.4) to prevent glyph clipping.
- **Adaptive Layouts:** Never hardcode fixed pixel widths for responsive components. Use layout constraints and proportional sizing to handle all mobile screen dimensions cleanly.

## 2. Component Structure & Performance
- **Zero Monolithic Widgets:** Break down any widget exceeding 120 lines into small, focused, private widget classes (prefer standalone widgets over helper functions returning widgets to preserve widget tree repainting efficiency).
- **Constant Constructors:** Enforce `const` constructors everywhere applicable to minimize rebuild passes.
- **Inputs & Forms:**
  - Wrap text fields with smooth validation.
  - Automatically handle keyboard dismissals when tapping outside (`GestureDetector` with `HitTestBehavior.opaque`).
  - Use `SingleChildScrollView` with proper `BouncingScrollPhysics` or `ClampingScrollPhysics` to avoid overflow errors (`RenderFlex overflowed`).

## 3. Micro-Interactions, Feedback & States
- **Loading States:** Never display raw, blocking spinners in the middle of a blank screen. Use elegant skeleton loading (shimmer) matching the exact dimensions of the target card.
- **Tactile Feedback:** Trigger subtle haptic feedback (`HapticFeedback.lightImpact()`) upon successful copy actions, generation completion, and main CTA taps.
- **Copy & Share Actions:**
  - Provide immediate visual confirmation (e.g., a custom animated Floating SnackBar or Toast) when copying text.
  - Implement native system share dialogs for the generated copy.