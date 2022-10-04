import 'package:flutter/material.dart';

class CustContainer extends StatelessWidget {
  const CustContainer({
    Key? key,
    required this.child,
    this.height,
    this.width,
  }) : super(key: key);

  final double? height;
  final double? width;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 100,
      width: width ?? double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
      ),
      child: child,
    );
  }
}
