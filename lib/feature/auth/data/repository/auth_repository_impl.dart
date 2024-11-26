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
      return _getUser(()async =>  await authRemoteDataSource.loginWithEmailPassword(
          email: email,
          password: password
      ));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {

   return  _getUser(()async =>
   await authRemoteDataSource.signUpWithEmailPassword(
       name: name,
       email: email,
       password: password,
     ));

  }

 Future<Either<Failure, User>> _getUser(
     Future<User>Function() fn,
     ) async{
   try{
     final user = await fn();

     return Either.right(user);
   } on ServerException catch(e){
     return Either.left(Failure(e.message));
   }
  }

}
