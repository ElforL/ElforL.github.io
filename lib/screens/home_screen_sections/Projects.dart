import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:laith_shono/main.dart';
import 'package:laith_shono/models/Project.dart';
import 'package:laith_shono/services/misc.dart';
import 'package:laith_shono/widgets/ProjectTile.dart';

class Projects extends StatelessWidget {
  final List<Project>? projects;

  const Projects({Key? key, required this.projects}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      constraints: BoxConstraints(
        minHeight: height,
        minWidth: width,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Text(
              AppLocalizations.of(context)!.selected_projects,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Container(
            alignment: width > 510 ? null : Alignment.center,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (var project in projects!)
                  FittedBox(
                    child: ProjectTile(
                      project: project,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            alignment: width > 510 ? null : AlignmentDirectional.center,
            child: TextButton.icon(
              label: Text(AppLocalizations.of(context)!.more_on_gh),
              icon: Icon(Icons.arrow_right_rounded),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.grey),
              ),
              onPressed: () {
                launchURL(dbServices.gitHubURL!);
              },
            ),
          )
        ],
      ),
    );
  }
}
