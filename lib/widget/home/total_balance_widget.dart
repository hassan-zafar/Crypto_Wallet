import 'package:flutter/material.dart';
import '../../backend/all_backends.dart';
import '../../backend/encrypt.dart';
import '../../helpers/app_config.dart';
import '../../models/coin_market_place/coin.dart';
import '../../utilities/utilities.dart';
import '../custom_widgets/show_loading.dart';

class TotalBalanceWidget extends StatefulWidget {
  TotalBalanceWidget({Key? key}) : super(key: key);

  @override
  State<TotalBalanceWidget> createState() => _TotalBalanceWidgetState();
}

class _TotalBalanceWidgetState extends State<TotalBalanceWidget> {
  List walletIds = [];

  EncryptApp _encryptApp = EncryptApp();

  @override
  void initState() {
    // TODO: get proper address
    super.initState();
    // getWallertIds();
  }

  getWalletIds() async {
    // List walletIds = await
    setState(() {
      this.walletIds = walletIds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: Utilities.bproGradient),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'Total balance',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Cash available',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: AllBackEnds().getAllBalances(),
            // AllBackEnds().getWalletBalance([AllBackEnds().decrypt(walletAddMap['btc_wallet_id'])]),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print(snapshot);
              if (snapshot.hasError) {
                return const Text(
                  '-Error-',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                );
              } else if (snapshot.hasData) {
                return Text(
                  '\$ ${snapshot.data.toString()}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 24),
                );
              } else {
                return const ShowLoading();
              }
            },
          ),
        ],
      ),
    );
  }
}
