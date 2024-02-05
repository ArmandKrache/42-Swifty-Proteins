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
        child: LoginView(key: args.key),
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
    List<PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<LoginRouteArgs> page = PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}
