abstract class PageCommand {}

/// Command to inform the UI to show an ERROR message
class ShowErrorMessage extends PageCommand {
  ShowErrorMessage(this.message);

  final String message;
}

/// Command to inform the UI to show a REGULAR (not error) message
class ShowMessage extends PageCommand {
  ShowMessage(this.message);

  final String message;
}

/// Command to inform the UI to Navigate to a specific route
class NavigateToRoute extends PageCommand {
  NavigateToRoute(this.route);

  final String route;
}

/// Command to inform the UI to Navigate to a specific route and pass arguments
class NavigateToRouteWithArguments<T> extends PageCommand {
  NavigateToRouteWithArguments({
    required this.route,
    required this.arguments,
  });

  final String route;
  final T arguments;
}
