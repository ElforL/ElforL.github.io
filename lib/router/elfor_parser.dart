import 'package:flutter/material.dart';
import 'package:laith_shono/router/elfor_configuration.dart';
import 'package:laith_shono/screens/project_screen.dart';

class ElforInformationParser extends RouteInformationParser<ElforConfiguration> {
  @override
  Future<ElforConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');
    if (uri.pathSegments.isEmpty) {
      return ElforConfiguration.home();
    } else if (uri.pathSegments.first == ProjectScreen.routeName && uri.pathSegments.length >= 2) {
      return ElforConfiguration.project(uri.pathSegments[1]);
    } else {
      return ElforConfiguration.unknown();
    }
  }

  @override
  RouteInformation? restoreRouteInformation(ElforConfiguration configuration) {
    if (configuration.isHome) {
      return RouteInformation(location: '/');
    } else if (configuration.isProjectPage) {
      return RouteInformation(location: '/project/${configuration.selectedProjectTitle}');
    } else {
      // Don't change URL if it's a loading screen, 404, or any other state
      return null;
    }
  }
}
