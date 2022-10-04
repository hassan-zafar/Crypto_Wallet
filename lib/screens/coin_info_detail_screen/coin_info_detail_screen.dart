import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/coin_market_place/coin.dart';
import '../../widget/coin_list_view.dart';
import '../../widget/custom_widgets/custom_elevated_button.dart';
import '../../widget/home/coin_tile.dart';

class CoinInfoDetailScreen extends StatelessWidget {
  const CoinInfoDetailScreen({required this.coin, Key? key}) : super(key: key);
  final Coin coin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exchange'),
        actions: <Widget>[
          IconButton(
            splashRadius: 20,
            onPressed: () {
              // TODO: Search Page Navigation
            },
            icon: const Icon(CupertinoIcons.search),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            CoinTile(coin: coin, onTap: () {}),
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Graph here',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const _Buttons(),
            const CoinListView(),
          ],
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: CustomElevatedButton(
              title: 'Buy',
              onTap: () {},
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: CustomElevatedButton(
              bgColor: Colors.transparent,
              border: Border.all(color: Colors.grey.shade200),
              textStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyText1!.color,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              title: 'Sell',
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
