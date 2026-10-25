# Project Rules — README

This directory contains the specialist rule files for AI coding agents working in this repository.

## How to Use

1. **Always read `../app_rules.md` first** (project root). It is the master file and overrides all specialist rules below.
2. Then read only the specialist files relevant to your current task.
3. If a rule here conflicts with `app_rules.md`, `app_rules.md` wins — state the conflict to the user.

## Rule Files

| File | Domain |
|---|---|
| `master_instructions.md` | Workflow, workflow checklist, engineering standards |
| `senior_ui_ux_rules.md` | UI, UX, accessibility, performance |
| `clean_architecture_rules.md` | Architecture, feature organization, navigation, DI |
| `localization_rules.md` | i18n, RTL/LTR, `easy_localization`, `LocaleKeys` |
| `supabase_backend_rules.md` | Supabase client, RLS, Edge Functions, Storage |
| `fallback_ai_engine_rules.md` | AI provider failover logic |
| `security_and_vulnerability_audit_rules.md` | Security, privacy, data handling |
| `testing_and_qa_rules.md` | Testing strategy and QA |

## Quick Reference — Absolute Prohibitions

The following are **always** forbidden regardless of context:

- `Color(0xFF...)` or `Colors.*` outside `lib/core/theme/app_colors.dart`
- `GoogleFonts.*` outside `lib/core/theme/app_typography.dart` or `app_theme.dart`
- `Icons.*` (Material) in product UI — use `Iconsax.*`
- Hardcoded user-facing strings — use `tr(LocaleKeys.*)`
- Raw sizes/paddings without `.w`, `.h`, `.r`, `.sp`
- `MaterialPageRoute` from feature screens — use `AppRoutes.*`
- Direct Supabase client access from `presentation` layer
