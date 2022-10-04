import 'package:flutter/material.dart';

import '../../models/swapable_coin.dart';

class CoinTextFormField extends StatefulWidget {
  const CoinTextFormField({
    required this.coinsList,
    required this.onCoinSelection,
    required this.selectedCoin,
    required this.onChanged,
    required this.controller,
    required this.validator,
    Key? key,
  }) : super(key: key);
  final List<SwapableCoin> coinsList;
  final void Function(SwapableCoin?)? onCoinSelection;
  final String? Function(String? value)? validator;
  final void Function(String)? onChanged;
  final SwapableCoin? selectedCoin;
  final TextEditingController controller;

  @override
  State<CoinTextFormField> createState() => _CoinTextFormFieldState();
}

class _CoinTextFormFieldState extends State<CoinTextFormField> {
  void _onListen() => setState(() {});
  @override
  void initState() {
    widget.controller.addListener(_onListen);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              validator: (String? value) => widget.validator!(value),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onChanged: widget.onChanged,
              decoration: const InputDecoration(
                hintText: '0',
                prefix: Text('\$'),
                border: InputBorder.none,
              ),
            ),
          ),
          DropdownButton<SwapableCoin>(
            value: widget.selectedCoin,
            style: const TextStyle(color: Colors.black),
            underline: const SizedBox(),
            hint: const Text(
              'Select coin',
              style: TextStyle(color: Colors.black),
            ),
            items: widget.coinsList
                .map((SwapableCoin coin) => DropdownMenuItem<SwapableCoin>(
                      value: coin,
                      child: Text(
                        coin.symbol.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ))
                .toList(),
            onChanged: widget.onCoinSelection,
          ),
        ],
      ),
    );
  }
}
