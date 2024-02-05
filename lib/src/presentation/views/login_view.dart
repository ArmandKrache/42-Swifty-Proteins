import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swifty_proteins/.secret.dart';
import 'package:swifty_proteins/src/config/app_assets.dart';
import 'package:swifty_proteins/src/config/app_colors.dart';
import 'package:swifty_proteins/src/config/config.dart';
import 'package:swifty_proteins/src/data/parsing/parser.dart';
import 'package:swifty_proteins/src/domain/models/ligand/ligand.dart';
import 'package:swifty_proteins/src/domain/models/login_request.dart';
import 'package:swifty_proteins/src/presentation/cubits/login/login_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class LoginView extends HookWidget {

  LoginView({Key? key}) : super (key: key);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /*Future<Ligand> ligand = parseFromFile(AppAssets.testFileHEM);

    ligand.then((Ligand ligand) {
      logger.d(ligand);
    }).catchError((error) {
      logger.d('Error : $error');
    });*/

    final loginCubit = BlocProvider.of<LoginCubit>(context);

    useEffect(() {
      loginCubit.isAlreadyLoggedIn();
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
        Image.asset(AppAssets.orderBackground, fit: BoxFit.fitHeight, height: double.maxFinite,),
        SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Expanded(child: SizedBox()),
                SvgPicture.asset(AppAssets.white42LogoSVG, width: 192,),
                const SizedBox(height: 8,),
                Text(tr("app_name_caps"),
                  style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Expanded(flex: 3, child: SizedBox()),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.order),
                    textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)),
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
                  ),
                  onPressed: () {
                    remoteLoginCubit.logIn(LoginRequest(client_id: client_id, client_secret: client_secret));
                  },
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(tr("log_in"),
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.order),
                    textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)),
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
                  ),
                  onPressed: () {
                    remoteLoginCubit.fetchLigand();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(tr("Test Fetch"),
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
