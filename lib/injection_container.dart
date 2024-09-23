import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmgmt/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:taskmgmt/features/auth/domain/repositories/auth_repository.dart';
import 'package:taskmgmt/features/auth/domain/usecases/login_usecase.dart';
import 'package:taskmgmt/features/auth/domain/usecases/signup_usecsae.dart';
import 'package:taskmgmt/features/task/data/repositories/task_repository_impl.dart';
import 'package:taskmgmt/features/task/domain/repositories/task_repository.dart';
import 'package:taskmgmt/features/task/domain/usecases/add_task_usecase.dart';
import 'package:taskmgmt/features/task/domain/usecases/delete_task_usecase.dart';
import 'package:taskmgmt/features/task/domain/usecases/filter_task_usecase.dart';
import 'package:taskmgmt/features/task/domain/usecases/get_tasks_usecase.dart';
import 'package:taskmgmt/features/task/presentation/bloc/task_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl()));

  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => SignupUsecase(sl()));

  sl.registerLazySingleton(() => AddTaskUsecase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUsecase(sl()));
  sl.registerLazySingleton(() => GetTasksUsecase(sl()));
  sl.registerLazySingleton(() => FilterTasksUseCase(sl()));

  sl.registerFactory(() => TaskBloc(
        addTaskUsecase: sl(),
        deleteTaskUsecase: sl(),
        getTasksUseCase: sl(),
        filterTasksUseCase: sl(),
      ));
}
