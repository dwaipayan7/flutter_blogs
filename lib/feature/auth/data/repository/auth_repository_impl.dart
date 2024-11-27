import 'package:flutter_blogs/core/error/exceptions.dart';
import 'package:flutter_blogs/core/error/failure.dart';
import 'package:flutter_blogs/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_blogs/feature/auth/domain/entities/user.dart';
import 'package:flutter_blogs/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);
  @override
  Future<Either<Failure, User>> loginUpWithEmailPassword({
    required String email,
    required String password,
  }) async{
    try{

      final user = await authRemoteDataSource.loginWithEmailPassword(
          email: email,
          password: password
      );

      return Either.right(user);

    }on ServerException catch(e){
      return Either.left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await authRemoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );

      return Either.right(user);
    } on ServerException catch (e) {
      return Either.left(Failure(e.message));
    }
  }
}
