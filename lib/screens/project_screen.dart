import 'package:flutter/material.dart';
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

class ProjectScreen extends StatelessWidget {
  static const routeName = '/project';

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

            if (project == null) {
              return PageNotFoundScreen();
            }

            final blocksList = project!.screenBlocks;
            List<ProjectBlock> blocks = [];

            for (var blockJson in blocksList) {
              final block = ProjectBlock.fromJson(blockJson);
              blocks.add(block);
            }

            // ListView is more efficient but since the children are of different sizes the scroll
            // bar keeps changing in size as the user scrolls (due to widgets being constantly built/unbuilt)
            return SingleChildScrollView(
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
}
