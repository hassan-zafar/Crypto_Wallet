import 'package:flutter/material.dart';

import '../../helpers/colors.dart';
import '../trns_text.dart';

class CustButton extends StatelessWidget {
  const CustButton({
    Key? key,
    required this.onTap,
    required this.title,
    this.width,
    this.color,
    this.textColor,
    this.isHollow = false,
    this.args,
  }) : super(key: key);
  final void Function()? onTap;
  final String? title;
  final double? width;
  final Color? color;
  final Color? textColor;
  final bool isHollow;
  final Map<String, String>? args;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: color != null
              ? color
              : isHollow
                  ? transparent
                  : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: isHollow
                ? Theme.of(context).colorScheme.secondary
                : transparent,
          ),
        ),
        child: Center(
          child: TrnsText(
              title: title!,
              args: args,
              style: TextStyle(
                  fontSize: 18,
                  color: textColor ?? (isHollow
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).textTheme.bodyText1!.color))),
        ),
      ),
    );
  }
}
