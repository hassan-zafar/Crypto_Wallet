import 'package:flutter/material.dart';

import '../../widget/custom_widgets/title_clickable_tile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);
  static const String rotueName = '/SettingScreen';

  @override
  Widget build(BuildContext context) {
    const TextStyle trailingTextStyle =
        TextStyle(color: Colors.grey, fontSize: 13);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TitleClickableTile(
                title: 'Currency',
                onTap: () {},
                trailing: Text(
                  'usd'.toUpperCase(),
                  style: trailingTextStyle,
                ),
              ),
              TitleClickableTile(title: 'Privacy policy', onTap: () {}),
              TitleClickableTile(
                title: 'About Us',
                trailing: const Text('v2.36.2', style: trailingTextStyle),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
