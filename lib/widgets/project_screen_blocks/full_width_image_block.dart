import 'package:cached_network_image/cached_network_image.dart';
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
    return CachedNetworkImage(
      imageUrl: block.url,
      height: block.height,
      fit: BoxFit.cover,
    );
  }
}
