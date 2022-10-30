import 'package:flutter_tries/core/network/network_info.dart';
import 'package:flutter_tries/features/posts/data/datasources/local_data_source.dart';
import 'package:flutter_tries/features/posts/data/datasources/remote_data_source.dart';
import 'package:flutter_tries/features/posts/data/repositories/post_repository_impl.dart';
import 'package:flutter_tries/features/posts/domain/repositories/posts_repository.dart';
import 'package:flutter_tries/features/posts/domain/usecases/add_post_use_case.dart';
import 'package:flutter_tries/features/posts/domain/usecases/delete_post_use_case.dart';
import 'package:flutter_tries/features/posts/domain/usecases/get_all_posts_use_case.dart';
import 'package:flutter_tries/features/posts/domain/usecases/update_post_use_case.dart';
import 'package:flutter_tries/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:flutter_tries/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {

  //? Features - posts

  //? Bloc
  sl.registerFactory(() => PostsBloc(getAllPostsUseCase: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostBloc(
    addPostUseCase: sl(),
    deletePostUseCase: sl(),
    updatePostUseCase: sl()
  ));

  //? Usecases
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUsecase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUsecase(sl()));

  //? Repository
  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
    remoteDataSource: sl(),
    localDataSource: sl(),
    networkInfo: sl()
  ));

  //? Datasources
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(sharedPreferences: sl()));

  //? Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //? External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}