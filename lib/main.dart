import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laith_shono/router/elfor_parser.dart';
import 'package:laith_shono/router/route_delegate.dart';
import 'package:laith_shono/services/analytics_services.dart';
import 'package:laith_shono/services/firestore.dart';

import 'firebase_options.dart';

final dbServices = FirestoreServices();

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (!kReleaseMode) {
    try {
      await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);

      String host = !kIsWeb && Platform.isAndroid ? '10.0.2.2' : 'localhost';

      await FirebaseAuth.instance.useAuthEmulator(host, 9099);
      FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
    } catch (_) {}
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static _MyAppState? of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ElforRouterDelegate routerDelegate;
  late ElforInformationParser elforParser;
  final AnalyticsServices analyticsServices = AnalyticsServices();

  Locale _currentLocale = Locale('en');

  late void Function() routerListener;

  set currentLocale(Locale locale) {
    if (AppLocalizations.supportedLocales.contains(locale)) {
      if (locale != _currentLocale)
        setState(() {
          _currentLocale = locale;
          routerDelegate.langCode = _currentLocale.languageCode;
        });
    } else {
      debugPrint('Unsupported locale: $locale');
    }
  }

  @override
  void initState() {
    routerDelegate = ElforRouterDelegate(dbServices, analyticsServices);
    elforParser = ElforInformationParser();

    routerListener = () {
      currentLocale = Locale(routerDelegate.langCode ?? 'en');
    };
    routerDelegate.addListener(routerListener);
    super.initState();
  }

  @override
  void dispose() {
    routerDelegate.removeListener(routerListener);
    routerDelegate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme2 = TextTheme(
      headline1: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      headline2: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      headline4: TextStyle(color: Colors.white),
      headline5: TextStyle(color: Colors.white),
      caption: TextStyle(color: Colors.white),
      subtitle1: TextStyle(color: Colors.white),
      button: TextStyle(letterSpacing: 1.25),
    );

    return MaterialApp.router(
      locale: _currentLocale,
      title: 'Laith Shono',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        visualDensity: VisualDensity.standard,
        brightness: Brightness.dark,
        backgroundColor: Color(0xFF181818),
        scaffoldBackgroundColor: Color(0xFF181818),
        textTheme: _currentLocale.languageCode == 'ar' ? GoogleFonts.almaraiTextTheme(textTheme2) : textTheme2,
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
      ),
      routerDelegate: routerDelegate,
      routeInformationParser: elforParser,
    );
  }
}
