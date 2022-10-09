

import 'package:wuu_crypto_wallet/backend/erc_20_wallet.dart';
import 'package:wuu_crypto_wallet/backend/wallet_addresses.dart';
import 'package:wuu_crypto_wallet/constants/collections.dart';

import '../helpers/app_config.dart';
import '../models/seed_phrase.dart';

class WalletAPI {
  Future<SeedPhrase?> getSeedPhrase() async {
    // final http.Request request = http.Request(
    //   'GET',
    //   Uri.parse(
    //     '${APIUtils.walletBaseURL}/wallet/seedPharse',
    //   ),
    // );
    // final http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   final String respStr = await response.stream.bytesToString();
    //   final SeedPhrase seedPhrase = SeedPhrase.fromJson(respStr);
    //   return seedPhrase;
    // } else {
    //   APIRequestError.martketplace(response.statusCode);
    //   return null;
    // }
    return null;
  }

  Future<bool> generatePrivateKey({required String phrase}) async {
    print('Phrase: $phrase');

    final ERC20WalletAd _erc20walletAd = ERC20WalletAd();
    final WalletAd _walletAd = WalletAd();
    walletAddMap = await _walletAd.createWallet();
    Map<String, dynamic> erc20Add = await _erc20walletAd.createErcWallet();
    walletAddMap.addAll(erc20Add);
    await walletRef.doc(phrase).set(walletAddMap);
    return true;
  }

  Future<bool> importPrivateKey({required String privateKey}) async {
    await walletRef.doc(privateKey).get().then((value) {
      walletAddMap = value.data()!;
    }).catchError((e) {
      print(e);
      return false;
    });
    // Map<String, String> headers = <String, String>{
    //   'Content-Type': 'application/json'
    // };
    // final http.Request request = http.Request(
    //     'POST', Uri.parse('${APIUtils.walletBaseURL}/wallet/importPrivateKey'));
    // request.body = json.encode(<String, String>{'private_key': privateKey});
    // request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   final String respStr = await response.stream.bytesToString();
    //   Map<String, dynamic> mapp = json.decode(respStr);
    //   LocalData.setPrivateKey(mapp['privateKey']);
    //   LocalData.setPrivateKeyAddress(mapp['address']);
    //   return true;
    // } else {
    //   CustomToast.errorToast(message: 'Facing errors while fetching Key');
    //   return false;
    // }

    return true;
  }

  Future<double> balance() async {
    // final String? address = LocalData.privateKeyAddress();
    // print(address);
    // Map<String, String> headers = <String, String>{
    //   'Content-Type': 'application/json'
    // };
    // final http.Request request = http.Request(
    //     'POST', Uri.parse('${APIUtils.walletBaseURL}/dashboard/getBalance'));
    // request.body = json.encode(<String, dynamic>{
    //   'accounts': address ?? '',
    // });
    // request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   final String respStr = await response.stream.bytesToString();
    //   Map<String, dynamic> mapp = json.decode(respStr);
    //   return double.parse(mapp['balance']);
    // } else {
    //   return 0;
    // }
    return 0;
  }
}
