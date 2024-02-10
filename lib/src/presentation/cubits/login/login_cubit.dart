import 'dart:developer';

import 'package:local_auth/local_auth.dart';
import 'package:swifty_proteins/src/config/config.dart';
import 'package:swifty_proteins/src/config/router/app_router.dart';
import 'package:swifty_proteins/src/data/parsing/parser.dart';
import 'package:swifty_proteins/src/domain/models/ligand/ligand.dart';
import 'package:swifty_proteins/src/domain/models/login_request.dart';
import 'package:swifty_proteins/src/domain/repositories/api_repository.dart';
import 'package:swifty_proteins/src/presentation/cubits/base/base_cubit.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:swifty_proteins/src/utils/resources/authentication_service.dart';
import 'package:swifty_proteins/src/utils/resources/data_state.dart';
import 'package:swifty_proteins/src/utils/resources/functions.dart';
import 'package:swifty_proteins/src/utils/resources/token_management.dart';

part 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState, Map<String, dynamic>> {

  LoginCubit() : super(const LoginSuccess(), {});

  Future<void> logInWithCredentials(String username, String password, {bool resumed = false}) async {
    if (isBusy) return;

    bool credentialsOK = await checkCredentials(username, password);
    if (credentialsOK) {
      if (resumed && appRouter.canPop()) {
        appRouter.pop();
      } else {
        appRouter.push(const HomepageRoute());
      }
    } else {
      displayErrorToast("Given Credentials are incorrect");
    }
  }

  Future<bool> loginWithBiometrics({bool resumed = false}) async {
    if (isBusy) return false;

    try {
      if (biometricsAvailable) {
        bool isAuthenticated = await authenticateWithBiometrics();
        if (isAuthenticated) {
          await storeCurrentUser("face_id");
          if (resumed && appRouter.canPop()) {
            appRouter.pop();
          } else {
            appRouter.push(const HomepageRoute());
          }
          return true;
        }
      }
    } catch (e) {
      logger.d(e);
    }
    return false;
  }
}
