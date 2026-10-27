import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/sign_in_with_apple_usecase.dart';
import '../../domain/usecases/sign_in_with_google_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignInWithAppleUseCase _signInWithAppleUseCase;

  AuthCubit({
    required this._signInWithGoogleUseCase,
    required this._signInWithAppleUseCase,
  }) : super(const AuthState());

  Future<void> signInWithGoogle() async {
    if (state.isLoading) return;
    emit(state.copyWith(status: AuthStatus.loadingGoogle, errorMessage: null));

    final result = await _signInWithGoogleUseCase();
    result.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        status: AuthStatus.authenticated,
      )),
    );
  }

  Future<void> signInWithApple() async {
    if (state.isLoading) return;
    emit(state.copyWith(status: AuthStatus.loadingApple, errorMessage: null));

    final result = await _signInWithAppleUseCase();
    result.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        status: AuthStatus.authenticated,
      )),
    );
  }

  void continueAsGuest() {
    emit(state.copyWith(status: AuthStatus.guest, errorMessage: null));
  }
}
