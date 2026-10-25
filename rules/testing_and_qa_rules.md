# Testing and Quality Assurance

Use this guide when the user requests tests or verification, or explicitly includes them in the task. Keep tests deterministic, focused on observable behavior, and proportional to risk.

## 1. Test selection

- **Unit tests:** business rules, transformations, validation, and failure mapping.
- **Widget tests:** visible states, user interactions, accessibility semantics, and navigation integration at a screen boundary.
- **Integration tests:** critical end-to-end flows that cross app, platform, or backend boundaries and cannot be reliably covered lower in the stack.
- Test regression-prone behavior and edge cases; do not target an arbitrary coverage percentage or test trivial getters just to inflate coverage.

## 2. Test design

- Assert public behavior and meaningful outcomes, not private implementation details or exact call counts without a behavioral reason.
- Cover success, expected failure, empty/invalid input, and boundary conditions relevant to the changed behavior.
- Keep tests isolated from live Supabase projects, real AI providers, network services, and production credentials. Use fakes or mocks at external boundaries.
- Use the repository's existing tools (`flutter_test`, `bloc_test`, and `mocktail`) where appropriate. Avoid introducing a new test framework without a clear need.
- Tests must not depend on execution order, wall-clock timing, device locale, network access, or mutable external state unless the test explicitly controls it.
- Do not weaken assertions or remove existing tests merely to make a change pass.

## 3. Coverage expectations when testing is requested

- Domain tests verify business decisions and result mapping.
- Data tests verify parsing, request construction, and translation of provider errors using controlled fakes/mocks.
- Controller tests verify meaningful state transitions and error recovery.
- Widget tests verify user-visible behavior, localization, semantics, and route behavior where relevant.
- When tests are requested, cover security-sensitive decisions (authorization, ownership, quota, validation) at the trusted boundary that enforces them.

## 4. Running and reporting checks

- Add or run tests only when the user asks for testing/verification or explicitly includes it in the requested work. Do not infer permission to run commands from a general code change request.
- When requested, run the narrowest useful test first, then broader checks if time and environment permit. Common commands are `flutter test`, `flutter analyze`, and targeted test paths; confirm command availability before relying on them.
- Report the exact command and whether it passed, failed, stalled, or could not run. Include relevant failure output and distinguish environment failures from code failures.
- A passing test suite does not prove absence of defects. Do not claim complete coverage or zero regressions without evidence.
