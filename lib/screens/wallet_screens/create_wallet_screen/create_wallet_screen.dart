import 'package:flutter/material.dart';

import '../../../widget/create_wallet/confirm_seed_step.dart';
import '../../../widget/create_wallet/create_password_step.dart';
import '../../../widget/create_wallet/secure_wallet_step.dart';

class CreateWalletScreen extends StatefulWidget {
  const CreateWalletScreen({Key? key}) : super(key: key);
  static const String routeName = '/CreateWalletScreen';
  @override
  State<CreateWalletScreen> createState() => _CreateWalletScreenState();
}

class _CreateWalletScreenState extends State<CreateWalletScreen> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.circle,
                size: 10,
                color: currentStep >= 0
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              Container(
                width: 70,
                height: 1,
                color: currentStep >= 1
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              Icon(
                Icons.circle,
                size: 10,
                color: currentStep >= 1
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              Container(
                width: 70,
                height: 1,
                color: currentStep >= 2
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              Icon(
                Icons.circle,
                size: 10,
                color: currentStep >= 2
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
            ],
          ),
          actions: const <Widget>[SizedBox(width: 40)],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: currentStep == 0
              ? CreatePasswordStep(
                  onTap: () {
                    setState(() {
                      currentStep = 1;
                    });
                  },
                )
              : currentStep == 1
                  ? SecureWalletStep(
                      onTap: () {
                        setState(() {
                          currentStep = 2;
                        });
                      },
                    )
                  : const ConfirmSeedStep(),
        ),
      ),
    );
  }
}
