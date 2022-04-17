import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:laith_shono/models/Project.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectTile extends StatefulWidget {
  final Project project;

  const ProjectTile({Key? key, required this.project}) : super(key: key);
  @override
  _ProjectTileState createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> {
  bool isShowing = false;

  _toggleShow([event]) {
    setState(() {
      if (event is PointerEnterEvent) {
        isShowing = true;
      } else if (event is PointerExitEvent) {
        isShowing = false;
      } else {
        isShowing = !isShowing;
      }
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => _toggleShow(event),
      onExit: (event) => _toggleShow(event),
      child: GestureDetector(
        onTap: () => _toggleShow(),
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: Alignment.center,
              onError: (exception, stackTrace) => AssetImage('assets/no_image.png'),
              image: widget.project.imagePath == null
                  ? AssetImage('assets/no_image.png')
                  : NetworkImage(
                      widget.project.imagePath!,
                    ) as ImageProvider,
            ),
          ),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: isShowing
                ? Container(
                    color: Colors.black.withAlpha(230),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.project.title,
                                  style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  widget.project.description,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Wrap(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          alignment: WrapAlignment.end,
                          children: [
                            if (widget.project.viewURL != null)
                              TextButton(
                                child: Text('VIEW'),
                                onPressed: () => _launchURL(widget.project.viewURL!),
                              ),
                            if (widget.project.codeURL != null)
                              TextButton(
                                child: Text('CODE'),
                                onPressed: () => _launchURL(widget.project.codeURL!),
                              ),
                          ],
                        )
                      ],
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
