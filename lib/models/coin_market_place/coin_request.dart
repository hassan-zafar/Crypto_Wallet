import 'dart:convert';

import 'coin.dart';
import 'coin_status.dart';

class CoinRequest {
  CoinRequest({
    required this.status,
    required this.coins,
  });

  CoinStatus status;
  List<Coin> coins;

  // ignore: sort_constructors_first
  factory CoinRequest.fromMap(Map<String, dynamic> json) {
    List<Coin> coinsList = [];
    List<dynamic> data = json['data'];
    for (dynamic element in data) {
      coinsList.add(Coin.fromJson(element));
    }
    return CoinRequest(
      status: CoinStatus.fromMap(json['status']),
      coins: coinsList,
    );
  }
  // ignore: sort_constructors_first
  factory CoinRequest.fromJson(String str) =>
      CoinRequest.fromMap(json.decode(str) as Map<String, dynamic>);
}
