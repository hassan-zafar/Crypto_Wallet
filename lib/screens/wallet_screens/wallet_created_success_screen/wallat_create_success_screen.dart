import 'package:flutter/material.dart';

import '../../../Utilities/app_images.dart';
import '../../../Utilities/Utilities.dart';
import '../../../widget/custom_widgets/custom_elevated_button.dart';
import '../../../widget/custom_widgets/gradient_text_widget.dart';
import '../../intro_screen/intro_screen.dart';
import '../../main_screen/main_screen.dart';

class WallatCreateSuccessScreen extends StatelessWidget {
  const WallatCreateSuccessScreen({Key? key}) : super(key: key);
  static const String routeName = '/WallatCreateSuccessScreen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 24),
                child: Image.asset(AppImages.success),
              ),
              GradientTextWidget(
                text: 'Success!',
                colors: Utilities.bgGradient,
              ),
              const SizedBox(height: 40),
              const Text(
                '''You've successfully protected your wallet. Remember to keep your seed phrase safe, it's your responsibility!''',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                '''DefiSquid cannot recover your wallet should you lose it. You can find your seed phrase in Settings > Security & Privacy.''',
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              CustomElevatedButton(
                title: 'Next',
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      MainScreen.routeName, (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
