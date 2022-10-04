import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../providers/seed_phrase_provider.dart';
import '../wallet_screens/wallet_setup_screen/wallet_setup_screen.dart';
import 'welcome_screen.dart';

class VerificationPinScreen extends StatefulWidget {
  const VerificationPinScreen({Key? key}) : super(key: key);
  static const String routeName = '/VarificationPicScreen';
  @override
  State<VerificationPinScreen> createState() => _VerificationPinScreenState();
}

class _VerificationPinScreenState extends State<VerificationPinScreen> {
  final TextEditingController _pin = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Text(
                  'Verification code',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'We have sent the code verification to your mobile number',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 48),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 4,
                    controller: _pin,
                    cursorColor: Theme.of(context).primaryColor,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(16),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      errorBorderColor: Colors.red,
                      activeColor: Colors.grey,
                      inactiveColor: Colors.grey,
                    ),
                    onChanged: (String value) async {
                      if (value.length == 4) {
                        // Navigator.of(context).pushNamedAndRemoveUntil(
                        //     WelcomeScreen.routeName,
                        //     (Route<dynamic> route) => false);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            WalletSetupScreen.routeName,
                            (Route<dynamic> route) => false);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  child: const Text('Resend Code'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
