# FALLBACK AI & FAILOVER ENGINE RULES

## 1. Automated Failover Circuit Breaker
- In the Supabase Edge Function orchestration layer, implement an automatic failover mechanism:
  1. Attempt primary AI model (Gemini).
  2. If primary returns `429 (Rate Limit)`, `503 (Unavailable)`, or times out (> 12 seconds):
  3. Log the warning and switch immediately to the secondary fallback provider (e.g., Groq / High-Throughput inference provider).
  4. Deliver the completed ad generation to the client seamlessly without throwing a user-facing error.

## 2. Text-Only Fallback Graceful Degradation
- If the fallback provider does not support multimodal vision inputs:
  - Parse the user's textual metadata (Product Title, Category, Price, Features).
  - Add an internal fallback prompt prefix: `"Generate marketing copy based on the provided textual specifications."`
  - Proceed with high-speed text generation.

## 3. Response Schema Compatibility
- The secondary engine must normalize its output into the exact same JSON contract expected by the Flutter client:
  ```json
  {
    "short_ad": "...",
    "detailed_ad": "...",
    "video_script": "..."
  }
  ```
- Always validate that all keys exist before sending the payload downstream.