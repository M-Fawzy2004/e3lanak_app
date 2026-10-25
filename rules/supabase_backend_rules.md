# Supabase Integration and Backend Contracts

Use this guide for Flutter-to-Supabase integration, schema changes, Storage, realtime, RPC, and Edge Functions. Keep privileged policy enforcement on the server.

## 1. Client configuration and authentication

- The Flutter client may use the Supabase project URL and publishable/anon key. Never embed the service-role key or private provider credentials.
- Use the supported `supabase_flutter` auth/session APIs. Do not persist duplicate access or refresh tokens in custom preferences or logs.
- Model signed-out, loading, authenticated, expired, and initialization-failure behavior explicitly where the feature needs them. Do not assume initialization succeeded merely because the app launched.
- Use the authenticated identity from the verified session; do not accept a client-supplied identity as authorization evidence.

## 2. Database schema, migrations, and RLS

- Treat version-controlled migrations as the source of truth for schema and policy changes. Keep migrations reviewable, ordered, and safe to apply in the target environments.
- Enable RLS for every table exposed to client roles. Define only the required `SELECT`, `INSERT`, `UPDATE`, and `DELETE` policies; default to no access when no policy applies.
- Scope user-owned rows to the authenticated identity and validate ownership on both existing rows and new values (`USING` and `WITH CHECK` as applicable).
- When verification is requested, test policies as anonymous, authorized owner, and a different authenticated user. Do not infer security from successful owner-path tests alone.
- Grant only necessary table/function privileges. Avoid broad grants, blanket policies, and unnecessary `SECURITY DEFINER` functions.
- For `SECURITY DEFINER`, document why it is needed, constrain `search_path`, validate arguments, and review execution grants. Prefer `SECURITY INVOKER` when it satisfies the use case.

## 3. Edge Functions and privileged operations

- Keep private AI, payment, quota, and administrative credentials in server-side secrets. Validate the caller's JWT and required authorization before processing protected work.
- Validate payload shape, bounds, ownership, and content type at the function boundary. Never trust client-provided role, price, quota, or user identity claims without server verification.
- Apply rate limits, timeouts, quota checks, and payload caps before expensive upstream calls. Make quota accounting atomic and use idempotency where retries could duplicate charges or writes.
- Return a stable, documented response/error contract. Do not expose stack traces, secret values, or sensitive provider diagnostics to clients.
- Apply least-privilege CORS and service permissions appropriate to the calling clients and operation.

## 4. Storage, realtime, RPC, and errors

- Define and review Storage bucket access policies independently from table policies. Validate file size, type, ownership, and lifecycle.
- Authorize realtime subscriptions and RPC calls according to the data they expose or mutate.
- Translate Supabase/provider errors at the data boundary into application-level failures. Preserve safe diagnostic context for logs while redacting credentials and personal data.
- Distinguish offline, timeout, authentication, authorization, validation, quota, and unexpected failures when the UI needs different recovery behavior.

## 5. Review checklist

- Are private credentials server-only?
- Is authorization enforced where the data or privileged operation is actually controlled?
- Are RLS, Storage, RPC, and realtime policies explicit and least-privilege?
- Are inputs bounded, retries safe, and quota/cost controls server-enforced?
- When verification is in scope, are migrations, response contracts, and relevant tests updated with the backend change?
