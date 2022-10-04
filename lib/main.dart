import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'apis/local_data.dart';
import 'database/auth_methods.dart';
import 'firebase_options.dart';
import 'providers/app_provider.dart';
import 'providers/app_theme.dart';
import 'providers/exchange_provider.dart';
import 'providers/seed_phrase_provider.dart';
import 'providers/user_provider.dart';
import 'screens/Dapp_Browser/dapp_browser.dart';
import 'screens/auth/signin_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/verification_pin_screen.dart';
import 'screens/auth/welcome_screen.dart';
import 'screens/coming_soon.dart';
import 'screens/intro_screen/intro_screen.dart';
import 'screens/main_screen/main_screen.dart';
import 'screens/see_all_coin_screen/see_all_coin_screen.dart';
import 'screens/setting_screen/setting_screen.dart';
import 'screens/wallet_screens/create_wallet_screen/create_wallet_screen.dart';
import 'screens/wallet_screens/import_seed_screen/import_seed_screen.dart';
import 'screens/wallet_screens/wallet_created_success_screen/wallat_create_success_screen.dart';
import 'screens/wallet_screens/wallet_setup_screen/wallet_setup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  await dotenv.load(fileName: '.env');

  await LocalData.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // ignore: always_specify_types
      providers: [
        ChangeNotifierProvider<AppThemeProvider>.value(
          value: AppThemeProvider(),
        ),
        ChangeNotifierProvider<ExchangeCoinProvider>.value(
          value: ExchangeCoinProvider(),
        ),
        ChangeNotifierProvider<AppProvider>.value(value: AppProvider()),
        ChangeNotifierProvider<SeedPhraseProvider>.value(
            value: SeedPhraseProvider()),
        ChangeNotifierProvider<UserProvider>.value(value: UserProvider()),
      ],
      child: Consumer<AppThemeProvider>(
          builder: (BuildContext context, AppThemeProvider theme, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Muu Wallet',
          theme: AppThemes.light,
          darkTheme: AppThemes.dark,
          themeMode: theme.themeMode,
          home: AuthMethods.getCurrentUser == null
              ? const IntroScreen()
              : const MainScreen(),
          routes: <String, WidgetBuilder>{
            ComingSoom.routeName: (_) => const ComingSoom(),
            IntroScreen.routeName: (_) => const IntroScreen(),
            SigninScreen.routeName: (_) => const SigninScreen(),
            SignupScreen.routeName: (_) => const SignupScreen(),
            VerificationPinScreen.routeName: (_) =>
                const VerificationPinScreen(),
            WelcomeScreen.routeName: (_) => const WelcomeScreen(),
            // wallet screen
            WalletSetupScreen.routeName: (_) => const WalletSetupScreen(),
            ImportSeedScreen.routeName: (_) => const ImportSeedScreen(),
            CreateWalletScreen.routeName: (_) => const CreateWalletScreen(),
            WallatCreateSuccessScreen.routeName: (_) =>
                const WallatCreateSuccessScreen(),
            //
            MainScreen.routeName: (_) => const MainScreen(),
            SettingScreen.rotueName: (_) => const SettingScreen(),
            //
            SeeAllCoinScreen.routeName: (_) => const SeeAllCoinScreen(),
            DappBrowser.routeName: (_) => const DappBrowser(),
          },
        );
      }),
    );
  }
}
