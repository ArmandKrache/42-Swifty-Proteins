import 'dart:developer';

import 'package:swifty_companion/src/config/router/app_router.dart';
import 'package:swifty_companion/src/domain/models/requests/login_request.dart';
import 'package:swifty_companion/src/domain/repositories/api_repository.dart';
import 'package:swifty_companion/src/presentation/cubits/base/base_cubit.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:swifty_companion/src/utils/resources/data_state.dart';

part 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState, Map<String, dynamic>> {
  final ApiRepository _apiRepository;

  LoginCubit(this._apiRepository) : super(const LoginSuccess(), {});

  Future<void> logIn(LoginRequest request) async {
    if (isBusy) return;

      await run(() async {
        final response =
          await _apiRepository.getTokens(request: request);
        log(response.data!.accessToken);

        if (response is DataSuccess) {
          final access = response.data!.accessToken;

          ///await storeAccessToken(access);

          appRouter.push(const HomepageRoute());

          emit(const LoginSuccess());
        } else if (response is DataFailed) {
          emit(const LoginLoading());
          emit(LoginFailed(exception: response.exception));
        }
      });
  }

  Future<void> isAlreadyLoggedIn() async {
    final access = null;  /// await getAccessToken();

    if (access == null) {
      return ;
    }

    appRouter.push(const HomepageRoute());
    emit(const LoginSuccess());
  }
}
