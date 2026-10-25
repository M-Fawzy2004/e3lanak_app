import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../network/network_info.dart';
import '../network/supabase_client_wrapper.dart';

/// Global Service Locator instance
final sl = GetIt.instance;

/// Initialize all core dependencies, external clients, and feature services.
Future<void> init() async {
  //! 1. External Clients & Storage
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ),
  );

  //! 2. Core Services
  sl.registerLazySingleton<ISupabaseClientWrapper>(
    () => SupabaseClientWrapper(client: sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<NetworkInfo>(() => const NetworkInfoImpl());

  //! 3. Feature Dependencies
  _initAuthFeature();
  _initAdGeneratorFeature();
  _initFeedFeature();
  _initHistoryFeature();
  _initSubscriptionFeature();
  _initSettingsFeature();
}

void _initAuthFeature() {
  // Auth feature registrations will be added as features are implemented
}

void _initAdGeneratorFeature() {
  // Ad generator feature registrations will be added as features are implemented
}

void _initFeedFeature() {
  // Feed feature registrations will be added as features are implemented
}

void _initHistoryFeature() {
  // History feature registrations will be added as features are implemented
}

void _initSubscriptionFeature() {
  // Subscription feature registrations will be added as features are implemented
}

void _initSettingsFeature() {
  // Settings feature registrations will be added as features are implemented
}
