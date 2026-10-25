# FLUTTER CLEAN ARCHITECTURE & CODE ORGANIZATION RULES

## 1. Folder Structure Standard
Every feature must reside in `lib/features/<feature_name>/` divided strictly into three layers:

```text
lib/
├── core/
│   ├── errors/             # Failure & Exception classes
│   ├── network/            # Network info, interceptors
│   ├── theme/              # Colors, typography, decorations
│   ├── utils/              # Extensions, formatters, helpers
│   ├── services/           # Global services (Analytics, Dialog, etc.)
│   └── di/                 # Service Locator (GetIt injection)
└── features/
    └── <feature_name>/
        ├── data/
        │   ├── datasources/# Remote & Local data sources (Supabase, SharedPreferences)
        │   ├── models/     # DTOs with toJson/fromJson and toDomain mappings
        │   └── repositories/# Concrete repository implementations
        ├── domain/
        │   ├── entities/   # Plain Dart business objects (immutable)
        │   ├── repositories/# Abstract repository contracts
        │   └── usecases/   # Isolated business operations (Single Responsibility)
        └── presentation/
            ├── controllers/# BLoC / Cubit state managers
            ├── screens/    # Full-screen page widgets
            └── widgets/    # Reusable private components for this feature
```

## 2. Layer Constraints & Dependency Rules
- **Domain Layer:** Pure Dart. Zero dependencies on Flutter, Supabase, third-party libraries, or Data layer classes.
- **Data Layer:** Implements Domain interfaces. Handles raw serialization/deserialization. Always maps `Models` to `Entities` before passing data to the Domain layer.
- **Presentation Layer:** Interacts ONLY with Domain UseCases via BLoC/Cubit. Never call Repositories or DataSources directly from UI widgets.

## 3. Error Handling Paradigm
- Use functional error handling via `fpdart` (`Either<Failure, T>`) for all UseCases and Repositories.
- All network or parsing exceptions must be caught inside DataSources/Repositories and converted into a typed `Failure`:
  ```dart
  Future<Either<Failure, GeneratedAdEntity>> generateAd(AdParams params);
  ```

## 4. State Management (BLoC / Cubit)
- Use `freezed` or sealed classes for State definitions to guarantee exhaustive pattern matching (`initial`, `loading`, `success`, `error`).
- Controllers must hold minimal state and contain no UI business logic or routing logic.
- Keep widget rebuilds granular using `BlocBuilder` with `buildWhen` or `BlocSelector`.