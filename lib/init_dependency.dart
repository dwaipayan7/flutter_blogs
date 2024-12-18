import 'package:flutter_blogs/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:flutter_blogs/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_blogs/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:flutter_blogs/feature/auth/domain/repository/auth_repository.dart';
import 'package:flutter_blogs/feature/auth/domain/usecases/current_user_usecase.dart';
import 'package:flutter_blogs/feature/auth/domain/usecases/user_login.dart';
import 'package:flutter_blogs/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_blogs/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_blogs/feature/blog/data/datasources/blog_remote_data_sources.dart';
import 'package:flutter_blogs/feature/blog/data/repository/blog_repository_impl.dart';
import 'package:flutter_blogs/feature/blog/domain/repository/blog_repository.dart';
import 'package:flutter_blogs/feature/blog/domain/usecases/get_all_blogs.dart';
import 'package:flutter_blogs/feature/blog/domain/usecases/upload_blog.dart';
import 'package:flutter_blogs/feature/blog/presentation/bloc/blog_bloc.dart';
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

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  // Initialize Auth dependencies
  _initAuth();
  _initBlog();
}

void _initAuth() {
  //Data Source
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator<SupabaseClient>()),
  );

  //Repository
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator<AuthRemoteDataSource>()),
  );

  //Use Cases
  serviceLocator.registerFactory(
    () => UserSignUp(serviceLocator<AuthRepository>()),
  );
  serviceLocator.registerFactory(
    () => UserLogin(serviceLocator<AuthRepository>()),
  );

  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));

  //Bloc
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator<UserSignUp>(),
      userLogin: serviceLocator<UserLogin>(),
      currentUser: serviceLocator<CurrentUser>(),
      appUserCubit: serviceLocator(),
    ),
  );
}

void _initBlog() {
  //Datasource
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(supabaseClient: serviceLocator()),
    )

    //repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        blogRemoteDataSource: serviceLocator(),
      ),
    )

    //usecase
    ..registerFactory(
      () => UploadBlog(
        blogRepository: serviceLocator(),
      ),
    )
    ..registerFactory(() => GetAllBlogs(blogRepository: serviceLocator()))

    //bloc
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlogs: serviceLocator(),
      ),
    );
}
