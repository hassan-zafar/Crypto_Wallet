import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../apis/exchange_api.dart';
import '../../models/swapable_coin.dart';
import '../../providers/exchange_provider.dart';
import '../../utilities/app_images.dart';
import '../../widget/coin/coin_textformfield.dart';
import '../../widget/custom_widgets/custom_elevated_button.dart';
import '../../widget/custom_widgets/custom_toast.dart';
import '../../widget/custom_widgets/show_loading.dart';

class ExchangeCoinScreen extends StatefulWidget {
  const ExchangeCoinScreen({Key? key}) : super(key: key);

  @override
  State<ExchangeCoinScreen> createState() => _ExchangeCoinScreenState();
}

class _ExchangeCoinScreenState extends State<ExchangeCoinScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exchange')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
           FutureBuilder<bool>(
              future: Provider.of<ExchangeCoinProvider>(context, listen: false)
                  .init(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Facing Error\n${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return Consumer<ExchangeCoinProvider>(builder:
                      (BuildContext context, ExchangeCoinProvider exchnagePro,
                          _) {
                    return Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 32),
                          CoinTextFormField(
                            key: UniqueKey(),
                            controller: exchnagePro.fromController,
                            coinsList: exchnagePro.fromList(),
                            selectedCoin: exchnagePro.from,
                            onChanged: (String? value) =>
                              exchnagePro.onFromControllerChange(value),
                            onCoinSelection: (SwapableCoin? value) =>
                                exchnagePro.onFromCoinChange(value),
                            validator: (String? value) =>
                                exchnagePro.fromValidator(value),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Coin Balance: ${exchnagePro.fromCoinBalance}',
                          ),
                          const _DividerWidger(),
                          CoinTextFormField(
                            key: UniqueKey(),
                            controller: exchnagePro.toController,
                            coinsList: exchnagePro.toList(),
                            selectedCoin: exchnagePro.to,
                            onChanged: (String? value) =>
                                exchnagePro.onToControllerChange(value),
                            onCoinSelection: (SwapableCoin? value) =>
                                exchnagePro.onToCoinChange(value),
                            validator: (String? value) => null,
                          ),
                          const SizedBox(height: 32),
                          _Charges(
                            title: 'Swap Price: ',
                            subtitle: exchnagePro.swapPrice.toString(),
                          ),
                          _Charges(
                            title: 'Price Impect: ',
                            subtitle: '${exchnagePro.priceImpact}%',
                            subtitleStyle: TextStyle(
                              color: exchnagePro.priceImpact < 15
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          isLoading
                              ? const ShowLoading()
                              : CustomElevatedButton(
                                  title: 'Exchange',
                                  onTap: () async {
                                    if (_key.currentState!.validate()) {
                                      if (exchnagePro.priceImpact < 15) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await exchnagePro.exhcange();
                                        setState(() {
                                          isLoading = false;
                                        });
                                      } else {
                                        CustomToast.errorToast(
                                          message: 'Price impect is too high',
                                        );
                                      }
                                    }
                                  },
                                ),
                          const SizedBox(height: 16),
                          Text(
                            exchnagePro.error,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    );
                  });
                } else {
                  return const ShowLoading();
                }
              }),
        ),
      ),
    );
  }
}

class _Charges extends StatelessWidget {
  const _Charges({
    required this.title,
    required this.subtitle,
    // ignore: unused_element
    this.titleStyle,
    // ignore: unused_element
    this.subtitleStyle,
    Key? key,
  }) : super(key: key);
  final String title;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          title,
          style: titleStyle ?? const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          subtitle,
          style: subtitleStyle ?? const TextStyle(fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}

class _DividerWidger extends StatelessWidget {
  const _DividerWidger({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: SizedBox(
        height: 40,
        child: Row(
          children: <Widget>[
            Flexible(
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey.shade300,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: RotatedBox(
                quarterTurns: 1,
                child: Image.asset(AppImages.exchangeIcon),
              ),
            ),
            Flexible(
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey.shade300,
              ),
            )
          ],
        ),
      ),
    );
  }
}
