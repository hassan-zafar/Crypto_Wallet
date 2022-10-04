import 'package:flutter/material.dart';

class GradientTextWidget extends StatelessWidget {
  const GradientTextWidget(
      {required this.text, this.colors, this.textStyle, Key? key})
      : super(key: key);
  final String text;
  final List<Color>? colors;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect rect) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors ??
            const <Color>[
              Color(0xFF8AD4EC),
              Color(0xFFEF96FF),
              Color(0xFFFF56A9),
              Color(0xFFFFAA6C),
            ],
      ).createShader(rect),
      child: Text(
        text,
        style: textStyle ??
            const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      ),
    );
  }
}
