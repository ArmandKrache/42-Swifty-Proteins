import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_gl/flutter_gl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';

const storage = FlutterSecureStorage();
final logger = Logger();

final LocalAuthentication localAuth = LocalAuthentication();
bool biometricsAvailable = false;
bool onGoingBiometrics = false;

Future<void> checkBiometricsAvailability() async {
  biometricsAvailable = await localAuth.isDeviceSupported();
}

Future<bool> authenticateWithBiometrics() async {
  onGoingBiometrics = true;
  bool isAuthenticated = await localAuth.authenticate(
    localizedReason: tr("login.biometrics_hint"),
  );
  Future.delayed(const Duration(seconds: 2), () {
    onGoingBiometrics = false;
  });
  return isAuthenticated;
}
