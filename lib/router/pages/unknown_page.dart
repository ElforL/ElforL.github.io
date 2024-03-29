import 'package:flutter/material.dart';
import 'package:laith_shono/screens/404.dart';

class UnknownPage extends Page {
  UnknownPage(this.toHomePage) : super(key: ValueKey('404'));

  /// Function to trigger when the 'Go Home' button is pressed in the 404 screen
  final void Function() toHomePage;

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => PageNotFoundScreen(
        key: ValueKey('404'),
        toHomePage: toHomePage,
      ),
    );
  }
}
