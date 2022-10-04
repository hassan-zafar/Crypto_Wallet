import 'package:flutter/material.dart';
import '../apis/coins_api.dart';
import '../backend/all_backends.dart';
import '../helpers/app_config.dart';
import '../models/coin_market_place/coin.dart';
import 'custom_widgets/show_loading.dart';
import 'home/coin_tile.dart';

class CoinListView extends StatelessWidget {
  const CoinListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Coin>?>(
      future: AllBackEnds().getAllDatas(),
      builder: (BuildContext context, AsyncSnapshot<List<Coin>?> snapshot) {
        if (snapshot.hasData) {
          coins= snapshot.data ?? <Coin>[];
          return Expanded(
            child: ListView.builder(
              itemCount: coins.length,
              itemBuilder: (BuildContext context, int index) {
                return CoinTile(coin: coins[index]);
              },
            ),
          );
        } else {
          return const ShowLoading();
        }
      },
    );
  }
}
