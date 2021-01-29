import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/screens/HomePages/About.dart';
import 'package:portfolio/screens/HomePages/Contact.dart';
import 'package:portfolio/screens/HomePages/Tools.dart';
import 'package:portfolio/widgets/PageIndicator.dart';

class MyHomePage extends StatelessWidget {
  final pageCntrler = PageController();
  final pageKey = GlobalKey();
  var scrollDuration = Duration(milliseconds: 300);
  var scrollCurve = Curves.linear;

  _scroll(pointerSignal) async {
    if (pointerSignal.scrollDelta.dy > 0) {
      await _scrollDown();
    } else if (pointerSignal.scrollDelta.dy < 0) {
      await _scrollUp();
    }
  }

  _scrollDown() async {
    await pageCntrler.nextPage(
      duration: scrollDuration,
      curve: scrollCurve,
    );
    (pageKey.currentState as PageIndicatorState).changePage(pageCntrler.page.toInt());
  }

  _scrollUp() async {
    await pageCntrler.previousPage(
      duration: scrollDuration,
      curve: scrollCurve,
    );
    (pageKey.currentState as PageIndicatorState).changePage(pageCntrler.page.toInt());
  }

  DragStartDetails startVerticalDragDetails;
  DragUpdateDetails updateVerticalDragDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onVerticalDragStart: (dragDetails) {
            startVerticalDragDetails = dragDetails;
          },
          onVerticalDragUpdate: (dragDetails) {
            updateVerticalDragDetails = dragDetails;
          },
          onVerticalDragEnd: (endDetails) {
            double dx = updateVerticalDragDetails.globalPosition.dx - startVerticalDragDetails.globalPosition.dx;
            double dy = updateVerticalDragDetails.globalPosition.dy - startVerticalDragDetails.globalPosition.dy;
            double velocity = endDetails.primaryVelocity;

            //Convert values to be positive
            if (dx < 0) dx = -dx;
            if (dy < 0) dy = -dy;

            if (velocity < 0) {
              _scrollDown();
            } else {
              _scrollUp();
            }
          },
          child: Listener(
            onPointerSignal: (pointerSignal) {
              if (pointerSignal is PointerScrollEvent) {
                _scroll(pointerSignal);
              }
            },
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: PageIndicator(key: pageKey, pagesCount: 3),
                ),
                PageView(
                  controller: pageCntrler,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    About(),
                    Tools(),
                    ContactPage(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
