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

/// generated route for
/// [MiscControlsTrackballView]
class MiscControlsTrackballRoute
    extends PageRouteInfo<MiscControlsTrackballRouteArgs> {
  MiscControlsTrackballRoute({
    Key? key,
    required String fileName,
    List<PageRouteInfo>? children,
  }) : super(
          MiscControlsTrackballRoute.name,
          args: MiscControlsTrackballRouteArgs(
            key: key,
            fileName: fileName,
          ),
          initialChildren: children,
        );

  static const String name = 'MiscControlsTrackballRoute';

  static const PageInfo<MiscControlsTrackballRouteArgs> page =
      PageInfo<MiscControlsTrackballRouteArgs>(name);
}

class MiscControlsTrackballRouteArgs {
  const MiscControlsTrackballRouteArgs({
    this.key,
    required this.fileName,
  });

  final Key? key;

  final String fileName;

  @override
  String toString() {
    return 'MiscControlsTrackballRouteArgs{key: $key, fileName: $fileName}';
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
/// [WebGlCameraView]
class WebGlCameraRoute extends PageRouteInfo<WebGlCameraRouteArgs> {
  WebGlCameraRoute({
    Key? key,
    required String fileName,
    List<PageRouteInfo>? children,
  }) : super(
          WebGlCameraRoute.name,
          args: WebGlCameraRouteArgs(
            key: key,
            fileName: fileName,
          ),
          initialChildren: children,
        );

  static const String name = 'WebGlCameraRoute';

  static const PageInfo<WebGlCameraRouteArgs> page =
      PageInfo<WebGlCameraRouteArgs>(name);
}

class WebGlCameraRouteArgs {
  const WebGlCameraRouteArgs({
    this.key,
    required this.fileName,
  });

  final Key? key;

  final String fileName;

  @override
  String toString() {
    return 'WebGlCameraRouteArgs{key: $key, fileName: $fileName}';
  }
}
