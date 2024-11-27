import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_blogs/feature/auth/domain/usecases/user_login.dart';
import 'package:flutter_blogs/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  AuthBloc({required UserSignUp userSignUp, required UserLogin userLogin})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(UserSignUpParams(
      email: event.email,
      password: event.password,
      name: event.name,
    ));

    res.fold((l) => emit(AuthFailure(message: l.message)),
        (user) => emit(AuthLoaded(user: user)));
  }

  FutureOr<void> _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async{
    emit(AuthLoading());

 final res =  await _userLogin(UserLoginParams(
      email: event.email,
      password: event.password,
    ));

    res.fold((l) => emit(AuthFailure(message: l.message)),
            (r) => emit(AuthLoaded(user: r)));
  }
}
