import 'package:cron/cron.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../apis/local_data.dart';
import '../helpers/app_config.dart';
import '../models/coin_market_place/coin.dart';
import 'call_functions.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../helpers/strings.dart';
import '../widget/trns_text.dart';
import 'crypto_apis.dart';
import 'encrypt.dart';
import 'erc_20_wallet.dart';
import 'wallet_addresses.dart';

abstract class BaseMiscRepo {
  // Future<File?> cropImage(File imageFile);
  cronJob(Function function, int when);
  getUser(dataKey);
  getFinancials(dataKey);
  String getWallet(dataKey);
  getAppVersion();

  Future<double> getAllBalances();
  // Widget otpToggle(
  //   String title,
  //   bool _logOTP,
  //   bool _signOTP,
  //   Function(bool) _logOnChanged,
  //   Function(bool) _signOnChanged,
  //   Function()? onTap,
  //   context,
  // );
  Future<bool> onWillPop(context);
}

class MiscRepo implements BaseMiscRepo {
  List rpcs = [
    eTHRPCURL,
    BSC_RPC_URL,
  ];
  List ids = [
    BTC,
    DOGE,
    BCH,
    LTC,
  ];

  final EncryptApp _encryptApp = EncryptApp();
  final ERC20WalletAd _erc20walletAd = ERC20WalletAd();
  final WalletAd _walletAd = WalletAd();
  final ApiRepo _apiRepo = ApiRepo();
  final CallFunctions _callFunctions = CallFunctions();

  final Cron cron = Cron();
  // var userBox = Hive.box(USERS);

  // @override
  // Future<File?> cropImage(File imageFile) async {
  //   File? croppedFile;
  //   try {
  //     croppedFile = await ImageCropper.cropImage(
  //         sourcePath: imageFile.path,
  //         aspectRatioPresets: Platform.isAndroid
  //             ? [
  //                 CropAspectRatioPreset.square,
  //                 CropAspectRatioPreset.ratio3x2,
  //                 CropAspectRatioPreset.original,
  //                 CropAspectRatioPreset.ratio4x3,
  //                 CropAspectRatioPreset.ratio16x9
  //               ]
  //             : [
  //                 CropAspectRatioPreset.original,
  //                 CropAspectRatioPreset.square,
  //                 CropAspectRatioPreset.ratio3x2,
  //                 CropAspectRatioPreset.ratio4x3,
  //                 CropAspectRatioPreset.ratio5x3,
  //                 CropAspectRatioPreset.ratio5x4,
  //                 CropAspectRatioPreset.ratio7x5,
  //                 CropAspectRatioPreset.ratio16x9
  //               ],
  //         androidUiSettings: AndroidUiSettings(
  //             toolbarTitle: 'Cropper',
  //             toolbarColor: accentColor,
  //             toolbarWidgetColor: white,
  //             initAspectRatio: CropAspectRatioPreset.original,
  //             lockAspectRatio: false),
  //         iosUiSettings: IOSUiSettings(
  //           title: 'Cropper',
  //         ));

  //     return croppedFile;
  //   } catch (e) {
  //     print(e);
  //   }
  //   return croppedFile;
  // }

  @override
  cronJob(Function function, int when) {
    function();

    cron.schedule(Schedule.parse('*/$when * * * *'), () async {
      function();
    });
  }

  @override
  getUser(dataKey) {
    // var data = userBox.get(USER)[USER][dataKey];

    return dataKey;
  }

  @override
  getFinancials(dataKey) {
    // var data = userBox.get(USER)[FINANCIAL][dataKey];
    return dataKey;
  }

  @override
  getWallet(dataKey) {
    // var data = _encryptApp.appDecrypt(userBox.get(USER)[WALLET][dataKey]);
    return 'data';
  }

  @override
  Future<double> getAllBalances() async {
    final Map<String, dynamic> balances = {};
    rates = {};
    List walletIds = [];

    String erKey = ERC20 + '_' + ADDRESS;
    // var encryptedErc20 = userBox.get(USER)[WALLET][erKey];
    // String data = _encryptApp.appDecrypt(encryptedErc20);
    print('walletAddMap');
    print(walletAddMap);
    for (String id in ids) {
      String walKey = id + '_' + WALLETID;

      var encryptedWallet = walletAddMap[id + '_' + WALLETID];
      // userBox.get(USER)[WALLET][walKey];
      String walletData = _encryptApp.appDecrypt(encryptedWallet!);
      walletIds.add(walletData);
    }
    print('wallet ids');
    print(walletIds);
    try {
      // BTC LTC DOGE BCH

      Map<String, dynamic> walletBalances =
          await _walletAd.getWalletBalance(walletIds);

      balances.addAll(walletBalances);
      print('balances' + balances.toString());
      // ETH BNB
//TODO: add BNB
      // for (String rpc in rpcs) {
      //   for (var i = 0; i < 2; i++) {
      //     String unit = i == 0 ? ETH : BNB;

      //     await _erc20walletAd.clientsInit(rpc);
      //     // String? ethBal = await _erc20walletAd.getEthBnbWalletBalance(data);
      //     // balances[unit] = (double.parse(ethBal));
      //   }
      // }

      // crypD.put(BALANCES, balances);
    } catch (e) {
      print(e);
    }
    await _apiRepo.getCryptoCarousel().then((List value) {
      for (int i = 0; i < value.length; i++) {
        rates[value[i][SYMBOL]] = value[i][CURRENT_PRICE];
        //  balances[SYMBOL] = rates[SYMBOL] * balances[SYMBOL];

      }
      print('rates' + rates.toString());
      // crypD.put(EX_RATES, rates);
    });
    double total = 0.0;
    for (String unit in units) {
      total += balances[unit] * rates[unit];
      print('balances' + balances.toString());
    }

    print('total' + balances.toString());
    return total;
  }

  @override
  Future<bool> onWillPop(context) async {
    _callFunctions.showPopUp(
      context,
      const TrnsText(title: 'Are you sure you want to go back?'),
      [
        CupertinoButton(
          child: const TrnsText(title: 'Yes'),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        CupertinoButton(
          child: const TrnsText(title: 'No'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
      [
        TextButton(
          child: const TrnsText(title: 'Yes'),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const TrnsText(title: 'No'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    return true;
  }

  @override
  Future<String> getAppVersion() async {
    String appVersion;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    appVersion = '$version.$buildNumber';
    return appVersion;
  }
}
