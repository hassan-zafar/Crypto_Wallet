import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../apis/wallet_api.dart';
import '../../providers/seed_phrase_provider.dart';
import '../../screens/auth/welcome_screen.dart';
import '../../screens/main_screen/main_screen.dart';
import '../../screens/wallet_screens/wallet_created_success_screen/wallat_create_success_screen.dart';
import '../../screens/wallet_screens/wallet_setup_screen/wallet_setup_screen.dart';
import '../../utilities/utilities.dart';
import '../custom_widgets/custom_elevated_button.dart';
import '../custom_widgets/custom_toast.dart';
import '../custom_widgets/gradient_text_widget.dart';

class ConfirmSeedStep extends StatefulWidget {
  const ConfirmSeedStep({Key? key}) : super(key: key);
  @override
  State<ConfirmSeedStep> createState() => _ConfirmSeedStepState();
}

class _ConfirmSeedStepState extends State<ConfirmSeedStep> {
  String _first = '';
  String _second = '';
  String _third = '';
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<SeedPhraseProvider>(
        builder: (BuildContext context, SeedPhraseProvider seedPro, _) {
      return Column(
        children: <Widget>[
          const SizedBox(height: 20),
          GradientTextWidget(
            text: 'Confirm Seed Phrase',
            colors: Utilities.bgGradient,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Select each word in the order it was presented to you',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          count == 0
              ? GradientTextWidget(
                  text: _first.isEmpty
                      ? seedPro.firstIndex.toString()
                      : '${seedPro.firstIndex}. $_first',
                  colors: (_first.isEmpty)
                      ? <Color>[Colors.blueGrey, Colors.blueGrey]
                      : Utilities.bgGradient,
                )
              : count == 1
                  ? GradientTextWidget(
                      text: _second.isEmpty
                          ? seedPro.secondIndex.toString()
                          : '${seedPro.secondIndex}. $_second',
                      colors: (_second.isEmpty)
                          ? <Color>[Colors.blueGrey, Colors.blueGrey]
                          : Utilities.bgGradient,
                    )
                  : GradientTextWidget(
                      text: _third.isEmpty
                          ? seedPro.thirdIndex.toString()
                          : '${seedPro.thirdIndex}. $_third',
                      colors: (_third.isEmpty)
                          ? <Color>[Colors.blueGrey, Colors.blueGrey]
                          : Utilities.bgGradient,
                    ),
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 2,
                width: 50,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 10),
              Container(
                height: 2,
                width: 50,
                color: (_second.length < 4)
                    ? Colors.white12
                    : Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 10),
              Container(
                height: 2,
                width: 50,
                color: (_third.length < 4)
                    ? Colors.white12
                    : Theme.of(context).primaryColor,
              ),
            ],
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 10,
              runSpacing: 6,
              clipBehavior: Clip.hardEdge,
              children: count == 0
                  ? seedPro
                      .hintForFirstPhrase()
                      .map((String e) => HintSeed(
                            seed: e,
                            onTap: () {
                              setState(() {
                                _first = e;
                              });
                            },
                          ))
                      .toList()
                  : count == 1
                      ? seedPro
                          .hintForSecondPhrase()
                          .map((String e) => HintSeed(
                                seed: e,
                                onTap: () {
                                  setState(() {
                                    _second = e;
                                  });
                                },
                              ))
                          .toList()
                      : seedPro
                          .hintForThirdPhrase()
                          .map((String e) => HintSeed(
                                seed: e,
                                onTap: () {
                                  setState(() {
                                    _third = e;
                                  });
                                },
                              ))
                          .toList(),
            ),
          ),
          const Spacer(),
          CustomElevatedButton(
            title: 'Next',
            readOnly: (count == 0 && _first.isEmpty) ||
                (count == 1 && _second.isEmpty) ||
                (count == 2 && _third.isEmpty),
            onTap: () async {
              if (count != 2) {
                setState(() {
                  count++;
                });
              } else {
                if (_first == seedPro.firstWord &&
                    _second == seedPro.secondWord &&
                    _third == seedPro.thirdWord) {
                  final bool done = await WalletAPI()
                      .generatePrivateKey(phrase: seedPro.phraselist.toString());
                  if (done) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        WelcomeScreen.routeName,
                        (Route<dynamic> route) => false);
                  } else {
                    CustomToast.errorToast(
                        message: 'Facing issues while fetching info');
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        WalletSetupScreen.routeName,
                        (Route<dynamic> route) => false);
                  }
                } else {
                  CustomToast.errorToast(message: 'Invalid Seed Phrase Enterd');
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      WalletSetupScreen.routeName,
                      (Route<dynamic> route) => false);
                }
              }
            },
          ),
        ],
      );
    });
  }
}

class HintSeed extends StatelessWidget {
  const HintSeed({required this.seed, required this.onTap, Key? key})
      : super(key: key);
  final String seed;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minWidth: 30, maxWidth: 140),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:
              Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(seed),
      ),
    );
  }
}
