import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/src/presentation/widgets/common_widgets.dart';
import 'package:flutter_clean_architecture/src/utils/constants/strings.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/local/app_database.dart';
import 'data/datasources/local/assam_app_database.dart';
import 'data/datasources/remote/api_service.dart';
import 'data/repositories/api_repository_impl.dart';
import 'data/repositories/database_repository_impl.dart';
import 'domain/repositories/api_repository.dart';
import 'domain/repositories/database_repository.dart';

final locator = GetIt.instance;
final assamAppDatabase = GetIt.instance;
Future<void> initializeSize(BuildContext context) async{
  SizeConfig sizeConfig = new SizeConfig();
  sizeConfig.initSize(context);
}
Future<void> initializeDependencies() async {

  final assamDb = await $FloorAssamAppDatabase.databaseBuilder(databaseName).build();
  // final db = await $FloorAppDatabase.databaseBuilder(databaseName).build();
  locator.registerSingleton<AssamAppDatabase>(assamDb);

  final dio = Dio();
  dio.options = BaseOptions(headers: <String, dynamic>{
    "Content-Type": "application/json",
    'Accept': 'application/json',
  });

  dio.interceptors.add(
    DioLoggingInterceptor(
      level: Level.body,
      compact: false,
    ),
  );

  dio.interceptors.add(AwesomeDioInterceptor());

  locator.registerSingleton<Dio>(dio);

  locator.registerSingleton<ApiService>(
    ApiService(locator<Dio>()),
  );

  locator.registerSingleton<ApiRepository>(
    ApiRepositoryImpl(locator<ApiService>()),
  );

  // locator.registerSingleton<DatabaseRepository>(
  //   DatabaseRepositoryImpl(locator<AppDatabase>()),
  // );
}