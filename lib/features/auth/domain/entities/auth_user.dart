/// Pure domain entity representing an authenticated user.
/// Strictly decoupled from Supabase or any external SDK.
class AuthUser {
  final String id;
  final String email;
  final String? displayName;
  final String? avatarUrl;

  const AuthUser({
    required this.id,
    required this.email,
    this.displayName,
    this.avatarUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthUser &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          displayName == other.displayName &&
          avatarUrl == other.avatarUrl;

  @override
  int get hashCode =>
      id.hashCode ^
      email.hashCode ^
      displayName.hashCode ^
      avatarUrl.hashCode;
}
