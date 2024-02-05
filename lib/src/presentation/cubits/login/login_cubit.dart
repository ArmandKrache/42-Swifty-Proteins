import 'dart:developer';

import 'package:swifty_proteins/src/config/config.dart';
import 'package:swifty_proteins/src/config/router/app_router.dart';
import 'package:swifty_proteins/src/data/parsing/parser.dart';
import 'package:swifty_proteins/src/domain/models/ligand/ligand.dart';
import 'package:swifty_proteins/src/domain/models/login_request.dart';
import 'package:swifty_proteins/src/domain/repositories/api_repository.dart';
import 'package:swifty_proteins/src/presentation/cubits/base/base_cubit.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:swifty_proteins/src/utils/resources/data_state.dart';
import 'package:swifty_proteins/src/utils/resources/token_management.dart';

part 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState, Map<String, dynamic>> {
  final ApiRepository _apiRepository;

  LoginCubit(this._apiRepository) : super(const LoginLoading(), {});

  Future<Ligand?> fetchLigand() async {
    if (isBusy) return null;

    final response =
      await _apiRepository.getLigand("HEM");

    if (response is DataSuccess) {
      logger.d(response.data);

      return parseRawData(response.data);

    } else if (response is DataFailed) {
      logger.d(response.exception);
    }
    return null;
  }

  Future<void> logIn(LoginRequest request) async {
    if (isBusy) return;

      await run(() async {
        final response =
          await _apiRepository.getTokens(request: request);
        //log(response.data!.accessToken);

        if (response is DataSuccess) {
          final access = response.data!.accessToken;

          await storeAccessToken(access);

          appRouter.push(const HomepageRoute());
          emit(const LoginSuccess());
        } else if (response is DataFailed) {
          emit(const LoginLoading());
          emit(LoginFailed(exception: response.exception));
        }
      });
  }

  Future<void> isAlreadyLoggedIn() async {
    final response =
      await _apiRepository.getTokenInfo();
    if (response is DataSuccess) {
      final expiresIn = response.data!.expiresIn;

      if (expiresIn > 0) {
        appRouter.push(const HomepageRoute());
        emit(const LoginSuccess());
      } else {
        emit(const LoginSuccess());
      }
    } else if (response is DataFailed) {
      emit(const LoginLoading());
      emit(LoginFailed(exception: response.exception));
    }
  }
}
