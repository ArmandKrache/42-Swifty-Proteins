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

@RoutePage()
class LoginView extends HookWidget {

  LoginView({Key? key}) : super (key: key);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);

    useEffect(() {
      //loginCubit.isAlreadyLoggedIn();
      return ;
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

  Widget _buildBody(BuildContext context, LoginCubit remoteLoginCubit, DioException? error) {
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
                const SizedBox(height: 16,),
                GestureDetector(
                  onTap: () {
                    appRouter.push(SignUpRoute());
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: const Center(
                      child: Text("Sign up",
                        style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16),
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
}
