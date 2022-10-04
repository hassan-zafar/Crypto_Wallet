import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../apis/local_data.dart';
import '../../providers/app_provider.dart';
import '../../providers/user_provider.dart';
import '../../widget/custom_widgets/custom_elevated_button.dart';
import '../../widget/custom_widgets/title_clickable_tile.dart';
import '../../widget/profile/user_profile_info_card.dart';
import '../intro_screen/intro_screen.dart';
import '../setting_screen/setting_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        actions: <Widget>[
          IconButton(
            splashRadius: 20,
            onPressed: () => Navigator.of(context).pushNamed(
              SettingScreen.rotueName,
            ),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Consumer<UserProvider>(
          builder: (BuildContext context, UserProvider userPro, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              UserProfileInfoCard(user: userPro.currentUser),
              const SizedBox(height: 10),
              TitleClickableTile(title: 'View Profile', onTap: () {}),
              TitleClickableTile(
                title: 'Language',
                trailing: const Text(
                  'English',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                onTap: () {},
              ),
              const Spacer(),
              CustomElevatedButton(
                title: 'Logout',
                bgColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 18),
                textStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                ),
                border: Border.all(color: Theme.of(context).primaryColor),
                onTap: () {
                  LocalData.signout();
                  Provider.of<AppProvider>(context, listen: false)
                      .onTabTapped(0);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      IntroScreen.routeName, (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
