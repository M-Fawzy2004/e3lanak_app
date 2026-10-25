# TESTING, QUALITY ASSURANCE & REGRESSION RULES

## 1. Testing Hierarchy & Standards
Every feature must have accompanying automated tests adhering to the Clean Architecture boundaries:
- **Unit Tests (Domain Layer):** Pure Dart tests for UseCases and Entities with 100% logic coverage. Zero mock framework overhead.
- **Unit & Mock Tests (Data Layer):** Test Repositories and DataSources by mocking Supabase and HTTP clients using `mocktail`.
- **State Management Tests (Presentation):** Use `bloc_test` to test every state transition (`initial` -> `loading` -> `success` / `error`).

## 2. UseCase Test Blueprint
```dart
void main() {
  late MockAdRepository mockAdRepository;
  late GenerateAdUseCase useCase;

  setUp(() {
    mockAdRepository = MockAdRepository();
    useCase = GenerateAdUseCase(mockAdRepository);
  });

  test('should return GeneratedAdEntity when repository call succeeds', () async {
    // Arrange
    const tParams = AdParams(title: 'Sneakers', price: 500);
    const tResult = GeneratedAdEntity(shortAd: 'Sale!', detailedAd: '...', videoScript: '...');
    when(() => mockAdRepository.generateAd(any()))
        .thenAnswer((_) async => const Right(tResult));

    // Act
    final result = await useCase(tParams);

    // Assert
    expect(result, const Right(tResult));
    verify(() => mockAdRepository.generateAd(tParams)).called(1);
    verifyNoMoreInteractions(mockAdRepository);
  });
}
```

## 3. BLoC / Cubit Test Blueprint
```dart
blocTest<AdGeneratorCubit, AdGeneratorState>(
  'emits [Loading, Success] when generateAd succeeds',
  build: () {
    when(() => mockGenerateAdUseCase(any()))
        .thenAnswer((_) async => const Right(tAdEntity));
    return AdGeneratorCubit(mockGenerateAdUseCase);
  },
  act: (cubit) => cubit.generate(tParams),
  expect: () => [
    const AdGeneratorState.loading(),
    const AdGeneratorState.success(tAdEntity),
  ],
);
```

## 4. Verification After Every Addition
Whenever a new feature or endpoint is added:
1. Run `flutter analyze` — ensure zero warnings and zero linter errors.
2. Run `flutter test` — all existing and new tests must pass with zero regressions.
3. Validate Edge Cases:
   - Network failure / timeout.
   - Quota exhaustion (HTTP 429).
   - Malformed/unexpected AI output format.