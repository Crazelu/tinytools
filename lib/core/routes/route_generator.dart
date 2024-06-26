import 'package:flutter/material.dart';
import 'package:tools/core/routes/routes.dart';
import 'package:tools/pages.dart';

class RouteGenerator {
  /// Generates routes, extracts and passes navigation arguments.
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return _getPageRoute(
          const HomePage(),
          Routes.home,
        );

      default:
        return _getPageRoute(_errorScreen());
    }
  }

  /// Wraps widget with a MaterialPageRoute and adds route settings
  static MaterialPageRoute _getPageRoute(
    Widget child, [
    String? routeName,
    dynamic args,
  ]) =>
      MaterialPageRoute(
        builder: (context) => child,
        settings: RouteSettings(
          name: routeName,
          arguments: args,
        ),
      );

  /// Error screen shown when app attempts navigating to an unknown route
  static Widget _errorScreen({String message = "Error! Screen not found"}) =>
      Scaffold(
        appBar: AppBar(
            title: const Text(
          'Screen not found',
          style: TextStyle(color: Colors.red),
        )),
        body: Center(
          child: Text(
            message,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
}
