import 'package:flutter/material.dart';
import 'package:laith_shono/models/project_block.dart';

class FullWidthImageBlockWidget extends StatelessWidget {
  const FullWidthImageBlockWidget({
    Key? key,
    required this.block,
  }) : super(key: key);

  final FullWidthImageProjectBlock block;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      block.url,
      height: block.height,
      fit: BoxFit.cover,
    );
  }
}
