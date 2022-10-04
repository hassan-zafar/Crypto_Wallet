import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../utilities/app_images.dart';
import '../../widget/custom_widgets/custom_elevated_button.dart';
import '../auth/signin_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);
  static const String routeName = '/IntroScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: IntroductionScreen(
              showDoneButton: false,
              showNextButton: false,
              pages: <PageViewModel>[
                PageViewModel(
                  bodyWidget: _ViewModelBody(
                    imagePath: AppImages.goldenCard,
                    title: 'The most \nTrusted Crypto Wallet?',
                    subtitle:
                        'We help our users to make the right financial decisions',
                  ),
                  titleWidget: const SizedBox(),
                ),
                PageViewModel(
                  bodyWidget: _ViewModelBody(
                    imagePath: AppImages.goldenWallet,
                    title: 'Receive & \nSend Money to Friends',
                    subtitle:
                        'There are 10+ best sequrity service and smart way to eaming money from trading for you.',
                  ),
                  titleWidget: const SizedBox(),
                ),
                PageViewModel(
                  bodyWidget: _ViewModelBody(
                    imagePath: AppImages.lockWallet,
                    titleSpace: 40,
                    title: 'Your safety \nis our top priority',
                    subtitle:
                        'Get rid of your debt monthly debt payments are the biggest obstacle',
                  ),
                  titleWidget: const SizedBox(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: CustomElevatedButton(
              title: 'Next Step',
              onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  SigninScreen.routeName, (Route<dynamic> route) => false),
            ),
          ),
        ],
      ),
    );
  }
}

class _ViewModelBody extends StatelessWidget {
  const _ViewModelBody({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    this.titleSpace = 20,
    // ignore: unused_element
    this.subtitleSpace = 20,
    Key? key,
  }) : super(key: key);
  final String imagePath;
  final String title;
  final String subtitle;
  final double titleSpace;
  final double subtitleSpace;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.5,
          child: Image.asset(imagePath),
        ),
        SizedBox(height: titleSpace),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 38,
          ),
        ),
        SizedBox(height: subtitleSpace),
        Text(
          subtitle,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
