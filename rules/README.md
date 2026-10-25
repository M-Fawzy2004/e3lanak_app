# Engineering Rules Index

For repository tasks, use the root [`app_rules.md`](../app_rules.md) as the required entry point when the user invokes it. It requires a sequential read of every rule file before implementation, then applies only the rules relevant to the task. [`master_instructions.md`](master_instructions.md) defines the detailed workflow and precedence.

| Concern | Rule file | Apply when |
|---|---|---|
| Architecture | [`clean_architecture_rules.md`](clean_architecture_rules.md) | Changing feature structure, dependencies, state, DI, or navigation |
| Backend | [`supabase_backend_rules.md`](supabase_backend_rules.md) | Changing Supabase auth, schema, RLS, Storage, realtime, RPC, or Edge Functions |
| AI failover | [`fallback_ai_engine_rules.md`](fallback_ai_engine_rules.md) | Changing a multi-provider AI request or fallback behavior |
| UI and accessibility | [`senior_ui_ux_rules.md`](senior_ui_ux_rules.md) | Building or changing screens and interactions |
| Localization | [`localization_rules.md`](localization_rules.md) | Adding or changing user-visible copy, locale behavior, or RTL/LTR layout |
| Security and privacy | [`security_and_vulnerability_audit_rules.md`](security_and_vulnerability_audit_rules.md) | Changing trust boundaries, sensitive data, authorization, or abuse controls |
| Testing and QA | [`testing_and_qa_rules.md`](testing_and_qa_rules.md) | When tests or verification are requested |

`clean_architecture_rules (1).md` was a duplicate of the canonical architecture guide and has been removed to avoid conflicting instructions.
