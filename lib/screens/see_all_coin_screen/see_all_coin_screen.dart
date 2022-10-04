import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widget/coin_list_view.dart';

class SeeAllCoinScreen extends StatelessWidget {
  const SeeAllCoinScreen({Key? key}) : super(key: key);
  static const String routeName = '/SeeAllCoinScreen';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'Markets',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            CoinListView(),
          ],
        ),
      ),
    );
  }
}
