import 'package:get_it/get_it.dart';
import 'package:softwarica_student_management_bloc/core/network/hive_service.dart';
import 'package:softwarica_student_management_bloc/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:softwarica_student_management_bloc/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:softwarica_student_management_bloc/features/auth/domain/use_case/login_usecase.dart';
import 'package:softwarica_student_management_bloc/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:softwarica_student_management_bloc/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:softwarica_student_management_bloc/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/data_source/local_datasource/batch_local_datasource.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/repository/batch_local_repository/batch_local_repository.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/create_batch_usecase.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/delete_batch_usecase.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/get_all_batch_usecase.dart';
import 'package:softwarica_student_management_bloc/features/batch/presentation/view_model/batch_bloc.dart';
import 'package:softwarica_student_management_bloc/features/course/data/data_source/local_datasource/course_local_datasource.dart';
import 'package:softwarica_student_management_bloc/features/course/data/repository/course_local_repository/course_local_repository.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/use_case/create_course_usecase.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/use_case/delete_course_usecase.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/use_case/get_all_course_usecase.dart';
import 'package:softwarica_student_management_bloc/features/course/presentation/view_model/course_bloc.dart';
import 'package:softwarica_student_management_bloc/features/home/presentation/view_model/home_cubit.dart';
import 'package:softwarica_student_management_bloc/features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initHiveService();
  await _initBatchDependencies();
  await _initCourseDependencies();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initSplashScreenDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(
    () => HiveService(),
  );
}

_initBatchDependencies() async {
  // local datasource
  getIt.registerLazySingleton<BatchLocalDatasource>(
    () => BatchLocalDatasource(
      hiveService: getIt(),
    ),
  );

  // local data repository
  getIt.registerLazySingleton<BatchLocalRepository>(
    () => BatchLocalRepository(
      batchLocalDatasource: getIt(),
    ),
  );

  // use case
  getIt.registerLazySingleton<GetAllBatchUsecase>(
    () => GetAllBatchUsecase(
      repository: getIt<BatchLocalRepository>(),
    ),
  );

  getIt.registerLazySingleton<CreateBatchUsecase>(
    () => CreateBatchUsecase(
      repository: getIt<BatchLocalRepository>(),
    ),
  );

  getIt.registerLazySingleton<DeleteBatchUsecase>(
    () => DeleteBatchUsecase(
      repository: getIt<BatchLocalRepository>(),
    ),
  );

  // bloc
  getIt.registerFactory<BatchBloc>(
    () => BatchBloc(
      createBatchUsecase: getIt<CreateBatchUsecase>(),
      deleteBatchUsecase: getIt<DeleteBatchUsecase>(),
      getAllBatchUsecase: getIt<GetAllBatchUsecase>(),
    ),
  );
}

_initCourseDependencies() async {
  // local datasource
  getIt.registerLazySingleton<CourseLocalDatasource>(
    () => CourseLocalDatasource(
      hiveService: getIt(),
    ),
  );

  // local data repository
  getIt.registerLazySingleton<CourseLocalRepository>(
    () => CourseLocalRepository(
      courseLocalDatasource: getIt(),
    ),
  );

  // use case
  getIt.registerLazySingleton<GetAllCourseUsecase>(
    () => GetAllCourseUsecase(
      repository: getIt<CourseLocalRepository>(),
    ),
  );

  getIt.registerLazySingleton<CreateCourseUsecase>(
    () => CreateCourseUsecase(
      repository: getIt<CourseLocalRepository>(),
    ),
  );

  getIt.registerLazySingleton<DeleteCourseUsecase>(
    () => DeleteCourseUsecase(
      repository: getIt<CourseLocalRepository>(),
    ),
  );

  // bloc
  getIt.registerFactory<CourseBloc>(
    () => CourseBloc(
      createCourseUsecase: getIt<CreateCourseUsecase>(),
      deleteCourseUsecase: getIt<DeleteCourseUsecase>(),
      getAllCourseUsecase: getIt<GetAllCourseUsecase>(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthLocalRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      batchBloc: getIt<BatchBloc>(),
      courseBloc: getIt<CourseBloc>(),
      registerUseCase: getIt(),
    ),
  );
}

_initLoginDependencies() async {
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthLocalRepository>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<LoginBloc>()),
  );
}
