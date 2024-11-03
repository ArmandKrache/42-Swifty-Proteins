import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:swifty_proteins/src/config/app_colors.dart';
import 'package:swifty_proteins/src/config/config.dart';
import 'package:swifty_proteins/src/presentation/cubits/login/login_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:swifty_proteins/src/presentation/cubits/signup/signup_cubit.dart';

@RoutePage()
class SignUpView extends HookWidget {

  SignUpView({Key? key}) : super (key: key);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signupCubit = BlocProvider.of<SignupCubit>(context);

    useEffect(() {
      return ;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: Text(tr("login.signup")),
      ),
      body: BlocBuilder<SignupCubit, SignupState>(
        builder: (context, state) {
          if (state.runtimeType == LoginLoading) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (state.runtimeType == LoginFailed) {
            return _buildBodyWithPassword(context, signupCubit, state.exception);
          } else {
            return _buildBodyWithPassword(context, signupCubit, null);
          }
        },
      ),
    );
  }

  Widget _buildBodyWithPassword(BuildContext context, SignupCubit signupCubit, DioException? error) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Expanded(flex: 2, child: SizedBox()),
            Column(
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
                    hintText: tr("login.username"),
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
                    hintText: tr("login.password"),
                  ),
                ),
                const SizedBox(height: 16,),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.pink),
                    textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)),
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
                  ),
                  onPressed: () async {
                    if (usernameController.text != "" && passwordController.text != "") {
                      signupCubit.signup(username: usernameController.text, password: passwordController.text);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(tr("login.signup"),
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16,),
                Visibility(
                  visible: biometricsAvailable,
                  child: GestureDetector(
                    onTap: () {
                      signupCubit.signupWithBiometrics();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: Center(
                        child: Text(tr("login.signup_with_biometrics"),
                          style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
