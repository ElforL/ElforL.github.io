import 'package:flutter/material.dart';
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
            CircularProgressIndicator(color: Colors.white),
            WebEmojiLoaderHack(),
          ],
        ),
      ),
    );
  }
}
