import 'package:flutter/services.dart';
import 'package:swifty_proteins/src/config/config.dart';
import 'package:swifty_proteins/src/config/router/app_router.dart';
import 'package:swifty_proteins/src/config/app_themes.dart';
import 'package:swifty_proteins/src/domain/repositories/api_repository.dart';
import 'package:swifty_proteins/src/locator.dart';
import 'package:swifty_proteins/src/presentation/cubits/homepage/homepage_cubit.dart';
import 'package:swifty_proteins/src/presentation/cubits/ligand/ligand_cubit.dart';
import 'package:swifty_proteins/src/presentation/cubits/login/login_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('fr')],
      path: 'assets/translations/',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp()
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomepageCubit(
          locator<ApiRepository>(),),
        ),
        BlocProvider(create: (context) => LoginCubit(
          locator<ApiRepository>(),),
        ),
        BlocProvider(create: (context) => LigandCubit(
          locator<ApiRepository>(),),
        ),
      ],
      child: OKToast(child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter.config(),
        title: 'Swifty Proteins',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: AppTheme.light,
      )),
    );
  }
}
