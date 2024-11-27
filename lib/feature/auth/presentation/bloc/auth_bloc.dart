import 'package:bloc/bloc.dart';
import 'package:flutter_blogs/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({
    required UserSignUp userSignUp,
}) : _userSignUp = userSignUp, super(AuthInitial()) {

    on<AuthSignUp>((event, emit) async{
      emit(AuthLoading());
    final res = await _userSignUp(UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ));
    
    res.fold(
            (l) => emit(AuthFailure(
                message:l.message)),
            (user) => emit(AuthLoaded(user: user))
    );
    });

  }
}
