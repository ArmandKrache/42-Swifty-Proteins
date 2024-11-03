import 'package:easy_localization/easy_localization.dart';
import 'package:swifty_proteins/src/config/config.dart';
import 'package:swifty_proteins/src/config/router/app_router.dart';
import 'package:swifty_proteins/src/presentation/cubits/base/base_cubit.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:swifty_proteins/src/utils/resources/authentication_service.dart';
import 'package:swifty_proteins/src/utils/resources/functions.dart';

part 'signup_state.dart';

class SignupCubit extends BaseCubit<SignupState, Map<String, dynamic>> {
  SignupCubit() : super(const SignupLoading(), {});

  Future<void> signup({required String username, required String password}) async {
    if (isBusy) return;

    if (await checkIfUserIsRegistered(username, password)) {
      displayErrorToast(tr("errors.username_is_taken"));
      return;
    }
    await storeUser(username, password);
    await storeCurrentUser(username);
    appRouter.push(const HomepageRoute());
    return;
  }

  Future<void> signupWithBiometrics() async {
    if (isBusy) return;

    if (biometricsAvailable) {
      bool isAuthenticated = await authenticateWithBiometrics();
      if (isAuthenticated) {
        await storeCurrentUser("face_id");
        appRouter.push(const HomepageRoute());
      } else {
        displayErrorToast(tr("errors.biometrics_signup_failed"));
      }
    }
  }

}
