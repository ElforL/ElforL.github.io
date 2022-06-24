import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:laith_shono/widgets/web_emoji_loader.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              key: ValueKey('Name'),
              tag: 'Name',
              child: Text(
                AppLocalizations.of(context)!.first_name,
                style: Theme.of(context).textTheme.headline1!.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            SizedBox(height: 50),
            Container(
              constraints: BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: LinearProgressIndicator(color: Colors.white),
            ),
            WebEmojiLoaderHack(),
          ],
        ),
      ),
    );
  }
}
