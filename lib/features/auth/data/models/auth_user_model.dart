
import 'package:e3lanak_app/features/auth/domain/entities/auth_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

class AuthUserModel extends AuthUser {
  const AuthUserModel({
    required super.id,
    required super.email,
    super.displayName,
    super.avatarUrl,
  });

  factory AuthUserModel.fromSupabaseUser(User user) {
    final metadata = user.userMetadata ?? {};
    final displayName = (metadata['full_name'] ?? metadata['name'] ?? '') as String;
    final avatarUrl = (metadata['avatar_url'] ?? metadata['picture'] ?? '') as String;

    return AuthUserModel(
      id: user.id,
      email: user.email ?? '',
      displayName: displayName.isNotEmpty ? displayName : null,
      avatarUrl: avatarUrl.isNotEmpty ? avatarUrl : null,
    );
  }
}
