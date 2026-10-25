import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../network/network_info.dart';
import '../network/supabase_client_wrapper.dart';
import '../../features/ad_generator/data/datasources/ad_image_picker_datasource.dart';
import '../../features/ad_generator/data/repositories/ad_image_repository_impl.dart';
import '../../features/ad_generator/domain/repositories/ad_image_repository.dart';
import '../../features/ad_generator/domain/usecases/capture_ad_photo_usecase.dart';
import '../../features/ad_generator/domain/usecases/pick_ad_images_usecase.dart';
import '../../features/ad_generator/presentation/controllers/ad_step1_cubit.dart';

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
  // Data sources
  sl.registerLazySingleton<AdImagePickerDataSource>(
    () => AdImagePickerDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<AdImageRepository>(
    () => AdImageRepositoryImpl(dataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => PickAdImagesUseCase(sl()));
  sl.registerLazySingleton(() => CaptureAdPhotoUseCase(sl()));

  // Cubits / Controllers
  sl.registerFactory(
    () => AdStep1Cubit(
      pickImagesUseCase: sl(),
      capturePhotoUseCase: sl(),
    ),
  );
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
