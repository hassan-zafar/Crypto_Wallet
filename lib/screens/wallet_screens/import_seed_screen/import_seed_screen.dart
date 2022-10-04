import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Utilities/custom_validators.dart';
import '../../../apis/wallet_api.dart';
import '../../../widget/custom_widgets/custom_elevated_button.dart';
import '../../../widget/custom_widgets/hideable_textformfield.dart';
import '../../../widget/custom_widgets/show_loading.dart';
import '../../main_screen/main_screen.dart';

class ImportSeedScreen extends StatefulWidget {
  const ImportSeedScreen({Key? key}) : super(key: key);
  static const String routeName = '/ImportSeedScreen';

  @override
  State<ImportSeedScreen> createState() => _ImportSeedScreenState();
}

class _ImportSeedScreenState extends State<ImportSeedScreen> {
  final TextEditingController _seeds = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isLoading = false;
  bool signWithFaceID = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text('Import From Seed')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _key,
            onChanged: () => setState(() {}),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: HideableTextFormField(
                        controller: _seeds,
                        lable: 'Seed Phrase',
                        notVisible: false,
                        maxLines: 3,
                        readOnly: isLoading,
                        validator: (String? value) =>
                            CustomValidator.isEmpty(value),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      splashRadius: 16,
                      icon: const Icon(CupertinoIcons.barcode_viewfinder),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                HideableTextFormField(
                  controller: _password,
                  lable: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  readOnly: isLoading,
                  validator: (String? value) => CustomValidator.password(value),
                ),
                const Text(
                  '  Must be at least 8 characters',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                HideableTextFormField(
                  controller: _confirmPass,
                  lable: 'Confirm Password',
                  keyboardType: TextInputType.visiblePassword,
                  readOnly: isLoading,
                  validator: (String? value) =>
                      CustomValidator.likeThat(value, _password.text),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Sign in with Face ID?',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    CupertinoSwitch(
                      value: signWithFaceID,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (bool value) {
                        setState(() {
                          signWithFaceID = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'By proceeding, you agree to these ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                          text: 'Term and Conditions.',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                isLoading
                    ? const ShowLoading()
                    : CustomElevatedButton(
                        title: 'Import',
                        readOnly: !(_key.currentState?.validate() ?? false),
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          final bool done = await WalletAPI()
                              .importPrivateKey(privateKey:  _seeds.text);
                          setState(() {
                            isLoading = false;
                          });
                          if (done) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                MainScreen.routeName,
                                (Route<dynamic> route) => false);
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
