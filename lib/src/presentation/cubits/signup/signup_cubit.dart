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

part 'signup_state.dart';

class SignupCubit extends BaseCubit<SignupState, Map<String, dynamic>> {
  SignupCubit() : super(const SignupLoading(), {});

  Future<void> signup({required String username, required String password}) async {
    if (isBusy) return;

    if (await checkIfUserIsRegistered(username, password)) {
      displayErrorToast("Username is already taken");
      return;
    }
    await storeUser(username, password);
    await storeCurrentUser(username);
    appRouter.push(const HomepageRoute());
    return;
  }

  Future<void> signupWithBiometrics({required String username, required String password, bool biometrics = false}) async {
    if (isBusy) return;

    if (biometricsAvailable) {
      bool isAuthenticated = await authenticateWithBiometrics();
      if (isAuthenticated) {
        await storeCurrentUser("face_id");
        appRouter.push(const HomepageRoute());
      }
    }
  }

}