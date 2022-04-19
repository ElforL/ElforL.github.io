import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:laith_shono/models/project_block.dart';
import 'package:laith_shono/services/misc.dart';

class BannerBlockWidget extends StatelessWidget {
  const BannerBlockWidget({
    Key? key,
    required this.block,
  }) : super(key: key);

  final BannerProjectBlock block;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final text = Text(
      block.text(AppLocalizations.of(context)!.localeName),
    );
    final headline = Text(
      block.headline(AppLocalizations.of(context)!.localeName),
      style: Theme.of(context).textTheme.headline4?.copyWith(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
    );

    // When the screen width is smaller than 850
    // make the headline above the text instead
    Widget child;
    if (screenWidth >= 850) {
      child = Row(
        children: [
          Flexible(child: headline),
          SizedBox(width: 80),
          Expanded(
            child: text,
          ),
        ],
      );
    } else {
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headline,
          SizedBox(height: 20),
          text,
        ],
      );
    }

    return Container(
      alignment: Alignment.center,
      color: Colors.white24,
      padding: EdgeInsets.symmetric(
        horizontal: adaptivePadding(screenWidth),
        vertical: screenWidth >= 850 ? 80 : 50,
      ),
      child: child,
    );
  }
}
