import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:swifty_proteins/src/presentation/views/homepage_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:swifty_proteins/src/presentation/views/login_view.dart';
import 'package:swifty_proteins/src/presentation/views/ligand_view.dart';
part 'app_router.gr.dart';


@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends _$AppRouter {

    @override
    List<AutoRoute> get routes => [
        CustomRoute(page: HomepageRoute.page, transitionsBuilder: TransitionsBuilders.noTransition, barrierColor: Colors.transparent),
        AutoRoute(page: LigandRoute.page),
        AutoRoute(page: LoginRoute.page, initial: true),
    ];
}

final appRouter = AppRouter();