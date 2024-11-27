import 'package:flutter_blogs/core/error/failure.dart';
import 'package:flutter_blogs/core/usecase/usecase.dart';
import 'package:flutter_blogs/feature/auth/domain/entities/user.dart';
import 'package:flutter_blogs/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserLogin implements UseCase<User, UserLoginParams>{

  final AuthRepository authRepository;

  UserLogin( this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async{

    return authRepository.loginUpWithEmailPassword(
        email: params.email,
        password: params.password
    );

  }

}


class UserLoginParams{
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password,});
}