import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:laith_shono/router/elfor_configuration.dart';
import 'package:laith_shono/screens/project_screen.dart';

class ElforInformationParser extends RouteInformationParser<ElforConfiguration> {
  @override
  Future<ElforConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');
    final segments = uri.pathSegments.toList();
    String? langCode;

    if (segments.isNotEmpty &&
        AppLocalizations.supportedLocales.any((locale) => locale.languageCode == segments.first)) {
      langCode = segments.first;
      segments.removeAt(0);
    }

    if (segments.isEmpty) {
      return ElforConfiguration.home(langCode);
    } else if (segments.first == ProjectScreen.routeName && segments.length >= 2) {
      return ElforConfiguration.project(segments[1], langCode);
    } else {
      return ElforConfiguration.unknown(langCode);
    }
  }

  @override
  RouteInformation? restoreRouteInformation(ElforConfiguration configuration) {
    final langCodeSegment =
        configuration.langCode == null || configuration.langCode == 'en' ? '' : '/${configuration.langCode}';
    if (configuration.isHome) {
      return RouteInformation(location: '$langCodeSegment/');
    } else if (configuration.isProjectPage) {
      return RouteInformation(location: '$langCodeSegment/project/${configuration.selectedProjectTitle}');
    } else {
      // Don't change URL if it's a loading screen, 404, or any other state
      return null;
    }
  }
}
