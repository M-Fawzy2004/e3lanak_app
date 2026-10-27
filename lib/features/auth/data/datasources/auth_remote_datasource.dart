import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/network/supabase_client_wrapper.dart';
import '../models/auth_user_model.dart';

abstract class AuthRemoteDataSource {
  /// Initiates Google OAuth sign-in flow.
  /// Returns `true` if the OAuth redirect was successfully launched.
  Future<bool> signInWithGoogle();

  /// Initiates Apple OAuth sign-in flow.
  /// Returns `true` if the OAuth redirect was successfully launched.
  Future<bool> signInWithApple();

  /// Retrieves the current authenticated user if a valid session exists.
  AuthUserModel? getCurrentUser();

  /// Terminates the current Supabase session.
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ISupabaseClientWrapper _supabase;

  const AuthRemoteDataSourceImpl({required this._supabase});

  @override
  Future<bool> signInWithGoogle() async {
    final launched = await _supabase.auth.signInWithOAuth(
      OAuthProvider.google,
    );
    if (!launched) {
      throw const AuthException('Failed to launch Google authentication flow');
    }
    return true;
  }

  @override
  Future<bool> signInWithApple() async {
    final launched = await _supabase.auth.signInWithOAuth(
      OAuthProvider.apple,
    );
    if (!launched) {
      throw const AuthException('Failed to launch Apple authentication flow');
    }
    return true;
  }

  @override
  AuthUserModel? getCurrentUser() {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;
    return AuthUserModel.fromSupabaseUser(user);
  }

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
