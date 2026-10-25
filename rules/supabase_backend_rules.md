# SUPABASE BACKEND & ZERO-TRUST SECURITY RULES

## 1. Zero-Trust Client Architecture
- **Never expose Service Role Keys** inside the Flutter client codebase. Only the `anon` public key is permitted on the client.
- **Edge Functions for Sensitive Logic:** Any operation involving proprietary AI keys, payment verification, user quotas, or secret tokens MUST be executed via Supabase Edge Functions.

## 2. Row Level Security (RLS) Policy
- Every single table created in Supabase PostgreSQL must have RLS explicitly enabled:
  ```sql
  ALTER TABLE public.user_ads ENABLE ROW LEVEL SECURITY;
  ```
- Default deny: No public select, insert, update, or delete without an explicit policy.
- Standard User Isolation Policy:
  ```sql
  CREATE POLICY "Users can only access their own records"
  ON public.user_ads
  FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);
  ```

## 3. Authentication Patterns (Social + Anonymous)
- Support seamless transitions between Anonymous Guest sessions and Social Logins (Google / Apple).
- When promoting an anonymous user to an authenticated user (`linkIdentity`), ensure existing data tied to the user's `auth.uid()` persists seamlessly.

## 4. Rate Limiting & Quota Management
- Track user generations in a dedicated `user_usage` table or Redis cache.
- The Edge Function must enforce usage limits before invoking any AI upstream API:
  1. Authenticate JWT token passed in `Authorization` header.
  2. Verify subscription tier or check available free daily credits.
  3. If quota is exceeded, reject immediately with `429 Too Many Requests` or custom payload `{ "code": "QUOTA_EXHAUSTED" }`.
  4. Only invoke the AI provider upon successful quota validation.
  5. Atomically decrement or increment usage upon successful generation.