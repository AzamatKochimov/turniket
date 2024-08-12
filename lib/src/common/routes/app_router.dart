import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../../feature/home/presentation/pages/home.dart";
import "../../feature/main/presentation/pages/main_page.dart";
import "app_route_name.dart";

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "root");
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "shell");

@immutable
class AppRouter {
  factory AppRouter() => _router;

  const AppRouter._internal();

  static const AppRouter _router = AppRouter._internal();

  static final GoRouter router = GoRouter(
    initialLocation: AppRouteName.homePage,
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return MainPage(
            child: child,
          );
        },
        routes: <RouteBase>[
          GoRoute(
            name: "Records Page",
            path: AppRouteName.homePage,
            builder: (BuildContext context, GoRouterState state) {
              return const HomePage();
            },
          ),
        ],
      ),
    ],
  );
}

@immutable
final class BlockedRouter {
  factory BlockedRouter() => _router;

  const BlockedRouter._internal();

  static const BlockedRouter _router = BlockedRouter._internal();

  static final GoRouter router = GoRouter(
    initialLocation: AppRouteName.blockedPage,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        name: "BlockedPage",
        path: AppRouteName.blockedPage,
        builder: (BuildContext context, GoRouterState state) {
          return const Scaffold(
            body: Center(
              child: Text("App is permanently blocked !!!"),
            ),
          );
        },
      ),
    ],
  );
}
