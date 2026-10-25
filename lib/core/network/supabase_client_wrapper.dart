import 'package:supabase_flutter/supabase_flutter.dart';

/// Contract for Supabase operations providing safe abstraction over the SDK.
abstract class ISupabaseClientWrapper {
  SupabaseClient get client;
  GoTrueClient get auth;
  FunctionsClient get functions;
  StorageFileApi fromStorage(String bucket);
}

/// Production implementation of ISupabaseClientWrapper.
class SupabaseClientWrapper implements ISupabaseClientWrapper {
  @override
  final SupabaseClient client;

  const SupabaseClientWrapper({required this.client});

  @override
  GoTrueClient get auth => client.auth;

  @override
  FunctionsClient get functions => client.functions;

  @override
  StorageFileApi fromStorage(String bucket) => client.storage.from(bucket);
}
