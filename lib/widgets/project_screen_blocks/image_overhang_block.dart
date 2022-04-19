import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:laith_shono/models/project_block.dart';
import 'package:laith_shono/services/misc.dart';

class ImageOverhandBlockWidget extends StatelessWidget {
  const ImageOverhandBlockWidget({Key? key, required this.block}) : super(key: key);

  final ImageOverhangProjectBlock block;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final image = Image.network(
      block.imageUrl,
    );

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
    final textColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headline,
        SizedBox(height: 20),
        text,
      ],
    );

    // When the screen width is smaller than 850
    // make the headline above the text instead
    Widget child;
    child = Row(
      children: [
        Expanded(
          flex: 2,
          child: textColumn,
        ),
        if (screenWidth >= 850) ...[
          Spacer(),
          Expanded(
            child: Transform.scale(
              alignment: AlignmentDirectional.bottomStart,
              scale: 1 + (block.imageOverhandPercentage / 100),
              child: image,
            ),
          ),
        ],
      ],
    );

    return Container(
      alignment: Alignment.center,
      color: Colors.white24,
      padding: EdgeInsets.symmetric(
        horizontal: adaptivePadding(screenWidth),
        vertical: screenWidth >= 850 ? 0 : 50,
      ),
      child: child,
    );
  }
}
