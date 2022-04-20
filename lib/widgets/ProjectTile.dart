import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:laith_shono/models/Project.dart';

class ProjectTile extends StatefulWidget {
  final Project project;

  const ProjectTile({Key? key, required this.project}) : super(key: key);
  @override
  _ProjectTileState createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> with TickerProviderStateMixin {
  bool isShowing = false;
  late final AnimationController _animationController;
  final animationDuration = Duration(milliseconds: 200);

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: animationDuration,
    );
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tileHeight = 200.0;
    final tileWidth = 200.0;
    final borderRadius = BorderRadius.circular(5);
    final errImage = Image.asset('assets/no_image.png');

    return MouseRegion(
      onEnter: (event) => _toggleShow(event),
      onExit: (event) => _toggleShow(event),
      child: SizedBox(
        height: tileHeight,
        width: tileWidth,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: isShowing ? () {} : null,
            child: Stack(
              children: [
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, snapshot) {
                    return Transform.scale(
                      scale: 1 + .12 * _animationController.value,
                      child: SizedBox(
                        width: tileHeight,
                        height: tileWidth,
                        child: widget.project.imagePath == null
                            ? errImage
                            : CachedNetworkImage(
                                imageUrl: widget.project.imagePath!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    );
                  },
                ),
                AnimatedSwitcher(
                  duration: animationDuration,
                  child: Container(
                    color: isShowing ? Colors.white.withAlpha(30) : null,
                    child: isShowing
                        ? Center(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                AppLocalizations.of(context)!.view_project.toUpperCase(),
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _toggleShow([event]) {
    setState(() {
      if (event is PointerEnterEvent) {
        isShowing = true;
        _animationController.forward();
      } else if (event is PointerExitEvent) {
        isShowing = false;
        _animationController.reverse(from: 1);
      } else {
        isShowing = !isShowing;
        if (isShowing)
          _animationController.forward();
        else
          _animationController.reverse(from: 1);
      }
    });
  }
}
