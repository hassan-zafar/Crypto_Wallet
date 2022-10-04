import 'dart:convert';
import 'package:http/http.dart' as http;
import '../apis/local_data.dart';
import 'encrypt.dart';
import '../helpers/strings.dart';

abstract class BaseSwap {
  Future<Map> swapCoin(String from, String to, String amount);
  Future<double> getEstimate(String from, String to, String amount);
}

class SwapRepo implements BaseSwap {
  // var userBox = Hive.box(USERS);
  final EncryptApp _encryptApp = EncryptApp();
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
  };

  @override
  Future<Map> swapCoin(String from, String to, String amount) async {
    Map swapDetails = {};
    String unit = to == BNB || to == ETH || to == USDT ? ERC20 : to;
    var encryptedErc20 = LocalData.privateKey();
    String address = _encryptApp.appDecrypt(encryptedErc20!);
    try {
      Map<String, dynamic> body = {
        'fixed': false,
        'currency_from': from == USDT
            ? 'usdtbsc'
            : from == BNB
                ? 'bnb-bsc'
                : from,
        'currency_to': to == USDT
            ? 'usdtbsc'
            : to == BNB
                ? 'bnb-bsc'
                : to,
        'address_to': address,
        'amount_from': amount,
      };

      String? stealthEx = '6b248bce-268e-4447-b24c-1be9c4510951';

      String url =
          'https://api.stealthex.io/api/v2/exchange?api_key=$stealthEx';

      http.Response response = await http.post(
        (Uri.parse(url)),
        headers: requestHeaders,
        body: jsonEncode(body),
      );

      var resBody2 = jsonDecode(response.body);

      swapDetails = {
        ID: resBody2[ID],
        ADDRESS: resBody2['address_from'],
      };
    } catch (e) {
      print(e);
    }
    return swapDetails;
  }

  @override
  Future<double> getEstimate(String from, String to, String amount) async {
    String? estimate;
    try {
      String? stealthEx = '6b248bce-268e-4447-b24c-1be9c4510951';

      String url =
          'https://api.stealthex.io/api/v2/estimate/$from/$to?amount=$amount&api_key=$stealthEx';

      http.Response response = await http.get(
        (Uri.parse(url)),
        headers: requestHeaders,
      );

      var resBody = jsonDecode(response.body);
      estimate = resBody['estimated_amount'];
      return double.parse(estimate!);
    } catch (e) {
      print(e);
    }
    return double.parse(estimate!);
  }
}
