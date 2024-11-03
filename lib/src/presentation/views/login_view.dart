import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:swifty_proteins/src/config/app_assets.dart';
import 'package:swifty_proteins/src/config/app_colors.dart';
import 'package:swifty_proteins/src/config/config.dart';
import 'package:swifty_proteins/src/config/router/app_router.dart';
import 'package:swifty_proteins/src/presentation/cubits/login/login_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class LoginView extends HookWidget with WidgetsBindingObserver {
  final bool resumed;

  LoginView({Key? key, this.resumed = false}) : super (key: key);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);

    useEffect(() {
      if (resumed) {
        onLogin(context, loginCubit);
      } else {
        final observer = _LoginViewLifecycleObserver(context);
        WidgetsBinding.instance.addObserver(observer);
        return () {
          WidgetsBinding.instance.removeObserver(observer);
        };
      }
      return null;
    }, const []);

    return Scaffold(
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state.runtimeType == LoginLoading) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (state.runtimeType == LoginFailed) {
            return _buildBody(context, loginCubit, state.exception);
          } else {
            return _buildBody(context, loginCubit, null);
          }
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, LoginCubit loginCubit, DioException? error) {
    return Stack(
      children: [
        Center(child: Lottie.asset(AppAssets.lottieMolecule, width: 200, height: 200)),
        SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Expanded(child: SizedBox()),
                Text(tr("app_name_caps"),
                  style: const TextStyle(color: Colors.black87, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Expanded(flex: 3, child: SizedBox()),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.pink),
                    textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)),
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
                  ),
                  onPressed: () async {
                    await onLogin(context, loginCubit);
                  },
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(tr("login.login"),
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                  ),
                ),
                const SizedBox(height: 16,),
                GestureDetector(
                  onTap: () {
                    appRouter.push(SignUpRoute());
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Center(
                      child: Text(tr("login.signup"),
                        style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: Text(error == null ? "" : error.response?.data.toString() ?? "",
                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> onLogin(BuildContext context, LoginCubit loginCubit) async {
    bool loggedWithBiometric = await loginCubit.loginWithBiometrics(resumed: resumed);
    if (!loggedWithBiometric) {
      // ignore: use_build_context_synchronously
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(tr("login.connect_with_password"), style: const TextStyle(fontSize: 14),),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [

                TextField(
                  controller: usernameController,
                  cursorColor: Colors.deepPurple,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple, style: BorderStyle.solid, width: 1.5)
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: tr('login.username'),
                  ),
                ),
                const SizedBox(height: 16,),
                TextField(
                  controller: passwordController,
                  cursorColor: Colors.deepPurple,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple, style: BorderStyle.solid, width: 1.5)
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: tr('login.password'),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (usernameController.text != "" && passwordController.text != "") {
                    loginCubit.logInWithCredentials(usernameController.text, passwordController.text, resumed: resumed);
                  }
                },
                child: Text(tr("login.login"), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              ),
            ],
          );
        },
      );
    }
  }
}

class _LoginViewLifecycleObserver extends WidgetsBindingObserver {
  final BuildContext context;

  _LoginViewLifecycleObserver(this.context);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        !onGoingBiometrics) {
      appRouter.push(LoginRoute(resumed: true));
    }
  }
}