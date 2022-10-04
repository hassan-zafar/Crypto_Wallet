import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/seed_phrase_provider.dart';
import '../../utilities/app_images.dart';
import '../../utilities/utilities.dart';
import '../custom_widgets/custom_elevated_button.dart';
import '../custom_widgets/gradient_text_widget.dart';
import 'seed_text_widget.dart';

class SecureWalletStep extends StatefulWidget {
  const SecureWalletStep({required this.onTap, Key? key}) : super(key: key);
  final VoidCallback onTap;

  @override
  State<SecureWalletStep> createState() => _SecureWalletStepState();
}

class _SecureWalletStepState extends State<SecureWalletStep> {
  int _page = 0;
  @override
  Widget build(BuildContext context) {
    return _page == 0
        ? _StartPage(
            remindMeOnTap: () {},
            startOnTap: () {
              setState(() {
                _page = 1;
              });
            },
          )
        : _page == 1
            ? _ManualPage(
                onStartTap: () {
                  setState(() {
                    _page = 2;
                  });
                },
              )
            : _SeedPhrasePage(onNextTap: widget.onTap);
  }
}

class _SeedPhrasePage extends StatefulWidget {
  const _SeedPhrasePage({required this.onNextTap, Key? key}) : super(key: key);
  final VoidCallback onNextTap;

  @override
  State<_SeedPhrasePage> createState() => _SeedPhrasePageState();
}

class _SeedPhrasePageState extends State<_SeedPhrasePage> {
  bool hidden = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GradientTextWidget(
          text: 'Write Down Your Seed Phrase',
          colors: Utilities.bgGradient,
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 20),
        const Text(
          '''This is your seed phrase. Write it down on a paper and keep it in a safe place. You'll be asked to re-enter this phrase (in order) on the next step.''',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 40),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white10,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Consumer<SeedPhraseProvider>(builder:
                  (BuildContext context, SeedPhraseProvider seedPro, _) {
                final List<String> phrases = seedPro.phraselist;
                print(phrases);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SeedTextWidget(text: phrases[0], index: 0),
                        SeedTextWidget(text: phrases[1], index: 1),
                        SeedTextWidget(text: phrases[2], index: 2),
                        SeedTextWidget(text: phrases[3], index: 3),
                        SeedTextWidget(text: phrases[4], index: 4),
                        SeedTextWidget(text: phrases[5], index: 5),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SeedTextWidget(text: phrases[6], index: 6),
                        SeedTextWidget(text: phrases[7], index: 7),
                        SeedTextWidget(text: phrases[8], index: 8),
                        SeedTextWidget(text: phrases[9], index: 9),
                        SeedTextWidget(text: phrases[10], index: 10),
                        SeedTextWidget(text: phrases[11], index: 11),
                      ],
                    ),
                  ],
                );
              }),
              if (hidden) _glass(context),
            ],
          ),
        ),
        const Spacer(),
        CustomElevatedButton(
          title: 'Next',
          readOnly: hidden,
          onTap: widget.onNextTap,
        ),
      ],
    );
  }

  Widget _glass(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Tap to reveal your seed phrase',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Make sure no one is watching your screen.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                setState(() {
                  hidden = false;
                });
              },
              child: Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.remove_red_eye_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'View',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ManualPage extends StatelessWidget {
  const _ManualPage({required this.onStartTap, Key? key}) : super(key: key);
  final VoidCallback onStartTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(width: 60),
            GradientTextWidget(
              text: 'Secure Your Wallet',
              colors: Utilities.bgGradient,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            IconButton(
              onPressed: () {
                //TODO: Info Icon Button on Tap
              },
              splashRadius: 16,
              icon: const Icon(Icons.info_outline),
            ),
          ],
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.grey),
            text: '''Secure your wallet's "''',
            children: <TextSpan>[
              TextSpan(
                text: 'Seed Phrase',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // TODO: Seed Phrase on Tap
                  },
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: '"'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Manual',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          'Write down your seed phrase on a piece of paper and store in a safe place.',
        ),
        const SizedBox(height: 20),
        const Text('Security lever: Very strong'),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Container(height: 2, width: 50, color: Colors.green[600]),
            const SizedBox(width: 10),
            Container(height: 2, width: 50, color: Colors.green[600]),
            const SizedBox(width: 10),
            Container(height: 2, width: 50, color: Colors.green[600]),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          '''Risks are: \n• You lose it \n• You forget where you put it \n• Someone else finds it''',
        ),
        const SizedBox(height: 20),
        const Text('''Other options: Doesn't have to be paper!'''),
        const SizedBox(height: 20),
        const Text(
          '''Tips:\n• Store in bank vault \n• Store in a safe \n• Store in multiple secret places''',
        ),
        const Spacer(),
        CustomElevatedButton(title: 'Start', onTap: onStartTap),
      ],
    );
  }
}

class _StartPage extends StatelessWidget {
  const _StartPage(
      {required this.remindMeOnTap, required this.startOnTap, Key? key})
      : super(key: key);
  final VoidCallback remindMeOnTap;
  final VoidCallback startOnTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Image.asset(AppImages.security),
        ),
        const SizedBox(height: 40),
        const Text(
          'Secure Your Wallet',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.grey),
            children: <TextSpan>[
              const TextSpan(
                text:
                    '''Don't risk losing your funds. protect your wallet by saving your ''',
              ),
              TextSpan(
                  text: 'Seed phrase ',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // TODO: Seed Phrase on tap
                    }),
              const TextSpan(text: '''in a place you trust.'''),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          '''It's the only way to recover your wallet if you get locked out of the app or get a new device.''',
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: remindMeOnTap,
          child: const Text(
            'Remind Me Later',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        CustomElevatedButton(
          title: 'Start',
          onTap: startOnTap,
        ),
      ],
    );
  }
}
