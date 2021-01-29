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

  _scroll(dy) async {
    if (dy > 0) {
      await _scrollDown();
    } else if (dy < 0) {
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

  // used to calculate the delta y to detect vertical swipes
  DragStartDetails startVerticalDragDetails;
  DragUpdateDetails updateVerticalDragDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          // set the start point
          onVerticalDragStart: (dragDetails) {
            startVerticalDragDetails = dragDetails;
          },
          // set the end point
          onVerticalDragUpdate: (dragDetails) {
            updateVerticalDragDetails = dragDetails;
          },
          // calculate and scroll
          onVerticalDragEnd: (endDetails) {
            if (startVerticalDragDetails == null || updateVerticalDragDetails == null) return;
            double dy = updateVerticalDragDetails.globalPosition.dy - startVerticalDragDetails.globalPosition.dy;
            _scroll(-dy);
            startVerticalDragDetails = null;
            updateVerticalDragDetails = null;
          },
          // build child
          child: Listener(
            // read mouse scrolls
            onPointerSignal: (pointerSignal) {
              if (pointerSignal is PointerScrollEvent) {
                _scroll(pointerSignal.scrollDelta.dy);
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
