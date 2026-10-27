import '../../domain/entities/auth_user.dart';

enum AuthStatus {
  initial,
  loadingGoogle,
  loadingApple,
  authenticated,
  guest,
  failure,
}

class AuthState {
  final AuthStatus status;
  final AuthUser? user;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
  });

  bool get isLoading =>
      status == AuthStatus.loadingGoogle || status == AuthStatus.loadingApple;
  bool get isGoogleLoading => status == AuthStatus.loadingGoogle;
  bool get isAppleLoading => status == AuthStatus.loadingApple;
  bool get isAuthenticated =>
      status == AuthStatus.authenticated || status == AuthStatus.guest;

  AuthState copyWith({
    AuthStatus? status,
    AuthUser? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          user == other.user &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode =>
      status.hashCode ^ user.hashCode ^ (errorMessage?.hashCode ?? 0);
}
