import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:laith_shono/models/Project.dart';
import 'package:laith_shono/screens/404.dart';
import 'package:laith_shono/screens/home_screen.dart';
import 'package:laith_shono/screens/project_screen.dart';
import 'package:laith_shono/services/firestore.dart';
import 'package:laith_shono/widgets/web_emoji_loader.dart';

final dbServices = FirestoreServices();

void main() {
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
        backgroundColor: Color(0xFF181818),
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
      initialRoute: '/',
      routes: {
        '/': (context) => FirstScreenWrapper(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(builder: (context) => const PageNotFoundScreen()),
      onGenerateRoute: (settings) {
        if (settings.name == null) return null;
        final uri = Uri.parse(settings.name!);
        if (uri.pathSegments.isEmpty) return null;
        final firstSegments = '/${uri.pathSegments[0]}';

        if (firstSegments == ProjectScreen.routeName) {
          Project? project; // = routeSettings.arguments as Project;
          String? projectTitle;

          if (settings.arguments is Project) {
            // If there's argument. usually when pressed by a button.
            project = settings.arguments as Project;
            projectTitle = project.title;
          } else if (uri.pathSegments.length >= 2) {
            // no argument but there's a uri project title
            projectTitle = uri.pathSegments[1];
            try {
              project = dbServices.projects.firstWhere((element) => element.title == projectTitle);
            } catch (_) {}
          }

          if (projectTitle != null) {
            return MaterialPageRoute(
              builder: (context) {
                return ProjectScreen(
                  project: project,
                  projectTitle: projectTitle,
                );
              },
              // Add the project title to the url
              settings: settings.copyWith(name: ProjectScreen.routeName + '/$projectTitle'),
            );
          }
        }

        return MaterialPageRoute(builder: (context) => const PageNotFoundScreen());
      },
    );
  }
}

class FirstScreenWrapper extends StatelessWidget {
  const FirstScreenWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dbServices.load(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.white),
                  WebEmojiLoaderHack(),
                ],
              ),
            ),
          );
        }
        return HomeScreen();
      },
    );
  }
}
