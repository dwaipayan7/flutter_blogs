import 'package:flutter_blogs/core/error/failure.dart';
import 'package:flutter_blogs/core/usecase/usecase.dart';

import 'package:flutter_blogs/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/common/entities/user.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);
  @override
  Future<Either<Failure,User>> call(UserSignUpParams params) async{

 return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password
  );

  }

}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;

  UserSignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
