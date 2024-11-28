import 'package:flutter_blogs/core/error/failure.dart';
import 'package:flutter_blogs/core/usecase/usecase.dart';
import 'package:flutter_blogs/feature/auth/domain/entities/user.dart';
import 'package:flutter_blogs/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async{

  return await authRepository.currentUser();

  }


}

