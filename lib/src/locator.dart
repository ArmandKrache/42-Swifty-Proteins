
import 'package:swifty_companion/src/data/api_repository_impl.dart';
import 'package:swifty_companion/src/data/api_service.dart';
import 'package:swifty_companion/src/domain/repositories/api_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:swifty_companion/src/utils/resources/token_management.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies ( ) async {
  final dio = Dio();
  dio.interceptors.add(TokenInterceptor());
  locator.registerSingleton<Dio>(dio);
  locator.registerSingleton<ApiService>(
    ApiService(locator<Dio>()),
  );
  locator.registerSingleton<ApiRepository>(
    ApiRepositoryImpl(locator<ApiService>()),
  );
 }