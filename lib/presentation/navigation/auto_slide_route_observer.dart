import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fm/shared/utils/utils.dart';

class AutoSlideRouteObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    LoggerUtils.printInfo('New route pushed: ${route.settings.name}');
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    LoggerUtils.printInfo('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    LoggerUtils.printInfo('Tab route re-visited: ${route.name}');
  }
}
