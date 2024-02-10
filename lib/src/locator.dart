import 'package:swifty_proteins/src/data/api_repository_impl.dart';
import 'package:swifty_proteins/src/data/api_service.dart';
import 'package:swifty_proteins/src/domain/repositories/api_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies ( ) async {
  final dio = Dio();
  locator.registerSingleton<Dio>(dio);
  locator.registerSingleton<ApiService>(
    ApiService(locator<Dio>()),
  );
  locator.registerSingleton<ApiRepository>(
    ApiRepositoryImpl(locator<ApiService>()),
  );
 }