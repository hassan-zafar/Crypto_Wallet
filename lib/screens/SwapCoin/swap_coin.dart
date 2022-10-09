import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../backend/all_backends.dart';
import '../../helpers/app_config.dart';
import '../../helpers/colors.dart';
import '../../helpers/strings.dart';
import '../../widget/swap/cust_button.dart';
import '../../widget/swap/cust_container.dart';
import '../../widget/swap/cust_prog_ind.dart';
import '../../widget/swap/k_header.dart';
import '../../widget/swap/large_text.dart';
import '../../widget/trns_text.dart';

class SwapScreen extends StatefulWidget {
  const SwapScreen({Key? key}) : super(key: key);

  @override
  _SwapScreenState createState() => _SwapScreenState();
}

String currency() {
  return 'usd';
}

AllBackEnds _allBackEnds = AllBackEnds();
String? _amount = '0.0';
double _estimate = 0.0;

bool _loading = false;

class _SwapScreenState extends State<SwapScreen> {
  bool boolFrom = false;

  int _fromInd = 0;
  String _fromValue = BITCOIN;
  int _toInd = 1;
  String _toValue = ETHEREUM;

  String _from = BTC;
  String _to = ETH;

  final TextEditingController _swapCtrl = TextEditingController()..text = '0';

  Map balances =walletAddMap ;

  bool _isLoading = false;
  String? errorMsg = '';

  @override
  Widget build(BuildContext context) {
    Size med = MediaQuery.of(context).size;

    return KHeader(
      title: const ['Swap {Arg}'],
      args: const {'Arg': ''},
      isLoading: _isLoading,
      body: SizedBox(
        height: med.height,
        child: Column(
          children: [
            CustContainer(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SwapWid1(
                      onTap: () => getCurrency(true),
                      from: true,
                      svg: Platform.isIOS
                          ? CRYPTOCURRENCIES[_fromInd]
                          : _fromValue,
                      title: getUnit(_fromValue, _fromInd, true),
                    ),
                    const VerticalDivider(
                      color: Colors.black,
                      thickness: 2,
                      endIndent: 10,
                      indent: 10,
                    ),
                    SwapWid1(
                      onTap: () => getCurrency(false),
                      from: false,
                      svg: Platform.isIOS ? CRYPTOCURRENCIES[_toInd] : _toValue,
                      title: getUnit(_toValue, _toInd, false),
                    ),
                  ],
                ),
              ),
            ),
            LargeTextField(
              controller: _swapCtrl,
              suffixTap: suffixTap,
              onChanged: (String val) {
                setState(() {
                  _amount = val != '' ? val : '0.0';
                  numValidate(_amount);
                  estimateFxn(_amount);
                });
              },
              prefix: InkWell(
                onTap: () {
                  setState(() {
                    boolFrom = !boolFrom;
                  });
                },
                child: Text(boolFrom ? _from : currency().toUpperCase()),
              ),
            ),
            Text(
              errorMsg!,
              style: const TextStyle(
                color: red,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SwapTextWid(
                    value: outgoingAmount(),
                    unit: _from,
                    outgoing: true,
                  ),
                  VerticalDivider(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(0.5),
                    thickness: 2,
                    endIndent: 10,
                    indent: 10,
                  ),
                  _loading
                      ? const CustProgIndicator()
                      : SwapTextWid(
                          value: _estimate,
                          unit: _to,
                          outgoing: false,
                        ),
                ],
              ),
            ),
            CustButton(
              onTap: swapFxn,
              title: 'Swap {Arg}',
              args: const {'Arg': ''},
            )
          ],
        ),
      ),
    );
  }

