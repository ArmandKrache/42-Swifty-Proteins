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
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginView(key: args.key),
      );
    },
    StudentRoute.name: (routeData) {
      final args = routeData.argsAs<StudentRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: StudentView(
          key: args.key,
          studentId: args.studentId,
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
/// [StudentView]
class StudentRoute extends PageRouteInfo<StudentRouteArgs> {
  StudentRoute({
    Key? key,
    required String studentId,
    List<PageRouteInfo>? children,
  }) : super(
          StudentRoute.name,
          args: StudentRouteArgs(
            key: key,
            studentId: studentId,
          ),
          initialChildren: children,
        );

  static const String name = 'StudentRoute';

  static const PageInfo<StudentRouteArgs> page =
      PageInfo<StudentRouteArgs>(name);
}

class StudentRouteArgs {
  const StudentRouteArgs({
    this.key,
    required this.studentId,
  });

  final Key? key;

  final String studentId;

  @override
  String toString() {
    return 'StudentRouteArgs{key: $key, studentId: $studentId}';
  }
}
