import 'package:flutter/material.dart';

/// A workaround for issue [flutter#76248][#76248] by user [rodion-m][rodion-m]
///
/// Put this widget in any place on program startup (inside Column or Row for example)
/// and Flutter will load emojis. Don't worry, Offstaged widgets are invisible.
///
/// rodion-m's comment:
/// https://github.com/flutter/flutter/issues/78422#issuecomment-893012325
///
/// [rodion-m]: https://github.com/rodion-m
/// [#76248]: https://github.com/flutter/flutter/issues/76248
class WebEmojiLoaderHack extends StatelessWidget {
  const WebEmojiLoaderHack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Offstage(
      // Insert invisible emoji in order to load the emoji font in CanvasKit
      // on startup.
      child: Text('✨'),
    );
  }
}
