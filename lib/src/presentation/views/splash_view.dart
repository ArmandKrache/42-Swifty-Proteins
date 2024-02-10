import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:swifty_proteins/src/config/app_assets.dart';
import 'package:swifty_proteins/src/config/router/app_router.dart';
import 'package:swifty_proteins/src/presentation/views/login_view.dart';

@RoutePage()
class SplashView extends StatefulWidget {

  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      appRouter.push(LoginRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(child: Lottie.asset(AppAssets.lottieMolecule, width: 200, height: 200)),
    );
  }
}