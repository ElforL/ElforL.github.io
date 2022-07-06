import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laith_shono/models/project_block.dart';
import 'package:laith_shono/services/misc.dart';

class HeadBlockWidget extends StatelessWidget {
  const HeadBlockWidget({
    Key? key,
    required this.block,
  }) : super(key: key);

  final HeadProjectBlock block;

  final _breakpoint = 850;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttons = block.buttons(AppLocalizations.of(context)!.localeName);
    final badges = block.storeBadges;

    final yearColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalizations.of(context)!.year,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 7),
        Text(block.year.toString()),
      ],
    );

    var deliverables = block.deliverables(AppLocalizations.of(context)!.localeName);

    final deliverablesColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalizations.of(context)!.deliverables,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 7),
        for (var item in deliverables) Text(item),
      ],
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: adaptivePadding(screenWidth), vertical: 160),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            block.title(AppLocalizations.of(context)!.localeName),
            style: screenWidth > 850 ? Theme.of(context).textTheme.headline1 : Theme.of(context).textTheme.headline2,
          ),
          SizedBox(height: 15),
          Text(
            block.smallDescribtion(AppLocalizations.of(context)!.localeName),
            style: screenWidth > 850 ? Theme.of(context).textTheme.headline3 : Theme.of(context).textTheme.headline4,
          ),
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  block.longDescribtion(AppLocalizations.of(context)!.localeName),
                ),
              ),
              SizedBox(width: 30),
              if (screenWidth > _breakpoint) ...[
                Expanded(
                  child: deliverablesColumn,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: yearColumn,
                ),
              ],
            ],
          ),
          if (screenWidth <= _breakpoint) ...[
            SizedBox(height: 20),
            deliverablesColumn,
            SizedBox(height: 20),
            yearColumn,
          ],
          SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              for (var button in buttons)
                OutlinedButton(
                  child: Text(button['text'].toString()),
                  onPressed: () => launchURL(button['url'].toString()),
                ),
            ],
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (var badge in badges) _buildBadge(context, badge),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(BuildContext context, Map<String, String> badge) {
    if (badge['type'] == 'apple') {
      return InkWell(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: badge['url'] == null ? null : () => launchURL(badge['url']!),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            'assets/store_badges/app-store(${AppLocalizations.of(context)!.localeName}).svg',
            height: 55,
          ),
        ),
      );
    } else if (badge['type'] == 'g_play') {
      return InkWell(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: badge['url'] == null ? null : () => launchURL(badge['url']!),
        child: Image.asset(
          'assets/store_badges/google-play(${AppLocalizations.of(context)!.localeName}).png',
          height: 80,
        ),
      );
    } else {
      throw ArgumentError('Invalid type: ${badge['type']}');
    }
  }
}