//! Functions /////
  String getFromToUnit(val, ind) {
    return Platform.isAndroid
        ? UNITS[CRYPTOCURRENCIES.indexOf(val)]
        : UNITS[ind];
  }

  String getUnit(val, ind, bool from) {
    if (from) {
      _from = getFromToUnit(val, ind).toUpperCase();
      return _from;
    } else {
      _to = getFromToUnit(val, ind).toUpperCase();
      return _to;
    }
  }

  String getBalance() {
    String fromUnit = getFromToUnit(_fromValue, _fromInd);
    return boolFrom
        ? balances[fromUnit].toStringAsFixed(4)
        : (balances[fromUnit] * [1, 1.5, 2]).toStringAsFixed(2);
  }

  suffixTap() {
    setState(() {
      _swapCtrl.text = getBalance();
      estimateFxn(_swapCtrl.text);
    });
  }

  getCurrency(isFrom) {
    _allBackEnds.showPicker(
      context,
      children: CRYPTOCURRENCIES,
      onChanged: (String? val) {
        if (isFrom) {
          setState(() {
            _fromValue = val!;
          });
        } else {
          setState(() {
            _toValue = val!;
          });
        }
        Navigator.pop(context);
      },
      onSelectedItemChanged: (int? index) {
        if (isFrom) {
          setState(() {
            _fromInd = index!;
          });
        } else
          setState(() {
            _toInd = index!;
          });
      },
      hasTrns: false,
    );
  }

  double outgoingAmount() {
    double? newVal = _amount == null || _amount == '' || _amount == '.'
        ? 0
        : boolFrom
            ? double.tryParse(_amount!)
            : (double.tryParse(_amount!)! / 2);
    return newVal!;
  }

  estimateFxn(String? amount) async {
    try {
      if (amount != null || amount != '' || amount != '.') {
        if (double.parse(amount!) > 0.0) {
          setState(() {
            _loading = true;
          });
          String newAmount =
              (boolFrom ? double.parse(amount) : double.parse(amount) / 2)
                  .toString();
          _estimate = await _allBackEnds.getEstimate(
              _from.toLowerCase(), _to.toLowerCase(), newAmount);

          setState(() {
            _loading = false;
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  String? numValidate(amount) {
    errorMsg = _allBackEnds.validateAmount(
        true,
        amount,
        double.parse(getBalance()),
        boolFrom ? (1 * 0.001) : (1 * 10),
        boolFrom ? (1 * 100000) : (1 * 100000000),
        context,
        notNull: true);
    return errorMsg;
  }

  swapFxn() async {
    if (errorMsg == '') {
      setState(() {
        _isLoading = true;
      });

      try {
        //!
        String from = getFromToUnit(_fromValue, _fromInd) == ETH ||
                getFromToUnit(_fromValue, _fromInd) == BNB ||
                getFromToUnit(_fromValue, _fromInd) == USDT
            ? ERC20
            : getFromToUnit(_fromValue, _fromInd);

        var encryptedWallet = walletAddMap['btc_wallet_id'];
        String tKey = _allBackEnds.decrypt(encryptedWallet);

        Map swapDetails = await _allBackEnds.swapCoin(
            getFromToUnit(_fromValue, _fromInd),
            getFromToUnit(_toValue, _toInd),
            outgoingAmount().toString());

        if (from != ERC20) {
          var encryptedWallet = walletAddMap['btc_wallet_id'];

          String walletData = _allBackEnds.decrypt(encryptedWallet);
          await _allBackEnds
              .transferCoin(walletData, tKey, swapDetails[ADDRESS],
                  outgoingAmount().toString())
              .then((Map value) {
            if (!value[STATUS]) {
              failedMsg();
            } else {
              successMsg();
            }
          });
        } else {
          bool isEth =
              getFromToUnit(_fromValue, _fromInd) == ETH ? true : false;

          await _allBackEnds.clientsInit(getFromToUnit(_fromValue, _fromInd));

          await _allBackEnds
              .transferEthBnbToken(
                  tKey, swapDetails[ADDRESS], outgoingAmount(), isEth)
              .then((Map value) {
            if (value[STATUS] == false) {
              failedMsg();
            } else {
              successMsg();
            }
          });
        }
      } catch (e) {
        print(e);
        failedMsg();
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  successMsg() {
    _allBackEnds.showPopUp(
        context, const TrnsText(title: 'Swap Request Sent Successfully'), [
      CupertinoButton(
        child: const TrnsText(title: 'Ok'),
        onPressed: () {
          Navigator.pop(context);
          _swapCtrl.clear();
        },
      ),
    ], [
      TextButton(
        child: const TrnsText(title: 'Ok'),
        onPressed: () {
          Navigator.pop(context);
          _swapCtrl.clear();
        },
      ),
    ]);
  }

  failedMsg() {
    _allBackEnds
        .showPopUp(context, const TrnsText(title: 'Swap Request failed'), [
      CupertinoButton(
        child: const TrnsText(
          title: 'Ok',
        ),
        onPressed: () {
          Navigator.pop(context);
          _swapCtrl.text = '0.0';
        },
      ),
    ], [
      TextButton(
        child: const TrnsText(
          title: 'Ok',
        ),
        onPressed: () {
          Navigator.pop(context);
          _swapCtrl.text = '0.0';
        },
      ),
    ]);
  }
}

class SwapTextWid extends StatelessWidget {
  const SwapTextWid({
    required this.outgoing,
    required this.unit,
    required this.value,
    Key? key,
  }) : super(key: key);

  final double value;
  final String unit;
  final bool outgoing;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        "${outgoing ? "-" : "+"}${value.toStringAsFixed(4)} " + '$unit',
        style: TextStyle(
          fontSize: 18,
          color: outgoing
              ? Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5)
              : Theme.of(context).textTheme.bodyText1!.color,
        ),
      ),
    );
  }
}

class SwapWid1 extends StatelessWidget {
  const SwapWid1({
    Key? key,
    required this.from,
    required this.onTap,
    required this.svg,
    required this.title,
  }) : super(key: key);

  final void Function() onTap;
  final String svg;
  final String title;
  final bool from;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: transparent,
      highlightColor: transparent,
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            child: SvgPicture.asset('assets/svg/$svg.svg'),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TrnsText(
                title: from ? 'From' : 'To',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .color!
                      .withOpacity(0.5),
                ),
              ),
              Text(title),
            ],
          ),
          const SizedBox(width: 20),
          const Icon(CupertinoIcons.chevron_down, size: 18)
        ],
      ),
    );
  }
}
