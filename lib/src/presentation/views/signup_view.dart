import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swifty_proteins/src/config/app_assets.dart';
import 'package:swifty_proteins/src/config/app_colors.dart';
import 'package:swifty_proteins/src/config/config.dart';
import 'package:swifty_proteins/src/config/router/app_router.dart';
import 'package:swifty_proteins/src/data/parsing/parser.dart';
import 'package:swifty_proteins/src/domain/models/ligand/ligand.dart';
import 'package:swifty_proteins/src/domain/models/login_request.dart';
import 'package:swifty_proteins/src/presentation/cubits/login/login_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
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
      signupCubit.checkBiometricsAvailability();
      return ;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple, style: BorderStyle.solid, width: 1.5)
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Username',
                  ),
                ),
                const SizedBox(height: 16,),
                TextField(
                  controller: passwordController,
                  cursorColor: Colors.deepPurple,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple, style: BorderStyle.solid, width: 1.5)
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Password',
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
                      /**if (signupCubit.biometricsAvailable) {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              content: Container(
                                padding: const EdgeInsets.all(16),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Do you want to register using biometrics authentication?",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    appRouter.pop();
                                  },
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    appRouter.pop();
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                            );
                          },
                        );
                      }**/
                      signupCubit.signup(username: usernameController.text, password: passwordController.text);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text("Sign Up",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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

  Widget _buildBody(BuildContext context, LoginCubit remoteLoginCubit, DioException? error) {
    return Stack(
      children: [
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
                  onPressed: () {
                    remoteLoginCubit.logIn(LoginRequest(client_id: "", client_secret: ""));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(tr("log_in"),
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Center(
                    child: Text(error == null ? "" : error.response?.data.toString() ?? "",
                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
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
}
