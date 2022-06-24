import 'package:flutter/material.dart';
import 'package:laith_shono/screens/loading_screen.dart';

class LoadingPage extends Page {
  LoadingPage() : super(key: ValueKey('loading'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => LoadingScreen(key: ValueKey('loading')),
    );
  }
}
