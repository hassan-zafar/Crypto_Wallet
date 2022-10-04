import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helpers/colors.dart';

class CustProgIndicator extends StatelessWidget {
  const CustProgIndicator({
    Key? key,
    this.radius,
  }) : super(key: key);

  final radius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS
          ? const CupertinoActivityIndicator()
          : const CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation<Color>(accentColor)),
    );
  }
}
