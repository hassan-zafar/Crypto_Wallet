import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../backend/all_backends.dart';
import '../../backend/encrypt.dart';
import '../../backend/erc_20_wallet.dart';
import '../../backend/wallet_addresses.dart';
import '../../constants/collections.dart';
import '../../database/auth_methods.dart';
import '../../database/user_local_data.dart';
import '../../helpers/app_config.dart';
import '../../helpers/strings.dart';
import '../../providers/app_provider.dart';
import '../../providers/exchange_provider.dart';
import '../SwapCoin/swap_coin.dart';
import '../main_pages/exchange_coin_screen.dart';
import '../main_pages/history_page.dart';
import '../main_pages/home_page.dart';
import '../main_pages/profile_page.dart';
import '../main_pages/coin_balace_page.dart';
import '../wallet_screens/create_wallet_screen/create_wallet_screen.dart';
import 'main_bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String routeName = '/MainScreen';

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    CoinScreen(),
    // ExchangeCoinScreen(),
    SwapScreen(),
    HistoryPage(),
    ProfilePage(),
  ];

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final EncryptApp _encryptApp = EncryptApp();
  @override
  void initState() {
    super.initState();
    getWallet();
  }

  bool isLoading = false;

  getWallet() async {
    setState(() {
      isLoading = true;
    });

    print('in create wallet');
    // try {
    print(AuthMethods.getCurrentUser!.uid);
    var asd=await walletRef.doc(AuthMethods.getCurrentUser!.uid).get();
    print(asd.exists);
    // .then((DocumentSnapshot<Map<String, dynamic>>value) {

    // });
    // Map? erc20Add = await _erc20walletAd.createErcWallet();
    setState(() {
      isLoading = false;
    });

    // walletAddMap.addAll(erc20Add!);
    // walletAddMap[UID] = 'asd';
    // http.Response response = await http.post(
    //   Uri.parse('${url}store-wallets.php'),
    //   headers: header,
    //   body: walletAddMap,
    // );

    // var resbody = json.decode(response.body);

    // if (resbody[STATUS] == 'failed') {
    //   _callFunctions.showSnacky(resbody[MESSAGE], false, context);
    // }
    // } catch (e) {
    //   // _callFunctions.showSnacky(DEFAULT_ERROR, false, context);

    //   print(e);
    // }
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = Provider.of<AppProvider>(context).currentTap;
    Provider.of<ExchangeCoinProvider>(context).init();
    return Scaffold(
      body: isLoading
          ? const CircularProgressIndicator()
          : MainScreen._pages[currentIndex],
      bottomNavigationBar: const MainBottomNavigationBar(),
    );
  }
}
