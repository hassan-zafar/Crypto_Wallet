import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utilities/custom_validators.dart';
import '../../utilities/utilities.dart';
import '../custom_widgets/custom_elevated_button.dart';
import '../custom_widgets/gradient_text_widget.dart';
import '../custom_widgets/hideable_textformfield.dart';

class CreatePasswordStep extends StatefulWidget {
  const CreatePasswordStep({required this.onTap, Key? key}) : super(key: key);
  final VoidCallback onTap;

  @override
  State<CreatePasswordStep> createState() => _CreatePasswordStepState();
}

class _CreatePasswordStepState extends State<CreatePasswordStep> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isChecked = true;
  bool isLoading = false;
  bool signWithFaceID = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          Center(
            child: GradientTextWidget(
              text: 'Create Password',
              colors: Utilities.bgGradient,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'This password will unlock your Metamask wallet only on this service',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 10),
          HideableTextFormField(
            controller: _password,
            lable: 'Password',
            keyboardType: TextInputType.visiblePassword,
            readOnly: isLoading,
            validator: (String? value) => CustomValidator.password(value),
          ),
          RichText(
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: ' Password strength: ',
                  style: TextStyle(color: Colors.grey),
                ),
                TextSpan(
                  text: 'Good',
                  style: TextStyle(color: Colors.green),
                )
              ],
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
          const Text(
            '  Must be at least 8 characters',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: <Widget>[
          //     const Text(
          //       'Sign in with Face ID?',
          //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          //     ),
          //     CupertinoSwitch(
          //       value: signWithFaceID,
          //       activeColor: Theme.of(context).primaryColor,
          //       onChanged: (bool value) {
          //         setState(() {
          //           signWithFaceID = value;
          //         });
          //       },
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 20),
        
          Row(
            children: <Widget>[
              Checkbox(
                value: isChecked,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value ?? true;
                  });
                },
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // TODO: learn more on Tap
                  },
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        const TextSpan(
                          text:
                              'I understand that DeGe cannot recover this password for me. ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                          text: 'Learn more',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          CustomElevatedButton(
            title: 'Create Password',
            onTap: widget.onTap,
          ),
        ],
      ),
    );
  }
}
