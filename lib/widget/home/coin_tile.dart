import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../models/coin_market_place/coin.dart';
import '../../screens/tranfer_screens/coin_transaction_option_screen.dart';
import '../custom_widgets/custom_network_image.dart';

class CoinTile extends StatelessWidget {
  const CoinTile({required this.coin, this.onTap, Key? key}) : super(key: key);
  final Coin coin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (coin.symbol!.toUpperCase() == 'BTC'){
      
    }
      return InkWell(
        onTap: onTap ??
            () {
              Navigator.of(context)
                  .push(MaterialPageRoute<CoinTransactionOptionScreen>(
                builder: (BuildContext context) =>
                    CoinTransactionOptionScreen(coin: coin),
              ));
            },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              // Coin Icon
              SizedBox(
                height: 50,
                width: 50,
                child: CustomNetworkImage(imageURL: coin.image!),
              ),
              // Coin Info
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      coin.symbol!.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      coin.priceChange24H! >= 0
                          ? '\$+${coin.priceChange24H!.toStringAsFixed(2)}'
                          : '\$${coin.priceChange24H!.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: coin.priceChange24H! < 0
                            ? Colors.red
                            : Colors.green,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              // Graph
              Expanded(
                child: SizedBox(
                  height: 40,
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
              // Amount info
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      coin.currentPrice.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    // Text(
                    //   coin.totalVolume.toStringAsFixed(2),
                    //   style: const TextStyle(
                    //     fontWeight: FontWeight.w500,
                    //     color: Colors.grey,
                    //     fontSize: 13,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
