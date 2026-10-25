# Architecture and Code Organization

Apply these rules to new code and when changing existing code. Keep architecture proportional to the feature: do not add empty layers or boilerplate when there is no behavior for them to own.

## 1. Dependency direction

The dependency direction is inward. Business rules must not depend on Flutter UI, Supabase SDKs, platform APIs, or concrete data implementations.

```text
presentation -> domain <- data
                     ^
              composition root
```

- `domain` defines business concepts, repository contracts, and use cases. It contains no Flutter, Supabase, JSON, or platform-specific types.
- `data` implements domain contracts and translates external representations into domain types.
- `presentation` renders state and forwards user intent to feature controllers/use cases. It does not access data sources, Supabase clients, or repositories directly.
- Dependency injection and app composition connect implementations to contracts. Keep wiring in the existing composition root (`lib/core/di/`) unless the app adopts a feature-scoped composition pattern.
- Shared `core` code must be genuinely cross-cutting. Feature policy and workflows belong to their owning feature.

## 2. Feature organization

Use feature-first organization under `lib/features/<feature>/`. Add only the folders the feature needs.

```text
lib/
  core/
    constants/ errors/ localization/ network/ routes/ theme/ utils/ widgets/ di/
  features/
    <feature>/
      data/                 # data sources, DTOs/models, repository implementations
      domain/               # entities, repository contracts, use cases
      presentation/         # screens, widgets, BLoC/Cubit/controllers
```

Feature ownership:

- `auth`: authentication flows, credentials, session and token operations.
- `splash`: startup presentation and orchestration; obtain authentication state through the auth feature's public contract.
- `onboarding`: onboarding presentation and onboarding flow.
- `feed`: feed and feed-related use cases; do not use it as a generic home-screen bucket unless that is the product's actual feature ownership.

Do not place splash or onboarding screens under `features/auth/`. Cross-feature interaction must use an explicit contract or navigation boundary; do not import another feature's private implementation details.

## 3. Domain and data contracts

- Keep entities immutable where practical and independent of serialization.
- Define repository interfaces in `domain/repositories`; implement them in `data/repositories`.
- Keep API/DB DTOs in the data layer. Map DTOs to domain entities at the data boundary; never expose backend response maps to presentation.
- Use a use case when it expresses a meaningful business operation, coordinates dependencies, or creates a testable policy boundary. Do not create one-line wrapper classes mechanically for every getter.
- Represent expected failures with the project's typed failure/result conventions (`Either<Failure, T>` where that convention is already used). Catch and translate errors at the boundary that understands them. Do not use broad catch-and-ignore behavior.
- Do not leak provider exception types into domain or UI contracts.

## 4. Presentation and state

- Presentation consumes feature state and emits user intent. For asynchronous or non-trivial business behavior, use the feature's BLoC/Cubit/controller and domain contracts.
- Keep controllers free of widget construction and route selection. Widgets should not own network, persistence, authorization, quota, or business policy.
- Model loading, success, empty, and failure states when the interaction can produce them. Avoid artificial states for static screens.
- Keep state immutable and transitions predictable. Use sealed/freezed states when they improve exhaustiveness and fit the existing codebase; do not add code generation solely to satisfy a blanket rule.
- Keep rebuild scope focused. Handle controller lifecycle and cancellation correctly.

## 5. Navigation

- Route names live in `lib/core/routes/app_routes.dart`; route resolution and transitions live in `lib/core/routes/app_router.dart`.
- Feature presentation navigates through named routes using `AppRoutes` constants, or through a typed routing API if the project adopts one.
- Do not pass screen widget instances to `Navigator.push`, `pushReplacement`, or similar APIs from feature presentation.
- Preserve and validate route arguments at the routing boundary. Unknown or malformed routes must produce a defined fallback rather than an uncaught exception.
- The app router is a composition boundary and may map route names to public feature screens. It must not contain feature business logic.

## 6. Dependency injection and project conventions

- Register abstractions to implementations in the composition root. Avoid service-locator lookups scattered through widgets and domain code.
- Follow the dependency versions and language features supported by `pubspec.yaml` and the project's configured Dart SDK.
- Before adding a dependency or changing a public type, inspect existing usage and explain the need through the change itself.
- Keep naming, file placement, and error conventions consistent within the feature; improve legacy patterns only as needed for the requested change.
