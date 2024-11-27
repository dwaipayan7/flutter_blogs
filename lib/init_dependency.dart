import 'package:flutter_blogs/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_blogs/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:flutter_blogs/feature/auth/domain/repository/auth_repository.dart';
import 'package:flutter_blogs/feature/auth/domain/usecases/user_login.dart';
import 'package:flutter_blogs/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_blogs/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/secrets/app_secret.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Initialize Supabase
  await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  // Register Supabase client
  serviceLocator.registerLazySingleton<SupabaseClient>(
    () => Supabase.instance.client,
  );

  // Initialize Auth dependencies
  _initAuth();
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator<SupabaseClient>()),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator<AuthRemoteDataSource>()),
  );

  serviceLocator.registerFactory(
    () => UserSignUp(serviceLocator<AuthRepository>()),
  );
  serviceLocator.registerFactory(
        () => UserLogin(serviceLocator<AuthRepository>()),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator<UserSignUp>(),
      userLogin: serviceLocator<UserLogin>(),
    ),
  );
}
