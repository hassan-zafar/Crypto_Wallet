import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wuu_crypto_wallet/screens/main_pages/exchange_coin_screen.dart';

import '../../backend/encrypt.dart';
import '../../constants/collections.dart';
import '../../database/auth_methods.dart';
import '../../helpers/app_config.dart';
import '../../providers/app_provider.dart';
import '../../providers/exchange_provider.dart';
import '../SwapCoin/swap_coin.dart';
import '../main_pages/history_page.dart';
import '../main_pages/home_page.dart';
import '../main_pages/profile_page.dart';
import '../main_pages/coin_balace_page.dart';
import 'main_bottom_navigation_bar.dart';

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
    // getWallet();
  }

  bool isLoading = false;

  getWallet() async {
    setState(() {
      isLoading = true;
    });

    print('in create wallet');
    // try {
    print(AuthMethods.getCurrentUser!.uid);
    var value=await walletRef.doc(AuthMethods.getCurrentUser!.uid).get();
    print(value.exists);
      print(value.data());
      walletAddMap = value.data()!;
      print('walletAddMap $walletAddMap');
      String asd = _encryptApp.appDecrypt(walletAddMap['doge_wallet_id']);
      print(asd);
      print(_encryptApp.appDecrypt(walletAddMap['doge_address']));
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
