import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/models/Project.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectTile extends StatefulWidget {
  final Project project;

  const ProjectTile({Key key, @required this.project}) : super(key: key);
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
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: Alignment.center,
              image: AssetImage(
                widget.project.imagePath == null ? 'assets/no_image.png' : widget.project.imagePath,
              ),
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
                              children: [
                                Text(
                                  widget.project.title,
                                  style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "What the fuck did you just fucking say about me, you little bitch? I'll have you know I graduated top of my class in the Navy Seals, and I've been involved in numerous secret raids on Al-Quaeda, and I have over 300 confirmed kills. I am trained in gorilla warfare and I'm the top sniper in the entire US armed forces. You are nothing to me but just another target. I will wipe you the fuck out with precision the likes of which has never been seen before on this Earth, mark my fucking words. You think you can get away with saying that shit to me over the Internet? Think again, fucker. As we speak I am contacting my secret network of spies across the USA and your IP is being traced right now so you better prepare for the storm, maggot. The storm that wipes out the pathetic little thing you call your life. You're fucking dead, kid. I can be anywhere, anytime, and I can kill you in over seven hundred ways, and that's just with my bare hands. Not only am I extensively trained in unarmed combat, but I have access to the entire arsenal of the United States Marine Corps and I will use it to its full extent to wipe your miserable ass off the face of the continent, you little shit. If only you could have known what unholy retribution your little \"clever\" comment was about to bring down upon you, maybe you would have held your fucking tongue. But you couldn't, you didn't, and now you're paying the price, you goddamn idiot. I will shit fury all over you and you will drown in it. You're fucking dead, kiddo.",
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
                            TextButton(
                              child: Text('VIEW'),
                              onPressed:
                                  widget.project.viewURL == null ? null : () => _launchURL(widget.project.viewURL),
                            ),
                            TextButton(
                              child: Text('CODE'),
                              onPressed:
                                  widget.project.codeURL == null ? null : () => _launchURL(widget.project.codeURL),
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
