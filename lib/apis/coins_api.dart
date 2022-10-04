import '../models/coin_market_place/coin.dart';

class CoinsAPI {
  Future<List<Coin>?> listingLatest() async {
    final List<Coin> coins = <Coin>[];
    // final http.Request request = http.Request(
    //   'GET',
    //   Uri.parse('${APIUtils.walletBaseURL}/dashboard/coinlist'),
    // );
    // final http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   final String respStr = await response.stream.bytesToString();
    //   Map<String, dynamic> map = json.decode(respStr);
    //   for (dynamic element in map['coinlist']) {
    //     final Coin coin = Coin.fromJson(element);
    //     coins.add(coin);
    //   }
    //   log('Print: coins_api: Basic Coins List Count: ${coins.length}');
    return coins;
  }

  Future<Map<String, dynamic>?> coinTranfer({
    required double amount,
    required String toAddress,
    required String coinName,
    required String contractAddress,
    required bool getFee,
  }) async {
    return {};
    // Map<String, String> headers = <String, String>{
    //   'Content-Type': 'application/json'
    // };
    // final http.Request request = http.Request(
    //   'POST',
    //   Uri.parse('${APIUtils.walletBaseURL}/dashboard/transfer'),
    // );
    // request.body = json.encode(<String, dynamic>{
    //   'user_id': LocalData.accountID(),
    //   'accounts': LocalData.privateKeyAddress(),
    //   'privateKey': LocalData.privateKey(),
    //   'amount': amount,
    //   'to_address': toAddress,
    //   'coinName': coinName,
    //   'contractAddress': contractAddress,
    //   'getFee': getFee,
    // });
    // request.headers.addAll(headers);
    // http.StreamedResponse response = await request.send();

    //   final String respStr = await response.stream.bytesToString();
    //   Map<String, dynamic> mapp = json.decode(respStr);
    // if (response.statusCode == 200) {
    //   return mapp;
    // } else {
    //   APIRequestError.martketplace(response.statusCode);
    //   return null;
    // }
  }
}
