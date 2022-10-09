import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wuu_crypto_wallet/database/auth_methods.dart';
import 'package:wuu_crypto_wallet/helpers/app_config.dart';
import 'package:wuu_crypto_wallet/screens/intro_screen/intro_screen.dart';
import 'package:wuu_crypto_wallet/screens/main_screen/main_bottom_navigation_bar.dart';
import 'package:wuu_crypto_wallet/screens/wallet_screens/wallet_setup_screen/wallet_setup_screen.dart';

class UserState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        // ignore: missing_return
        builder: (context, AsyncSnapshot<User?> userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (userSnapshot.connectionState == ConnectionState.active) {
            if (userSnapshot.hasData) {
              print('userSnapshot.hasData ${userSnapshot.hasData}');
              var uid = userSnapshot.data!.uid;
              AuthMethods()
                  .fetchUserInfoFromFirebase(uid: userSnapshot.data!.uid)
                  .then((value) {
                print('The user is already logged in');
                currentUser = value;
                AuthMethods()
                    .fetchWalletInfoFromFirebase(
                        seedPhrase: currentUser!.seedPhrase)
                    .then((hasWallet) {
                  if (hasWallet) {
                    return const MainBottomNavigationBar();
                  } else {
                    return const WalletSetupScreen();
                  }
                });
              });
              return const WalletSetupScreen();
              // return HomePage();

              // MainScreens();
            } else {
              print('The user didn\'t login yet');
              return const IntroScreen();
              // IntroductionAuthScreen();
            }
          } else if (userSnapshot.hasError) {
            return const Center(
              child: Text('Error occured'),
            );
          } else {
            return const Center(
              child: Text('Error occured'),
            );
          }
        });
  }
}
