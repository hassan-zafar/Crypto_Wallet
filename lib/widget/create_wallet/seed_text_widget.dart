import 'package:flutter/material.dart';

class SeedTextWidget extends StatelessWidget {
  const SeedTextWidget({required this.text, required this.index, Key? key})
      : super(key: key);
  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 120,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text('$index. $text'),
    );
  }
}
