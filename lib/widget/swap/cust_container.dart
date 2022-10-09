import 'package:flutter/material.dart';
import 'package:wuu_crypto_wallet/Utilities/Utilities.dart';

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
            height:height ?? 100,
      width: width ??double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: Utilities.bproGradient),
      ),
    
      child: child,
    );
  }
}
