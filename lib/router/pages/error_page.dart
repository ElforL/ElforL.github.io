import 'package:flutter/material.dart';
import 'package:laith_shono/screens/under_maintenance_screen.dart';

class ErrorPage extends Page {
  ErrorPage() : super(key: ValueKey('error'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => UnderMaintenanceScreen(key: ValueKey('loading')),
    );
  }
}
