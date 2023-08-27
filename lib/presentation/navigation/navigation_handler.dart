import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_fm/presentation/navigation/app_router.gr.dart';

final appRouter = AppRouter();

class NavigationHandler {
  static bool? isCurrentScreen(BuildContext? context) {
    if (context == null) {
      return null;
    }

    return ModalRoute.of(context)!.isCurrent;
  }

  static String? getCurrentScreen(BuildContext? context) {
    if (context == null) {
      return null;
    }

    return ModalRoute.of(context)!.settings.name;
  }

  static Future<void> push({
    BuildContext? context,
    required PageRouteInfo route,
    bool? skipSameRouteCheck,
  }) async {
    final _skipSameRouteCheck = skipSameRouteCheck ?? true;
    final asyncRoute = await buildPageAsync(route: route);
    if (!_skipSameRouteCheck &&
        getCurrentScreen(context) == asyncRoute.routeName) {
      return null;
    }

    await appRouter.push(asyncRoute);
  }

  static Future<bool> pop<T extends Object>({T? result}) async {
    return appRouter.pop<T>(result);
  }

  static Future<void> popToRoot() async {
    return appRouter.popUntilRoot();
  }

  static bool canPopCurrentRoute<T>() {
    return appRouter.canPopSelfOrChildren;
  }

  static Future<void> reset({required PageRouteInfo route}) async {
    return appRouter.pushAndPopUntil<void>(
      route,
      predicate: (r) => false,
    );
  }

  static Future replace({required PageRouteInfo route}) async {
    return appRouter.replace(route);
  }

  static Future<void> replaceAll({required List<PageRouteInfo> routes}) async {
    return appRouter.replaceAll(routes);
  }

  static Future<PageRouteInfo> buildPageAsync(
      {required PageRouteInfo route}) async {
    return Future.microtask(() {
      return route;
    });
  }
}
