import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../helpers/strings.dart';
import '../models/coin_market_place/coin.dart';

abstract class BaseApis {
  Future<List>? getAllDatas();
  getCryptoMovers();
  getCryptoCarousel();
}

class ApiRepo implements BaseApis {
  var allD = {};
  // Hive.box(ALL_CRYPTO_DATAS);
  var crypD = {};
  //  Hive.box(CRYPTO_DATAS);
  var settingsBx = {};
  // Hive.box(SETTINGS);
  String currency() {
    return
        //  settingsBx.get(CURRENCY) ??
        'usd';
  }

  @override
  Future<List<Coin>>? getAllDatas() async {
    List<Coin>? dts = [];
    try {
      String url =
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=${currency()}&order=market_cap_desc&per_page=250&page=1&sparkline=true';

      http.Response response = await http.get(
        (Uri.parse(url)),
      );
      print('here');
      List body = jsonDecode(response.body);
      // Coin.fromMap(jsonDecode(response.body));

      for (int i = 0; i < body.length; i++) {
        dts.add(Coin.fromMap(body[i]));
      }
      
      return dts;
    } catch (e) {
      print(e);
    }
    return dts;
  }

  @override
  Future<List> getCryptoMovers() async {
    List<dynamic> maxListId = [];
    List<dynamic> minListId = [];

    List maxMinListId = [];

    String url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=${currency()}&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h';

    http.Response response = await http.get(
      (Uri.parse(url)),
    );

    var body = jsonDecode(response.body);
    print(body);
    List? dats = body ?? [];

    dats!.sort((a, b) => b[PRICE_CHANGE_PERCENTAGE_24H]
        .compareTo(a[PRICE_CHANGE_PERCENTAGE_24H]));

    maxListId = dats.take(4).toList();

    dats.sort((b, a) => b[PRICE_CHANGE_PERCENTAGE_24H]
        .compareTo(a[PRICE_CHANGE_PERCENTAGE_24H]));
    minListId = dats.take(4).toList();

    maxMinListId = List.from(maxListId)..addAll(minListId);

    return maxMinListId;
  }

  @override
  Future<List> getCryptoCarousel() async {
    List dts;
    dts = await _storeDatas(CRYPTOCURRENCIES);
    return dts;
  }

  Map _mapData(body, int i) {
    Map datas = {
      ID: body[i][ID] ?? '',
      NAME: body[i][NAME] ?? '',
      IMAGE: body[i][IMAGE] ?? '',
      CURRENT_PRICE: body[i][CURRENT_PRICE] ?? 0.0,
      SYMBOL: body[i][SYMBOL] ?? '',
      PRICE_CHANGE_PERCENTAGE_24H: body[i][PRICE_CHANGE_PERCENTAGE_24H] ?? 0.0,
      SPARKLINE_IN_7D: body[i][SPARKLINE_IN_7D][PRICE] ?? [],
    };
    return datas;
  }

  Future<List> _storeDatas(List idList) async {
    List dts = [];
    try {
      for (String id in idList) {
        String newUrl =
            'https://api.coingecko.com/api/v3/coins/markets?vs_currency=${currency()}&ids=$id&order=market_cap_desc&page=1&sparkline=true&price_change_percentage=24h';

        http.Response response = await http.get(
          (Uri.parse(newUrl)),
        );
        List body = jsonDecode(response.body);
        Map datas = _mapData(body, 0);

        dts.add(datas);
      }
      return dts;
    } catch (e) {
      debugPrint(e.toString());
    }
    return dts;
  }
}
