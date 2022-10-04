import 'package:flutter/material.dart';

import '../backend/all_backends.dart';

class TrnsText extends StatelessWidget {
  const TrnsText({
    Key? key,
    required this.title,
    this.style,
    this.textAlign,
    this.extra1 = '',
    this.extra2 = '',
    this.args,
    this.overflow,
    this.maxLines,
  }) : super(key: key);

  final String title;
  final TextStyle? style;
  final TextAlign? textAlign;
  final String extra1;
  final String extra2;
  final Map<String, String>? args;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {

    return Text(
      extra1 + extra2,
      style: style,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
