import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:laith_shono/models/project_block.dart';

class HeadlineBlockWidget extends StatelessWidget {
  const HeadlineBlockWidget({Key? key, required this.block}) : super(key: key);

  final HeadlineProjectBlock block;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 100),
      alignment: AlignmentDirectional.center,
      child: FittedBox(
        child: Text(
          block.text(AppLocalizations.of(context)!.localeName),
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}
