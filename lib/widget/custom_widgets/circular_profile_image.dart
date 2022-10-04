import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CircularProfileImage extends StatelessWidget {
  const CircularProfileImage({
    required this.imageURL,
    this.radius = 24,
    Key? key,
  }) : super(key: key);
  final double radius;
  final String? imageURL;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: imageURL == null || (imageURL?.isEmpty ?? false)
          ? CircleAvatar(
              radius: radius - 2,
              backgroundColor: Theme.of(context).primaryColor,
              child: CircleAvatar(
                radius: radius - 4,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: Icon(Icons.person, size: radius),
              ),
            )
          : ExtendedImage.network(
              imageURL!,
              fit: BoxFit.cover,
            ),
    );
  }
}
