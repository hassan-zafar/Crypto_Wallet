import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    required this.imageURL,
    this.fit = BoxFit.cover,
    this.timeLimit = const Duration(days: 2),
    Key? key,
  }) : super(key: key);
  final String imageURL;
  final BoxFit? fit;
  final Duration? timeLimit;

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      imageURL,
      fit: fit,
      timeLimit: timeLimit,
      handleLoadingProgress: true,
      cacheMaxAge: timeLimit,
      cache: true,
    );
  }
}
