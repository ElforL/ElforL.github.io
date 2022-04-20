import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:laith_shono/models/project_block.dart';
import 'package:laith_shono/services/misc.dart';

class ImageWithPaddingBlockWidget extends StatelessWidget {
  const ImageWithPaddingBlockWidget({Key? key, required this.block}) : super(key: key);

  final ImageWithPaddingProjectBlock block;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 100, horizontal: adaptivePadding(screenWidth)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: block.url,
        ),
      ),
    );
  }
}
