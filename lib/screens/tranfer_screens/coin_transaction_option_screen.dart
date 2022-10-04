import 'package:extended_image/extended_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../helpers/app_config.dart';
import '../../models/coin_market_place/coin.dart';
import 'receive_btc_screen.dart';
import 'send_btc_screen.dart';

class CoinTransactionOptionScreen extends StatelessWidget {
  const CoinTransactionOptionScreen({required this.coin, Key? key})
      : super(key: key);
  final Coin coin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 480,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 400,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: ExtendedNetworkImageProvider(coin.image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 160,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute<SendBTCScreen>(
                      builder: (BuildContext context) =>
                          SendBTCScreen(coin: coin, transactionPossible: units.contains(coin.symbol)),
                    ));
                  },
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    height: 50,
                    width: 100,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    alignment: Alignment.centerRight,
                    child: const Text(
                      'SEND',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 160,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute<ReceiveBTCScreen>(
                      builder: (BuildContext context) =>
                           ReceiveBTCScreen(coin: coin, transactionPossible: units.contains(coin.symbol)),
                    ));
                  },
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    height: 50,
                    width: 100,
                    padding: const EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'RECEIVE',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 120,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: FittedBox(
                        child: Text(
                          '\$${coin.currentPrice}',
                          style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        children: <TextSpan>[
                          const TextSpan(text: 'Change '),
                          TextSpan(
                            text: coin.priceChange24H! >= 0
                                ? '+${coin.priceChange24H.toString()}%'
                                : '${coin.priceChange24H.toString()}%',
                            style: TextStyle(
                              color: coin.priceChange24H! < 0
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 250,
                left: 0,
                right: 0,
                child: Container(
                  height: 2,
                  width: double.infinity,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              Positioned(
                top: 260,
                bottom: 20,
                left: 0,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: LineChart(
                    LineChartData(
                      titlesData: FlTitlesData(show: false),
                      gridData: FlGridData(
                        show: false,
                        drawVerticalLine: false,
                        drawHorizontalLine: false,
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: <LineChartBarData>[
                        LineChartBarData(
                          isCurved: true,
                          dotData: FlDotData(show: false),
                          spots: <FlSpot>[
                            FlSpot(1, coin.priceChange24H!),
                            // FlSpot(1.2, coin.priceChangePercentage7D),
                            // FlSpot(1.3, coin.priceChangePercentage14D),
                            // FlSpot(1.4, coin.priceChangePercentage30D),
                            // FlSpot(1.5, coin.priceChangePercentage60D),
                            // FlSpot(1.6, coin.priceChangePercentage200D),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
