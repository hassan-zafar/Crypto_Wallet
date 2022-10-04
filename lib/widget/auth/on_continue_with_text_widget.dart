import 'package:flutter/material.dart';

class OrContinueWithTextWidget extends StatelessWidget {
  const OrContinueWithTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            width: double.infinity,
            height: 0.5,
            color: Colors.grey.shade300,
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          ' Or continue with ',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            width: double.infinity,
            height: 0.5,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}
