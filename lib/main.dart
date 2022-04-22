import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:laith_shono/screens/main_screen.dart';
import 'package:laith_shono/services/firestore.dart';

final dbServices = FirestoreServices();

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laith Shono',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        visualDensity: VisualDensity.standard,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF181818),
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          headline1: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          headline2: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          headline4: TextStyle(color: Colors.white),
          headline5: TextStyle(color: Colors.white),
          caption: TextStyle(color: Colors.white),
          subtitle1: TextStyle(color: Colors.white),
          button: TextStyle(letterSpacing: 1.25),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
      ),
      home: FutureBuilder(
        future: dbServices.load(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            );
          }
          return MainScreen();
        },
      ),
    );
  }
}
