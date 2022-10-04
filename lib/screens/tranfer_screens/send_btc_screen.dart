import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../backend/all_backends.dart';
import '../../backend/encrypt.dart';
import '../../helpers/app_config.dart';
import '../../models/coin_market_place/coin.dart';
import '../../widget/custom_widgets/custom_textformfield.dart';

class SendBTCScreen extends StatefulWidget {
  const SendBTCScreen(
      {required this.coin, required this.transactionPossible, Key? key})
      : super(key: key);
  final Coin coin;
  final bool transactionPossible;
  @override
  State<SendBTCScreen> createState() => _SendBTCScreenState();
}

class _SendBTCScreenState extends State<SendBTCScreen> {
  final TextEditingController _amount = TextEditingController(text: '0');
  final TextEditingController _address = TextEditingController();
  final GlobalKey<State<StatefulWidget>> qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;
  bool isScanning = false;
  bool isLoading = false;
  AllBackEnds allBackEnds = AllBackEnds();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  EncryptApp encryptApp = EncryptApp();
  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     qrController!.pauseCamera();
  //   } else if (Platform.isIOS) {
  //     qrController!.resumeCamera();
  //   }
  // }

  String? walletId;
  String? transferKey;
  String? address;

  String? gas;
  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    qrController = controller;
    controller.scannedDataStream.listen((Barcode scanData) {
      _address.text = scanData.code ?? '';
      isScanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.transactionPossible);
    double coinBalance = widget.coin.currentPrice! * totalBalance;
    if (widget.transactionPossible) {
      walletId = encryptApp
          .appDecrypt(walletAddMap['${widget.coin.symbol}_wallet_id']);
      transferKey = encryptApp
          .appDecrypt(walletAddMap['${widget.coin.symbol}_transfer_key']);
      address =
          encryptApp.appDecrypt(walletAddMap['${widget.coin.symbol}_address']);
    }
    return Scaffold(
      appBar: AppBar(title: Text('SEND ${widget.coin.symbol!.toUpperCase()}')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: widget.transactionPossible
              ? Form(
                  key: _fromKey,
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          height: 80,
                          width: 80,
                          child: ExtendedImage.network(widget.coin.image!,
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Enter Amount',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        controller: _amount,
                        textAlign: TextAlign.center,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        style: const TextStyle(
                          color: Colors.yellow,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        // validator: (String? value) =>
                        //     exchangePro.fromValidator(value),
                        // onChanged: (String? value) async {
                        //   if (value == null ||
                        //       value.isEmpty ||
                        //       _address.text.trim().isEmpty) return;
                        //   final Map<String, dynamic>? result =
                        //       await CoinsAPI().coinTranfer(
                        //     amount: double.parse(value),
                        //     toAddress: _address.text.trim(),
                        //     coinName: widget.coin.symbol!.toUpperCase(),
                        //     contractAddress:
                        //         swapableCoin[index].contractAddress,
                        //     getFee: true,
                        //   );
                        //   print(result);
                        // },
                        decoration: const InputDecoration(
                          fillColor: Colors.yellow,
                          border: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Coin Balance: \$ $coinBalance',
                      ),
                      const SizedBox(height: 10),
                      isScanning
                          ? SizedBox(
                              height: 300,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: QRView(
                                      key: qrKey,
                                      overlay: QrScannerOverlayShape(),
                                      onQRViewCreated: _onQRViewCreated,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => setState(() {
                                      isScanning = false;
                                    }),
                                    child: const Text('Stop Scannig'),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(height: 20),
                      const SizedBox(height: 10),
                      const Text(
                        'Advanced',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Center(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: CustomTextFormField(
                                  controller: _address,
                                  maxLines: 5,
                                  validator: (String? value) => value!.isEmpty
                                      ? 'Enter the receiving address here'
                                      : null,
                                  border: InputBorder.none,
                                  onChanged: (p0) async {
                                    gas = await allBackEnds.getFee(walletId!,
                                        _address.text, _amount.text, context);
                                    setState(() {});
                                  },
                                  hint: 'Tap to paste address...',
                                ),
                              ),
                              IconButton(
                                splashRadius: 16,
                                onPressed: () {
                                  setState(() {
                                    isScanning = true;
                                  });
                                },
                                icon: const Icon(Icons.qr_code),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () async {
                          if (_fromKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            print(walletId);
                            print(address);
                            print(transferKey);
                            await allBackEnds.transferCoin(
                              walletId!,
                              transferKey!,
                              _address.text,
                              _amount.text.trim(),
                            );

                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        child: const Text(
                          'Send',
                          style: TextStyle(fontSize: 32),
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: Text(
                    'Transaction Not Possible',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
          //  FutureBuilder<List<SwapableCoin>>(
          //     future: ExchangeAPI().swapableCoins(),
          //     builder: (BuildContext context,
          //         AsyncSnapshot<List<SwapableCoin>> snapshot) {
          //       log(LocalData.privateKey().toString());
          //       if (snapshot.hasError) {
          //         return Text(snapshot.error.toString());
          //       } else if (snapshot.hasData) {
          //         final List<SwapableCoin> swapableCoin =
          //             snapshot.data ?? <SwapableCoin>[];
          //         final int index = swapableCoin.indexWhere(
          //           (SwapableCoin element) =>
          //               element.symbol == widget.coin.symbol!.toUpperCase(),
          //         );
          //         if (index >= 0) {
          //           log(swapableCoin[index].symbol.toString());
          //           log(swapableCoin[index].contractAddress.toString());
          //         }
          //         return
          //             //  index < 0
          //             //     ? const Center(child: Text('Transation not possible'))
          //             //     :
          //             Consumer<ExchangeCoinProvider>(builder: (
          //           BuildContext context,
          //           ExchangeCoinProvider exchangePro,
          //           _,
          //         ) {
          //           return });
          //       } else {
          //         return const ShowLoading();
          //       }
          //     }),
        ),
      ),
    );
  }
}
