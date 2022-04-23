import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:laith_shono/models/project_block.dart';

class HeadlineBlockWidget extends StatelessWidget {
  const HeadlineBlockWidget({Key? key, required this.block}) : super(key: key);

  final HeadlineProjectBlock block;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 100),
      alignment: AlignmentDirectional.center,
      child: FittedBox(
        child: Text(
          block.text(AppLocalizations.of(context)!.localeName),
          style: screenWidth > 850 ? Theme.of(context).textTheme.headline2 : Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }
}
