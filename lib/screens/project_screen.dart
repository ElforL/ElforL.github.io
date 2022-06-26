import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:laith_shono/main.dart';
import 'package:laith_shono/models/Project.dart';
import 'package:laith_shono/models/project_block.dart';
import 'package:laith_shono/screens/404.dart';
import 'package:laith_shono/widgets/project_screen_blocks/banner_block.dart';
import 'package:laith_shono/widgets/project_screen_blocks/full_width_image_block.dart';
import 'package:laith_shono/widgets/project_screen_blocks/head_block.dart';
import 'package:laith_shono/widgets/project_screen_blocks/headline_block.dart';
import 'package:laith_shono/widgets/project_screen_blocks/image_overhang_block.dart';
import 'package:laith_shono/widgets/project_screen_blocks/image_with_padding_block.dart';
import 'package:laith_shono/widgets/socials_wrap.dart';

// ignore: must_be_immutable
class ProjectScreen extends StatelessWidget {
  static const routeName = 'project';

  ProjectScreen({
    Key? key,
    this.project,
    String? projectTitle,
  })  : projectName = projectTitle ?? (project?.title ?? ''),
        super(key: key);

  Project? project;
  final String? projectName;

  @override
  Widget build(BuildContext context) {
    assert(project != null || projectName != null);

    Future<Project?> future;
    if (project == null) {
      future = dbServices.getProject(projectName!);
    } else {
      future = Future.value(project);
    }

    return Scaffold(
      body: FutureBuilder(
          future: future,
          builder: (context, AsyncSnapshot<Project?> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            }

            project = snapshot.data;

            final blocksList = project!.screenBlocks;
            List<ProjectBlock> blocks = [];

            for (var blockJson in blocksList) {
              final block = ProjectBlock.fromJson(blockJson);
              blocks.add(block);
            }

            // ListView is more efficient but since the children are of different sizes the scroll
            // bar keeps changing in size as the user scrolls (due to widgets being constantly built/unbuilt)
            return Stack(
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var block in blocks) _buildBlockWidget(context, block),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        alignment: AlignmentDirectional.topEnd,
                        child: SizedBox(
                          height: 30,
                          child: FittedBox(
                            child: SocialsWrap(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                _buildTopBar(context),
              ],
            );
          }),
    );
  }

  Widget _buildBlockWidget(BuildContext context, ProjectBlock block) {
    switch (block.type) {
      case ProjectBlockType.head:
        return HeadBlockWidget(block: block as HeadProjectBlock);

      case ProjectBlockType.fullWidthImage:
        return FullWidthImageBlockWidget(block: block as FullWidthImageProjectBlock);

      case ProjectBlockType.banner:
        return BannerBlockWidget(block: block as BannerProjectBlock);

      case ProjectBlockType.imageWithPadding:
        return ImageWithPaddingBlockWidget(block: block as ImageWithPaddingProjectBlock);

      case ProjectBlockType.headline:
        return HeadlineBlockWidget(block: block as HeadlineProjectBlock);

      case ProjectBlockType.imageOverhang:
        return ImageOverhandBlockWidget(block: block as ImageOverhangProjectBlock);
    }
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.background,
            Theme.of(context).colorScheme.background.withAlpha(178),
            Theme.of(context).colorScheme.background.withAlpha(0),
          ],
          stops: [
            0,
            0.5,
            1,
          ],
          begin: AlignmentDirectional.topCenter,
          end: AlignmentDirectional.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          FittedBox(
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Text(
                'Laith Shono',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
          Spacer(),
          InkWell(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: Icon(Icons.arrow_right_alt),
                  ),
                  SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context)!.back_home,
                    style: Theme.of(context).textTheme.button,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
