import 'package:flutter/material.dart';

class ComingSoom extends StatelessWidget {
  const ComingSoom({Key? key}) : super(key: key);
  static const String routeName = '/coming-soon';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FittedBox(child: Text('Coming Soon...')),
      ),
    );
  }
}
