import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;
import '../../../../core/errors/failures.dart';
import '../../../../core/localization/locale_keys.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _dataSource;
  final NetworkInfo _networkInfo;

  const AuthRepositoryImpl({
    required this._dataSource,
    required this._networkInfo,
  });

  @override
  Future<Either<Failure, bool>> signInWithGoogle() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(message: LocaleKeys.noInternet));
    }

    try {
      final launched = await _dataSource.signInWithGoogle();
      return Right(launched);
    } on AuthException catch (_) {
      return const Left(AuthFailure(message: LocaleKeys.authErrorGoogle));
    } catch (_) {
      return const Left(AuthFailure(message: LocaleKeys.authErrorGeneric));
    }
  }

  @override
  Future<Either<Failure, bool>> signInWithApple() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(message: LocaleKeys.noInternet));
    }

    try {
      final launched = await _dataSource.signInWithApple();
      return Right(launched);
    } on AuthException catch (_) {
      return const Left(AuthFailure(message: LocaleKeys.authErrorApple));
    } catch (_) {
      return const Left(AuthFailure(message: LocaleKeys.authErrorGeneric));
    }
  }

  @override
  Option<AuthUser> getCurrentUser() {
    final user = _dataSource.getCurrentUser();
    return Option.fromNullable(user);
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _dataSource.signOut();
      return const Right(null);
    } on AuthException catch (_) {
      return const Left(AuthFailure(message: LocaleKeys.authErrorGeneric));
    } catch (_) {
      return const Left(AuthFailure(message: LocaleKeys.authErrorGeneric));
    }
  }
}
