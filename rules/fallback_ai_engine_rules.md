# AI Provider Failover and Response Contracts

Apply these rules only when the product uses multiple AI providers or an explicit fallback path. Do not add a provider, automatic failover, or paid retry merely because this document exists.

## 1. Provider boundary

- Keep provider selection, credentials, prompt construction, quota enforcement, and provider-specific request formats in a trusted backend/Edge Function.
- Keep private provider keys out of Flutter, assets, logs, tests, and client build configuration.
- Define one application-level request and response contract independent of provider SDKs. Normalize provider output at the backend boundary.

## 2. Failover policy

- Fail over only for documented transient conditions such as a bounded timeout, provider unavailability, or explicitly retryable rate-limit response.
- Do not retry authentication, authorization, validation, safety, or quota failures against another provider.
- Set finite timeouts, bounded attempts, and an overall request deadline. Avoid retry storms and uncontrolled parallel calls.
- Consider whether an upstream call may already have completed before retrying. Use idempotency/deduplication when calls can incur cost or persist side effects.
- Apply user quota and cost policy once at a trusted boundary. Record which provider path was used without logging prompts, secrets, or personal data unnecessarily.
- If no eligible provider succeeds, return a stable application failure that allows the client to offer a safe retry or recovery action.

## 3. Input and prompt safety

- Separate trusted system instructions from untrusted user content and serialize/delimit user content as data.
- Validate and bound text, images, and metadata before sending them upstream. Enforce limits server-side; client limits alone are not sufficient.
- Apply the same authorization, privacy, safety, and product constraints to primary and fallback providers.
- Do not claim that keyword filtering prevents prompt injection. Restrict tools and capabilities, validate outputs, and treat model responses as untrusted.

## 4. Output normalization

- Validate required fields, types, sizes, and allowed values before returning a response. Reject or safely repair malformed output according to an explicit policy.
- Preserve the same application schema and locale behavior across providers. Provider-specific fields must not leak into the client contract without a reviewed API change.
- Do not display raw provider errors or unvalidated model output as trusted instructions, markup, or executable content.

## 5. Observability and verification

- Record provider choice, latency, retry reason, and safe failure codes needed for operations. Redact prompt contents, credentials, and PII.
- When verification is requested, cover transient and non-retryable failures, timeouts, malformed output, exhausted quota, and duplicate/retry behavior with provider fakes. Never call live paid APIs in automated tests.
