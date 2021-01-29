import 'package:flutter/material.dart';

class PageIndicator extends StatefulWidget {
  PageIndicator({Key key, this.pagesCount = 1}) : super(key: key);
  final pagesCount;

  @override
  PageIndicatorState createState() => PageIndicatorState();
}

class PageIndicatorState extends State<PageIndicator> {
  int page = 0;

  changePage(int newPage) {
    setState(() {
      page = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < widget.pagesCount; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: i == page ? Colors.white : null,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
