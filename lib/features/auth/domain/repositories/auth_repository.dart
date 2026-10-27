import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/auth_user.dart';

/// Contract for Authentication operations in the domain layer.
abstract class AuthRepository {
  /// Initiates Google OAuth sign-in flow.
  Future<Either<Failure, bool>> signInWithGoogle();

  /// Initiates Apple OAuth sign-in flow.
  Future<Either<Failure, bool>> signInWithApple();

  /// Returns current authenticated user if exists.
  Option<AuthUser> getCurrentUser();

  /// Signs out the current session.
  Future<Either<Failure, void>> signOut();
}
