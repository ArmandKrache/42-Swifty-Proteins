// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    HomepageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomepageView(),
      );
    },
    LigandRoute.name: (routeData) {
      final args = routeData.argsAs<LigandRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LigandView(
          key: args.key,
          ligandId: args.ligandId,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginView(
          key: args.key,
          resumed: args.resumed,
        ),
      );
    },
    Model3DRoute.name: (routeData) {
      final args = routeData.argsAs<Model3DRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: Model3DView(
          key: args.key,
          ligand: args.ligand,
        ),
      );
    },
    SignUpRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpRouteArgs>(
          orElse: () => const SignUpRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SignUpView(key: args.key),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashView(),
      );
    },
  };
}

/// generated route for
/// [HomepageView]
class HomepageRoute extends PageRouteInfo<void> {
  const HomepageRoute({List<PageRouteInfo>? children})
      : super(
          HomepageRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomepageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LigandView]
class LigandRoute extends PageRouteInfo<LigandRouteArgs> {
  LigandRoute({
    Key? key,
    required String ligandId,
    List<PageRouteInfo>? children,
  }) : super(
          LigandRoute.name,
          args: LigandRouteArgs(
            key: key,
            ligandId: ligandId,
          ),
          initialChildren: children,
        );

  static const String name = 'LigandRoute';

  static const PageInfo<LigandRouteArgs> page = PageInfo<LigandRouteArgs>(name);
}

class LigandRouteArgs {
  const LigandRouteArgs({
    this.key,
    required this.ligandId,
  });

  final Key? key;

  final String ligandId;

  @override
  String toString() {
    return 'LigandRouteArgs{key: $key, ligandId: $ligandId}';
  }
}

/// generated route for
/// [LoginView]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    Key? key,
    bool resumed = false,
    List<PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            resumed: resumed,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<LoginRouteArgs> page = PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    this.resumed = false,
  });

  final Key? key;

  final bool resumed;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, resumed: $resumed}';
  }
}

/// generated route for
/// [Model3DView]
class Model3DRoute extends PageRouteInfo<Model3DRouteArgs> {
  Model3DRoute({
    Key? key,
    required Ligand ligand,
    List<PageRouteInfo>? children,
  }) : super(
          Model3DRoute.name,
          args: Model3DRouteArgs(
            key: key,
            ligand: ligand,
          ),
          initialChildren: children,
        );

  static const String name = 'Model3DRoute';

  static const PageInfo<Model3DRouteArgs> page =
      PageInfo<Model3DRouteArgs>(name);
}

class Model3DRouteArgs {
  const Model3DRouteArgs({
    this.key,
    required this.ligand,
  });

  final Key? key;

  final Ligand ligand;

  @override
  String toString() {
    return 'Model3DRouteArgs{key: $key, ligand: $ligand}';
  }
}

/// generated route for
/// [SignUpView]
class SignUpRoute extends PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SignUpRoute.name,
          args: SignUpRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const PageInfo<SignUpRouteArgs> page = PageInfo<SignUpRouteArgs>(name);
}

class SignUpRouteArgs {
  const SignUpRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key}';
  }
}

/// generated route for
/// [SplashView]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
