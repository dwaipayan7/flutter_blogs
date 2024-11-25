import 'package:flutter_blogs/core/error/exceptions.dart';
import 'package:flutter_blogs/core/error/failure.dart';
import 'package:flutter_blogs/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_blogs/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);
  @override
  Future<Either<Failure, String>> loginUpWithEmailPassword(
      {required String email, required String password}) {

    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async{
    
    try{
    final userId = await authRemoteDataSource.
      signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );

    return Either.right(userId);
    }on ServerException catch(e){
      return Either.left(Failure(e.message));
    }
    
  }
}
