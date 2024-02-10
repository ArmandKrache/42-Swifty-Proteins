import 'package:easy_localization/easy_localization.dart';
import 'package:swifty_proteins/src/config/config.dart';
import 'package:swifty_proteins/src/config/router/app_router.dart';
import 'package:swifty_proteins/src/presentation/cubits/base/base_cubit.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:swifty_proteins/src/utils/resources/authentication_service.dart';
import 'package:swifty_proteins/src/utils/resources/functions.dart';

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
      displayErrorToast(tr("errors.incorrect_credentials"));
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
