import 'package:swifty_proteins/src/config/config.dart';

Future<void> storeCurrentUser(String username) async {
  await storage.write(key: 'current_user', value: username);
}

Future<void> removeCurrentUser() async {
  await storage.delete(key: 'current_user');
}

Future<void> storeUser(String username, String password) async {
  await storage.write(key: 'username_$username', value: username);
  await storage.write(key: 'password_$username', value: password);
}

Future<void> deleteUser(String username) async {
  await storage.delete(key: 'username_$username');
  await storage.delete(key: 'password_$username');
}


Future<bool> checkIfUserIsRegistered(String username, String password) async {
  if (await storage.containsKey(key: "username_$username") &&
      await storage.containsKey(key: "password_$username")) {
    return true;
  }
  return false;
}

Future<bool> checkCredentials(String username, String password) async {
  if (await checkIfUserIsRegistered(username, password)) {
    if (await storage.read(key: "password_$username") == password) {
      return true;
    }
  }
  return false;
}