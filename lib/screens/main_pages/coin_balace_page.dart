import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/app_config.dart';
import '../../models/swapable_coin.dart';
import '../../providers/exchange_provider.dart';
import '../../widget/coin_list_view.dart';

class CoinScreen extends StatelessWidget {
  const CoinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<ExchangeCoinProvider>(builder:
            (BuildContext context, ExchangeCoinProvider exchangePro, _) {
          return Text(
            '${exchangePro.from?.name ?? 'Bitcoin'} Balance',
          );
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _BalanceWidget(),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _Button(
                    title: 'Deposit',
                    icon: const Icon(
                      Icons.arrow_downward,
                      size: 18,
                      color: Colors.greenAccent,
                    ),
                    onTap: () {},
                  ),
                  _Button(
                    title: 'Withdrawal',
                    icon: const Icon(
                      Icons.arrow_upward,
                      size: 18,
                      color: Colors.greenAccent,
                    ),
                    onTap: () {},
                  ),
                  _Button(
                    title: 'Earn',
                    icon: const Icon(
                      Icons.arrow_drop_up_rounded,
                      size: 18,
                      color: Colors.greenAccent,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const CoinListView(),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.onTap,
    required this.title,
    required this.icon,
    Key? key,
  }) : super(key: key);
  final VoidCallback onTap;
  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          icon,
        ],
      ),
    );
  }
}

class _BalanceWidget extends StatefulWidget {
  const _BalanceWidget({Key? key}) : super(key: key);
  @override
  State<_BalanceWidget> createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<_BalanceWidget> {
  bool hiden = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Text(
              'Total Balance',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
            IconButton(
              splashRadius: 14,
              onPressed: () {
                setState(() {
                  hiden = !hiden;
                });
              },
              icon: Icon(
                hiden ? CupertinoIcons.eye : CupertinoIcons.eye_slash_fill,
                size: 18,
              ),
            ),
          ],
        ),
        Consumer<ExchangeCoinProvider>(builder:
            (BuildContext context, ExchangeCoinProvider exchangePro, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: hiden ? 14 : 50,
                  child: FittedBox(
                    child: Text(
                      hiden
                          ? 'Tap on the Eye Button to show the balance'
                          : '\$ $totalBalance ',
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: hiden
                            ? Colors.grey
                            : Theme.of(context).textTheme.bodyText1!.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              DropdownButton<SwapableCoin>(
                value: exchangePro.from,
                style: const TextStyle(color: Colors.black),
                underline: const SizedBox(),
                hint: const Text(
                  'Select coin',
                  style: TextStyle(color: Colors.black),
                ),
                items: exchangePro.swapableCoins
                    .map((SwapableCoin coin) => DropdownMenuItem<SwapableCoin>(
                          value: coin,
                          child: Text(
                            coin.symbol.toUpperCase(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ))
                    .toList(),
                onChanged: (SwapableCoin? value) =>
                    exchangePro.onFromCoinChange(value),
              ),
            ],
          );
        }),
      ],
    );
  }
}
