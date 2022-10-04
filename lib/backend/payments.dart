import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../helpers/strings.dart';
import 'call_functions.dart';
import 'mysql/sql_activities.dart';
import 'mysql/user_fxn.dart';

abstract class BasePayment {
  Future<bool> storeTrxnMap(String amount, bool isBuy, String paymentMethod,
      String reference, String toGet, context);

  Future<void> coinbasePayment(String name, String amount);
  Future<void> nowPayment(String coin, String amount);
  Future<void> nowPaymentGetPayStatus(String payId);
  // braintreePayment(
  //     String amount, String displayName, String countryCode, toGet, context);
  // initPaystack();
  // paystackPayment(BuildContext context, String email, double amount, toGet);

  initRazorpay(Function _handlePaymentSuccess, Function _handlePaymentError,
      Function _handleExternalWallet);
  razorpayPayment(double amount, String phone, String email);
  disposeRazorpay();
}

class PaymentRepo implements BasePayment {
  final CallFunctions _callFunctions = CallFunctions();
  // final ActivitiesSql _activitiesSql = ActivitiesSql();
  final UserSql _userSql = UserSql();

  late Razorpay _razorpay;

  // final _paystack = PaystackPlugin();

  var userBox ;
  var settingsBx;
  var crypD ;

  String nowPayUrl = 'https://api.nowpayments.io/v1/payment';

  String currency() {
    return settingsBx.get(CURRENCY) ?? 'usd';
  }

  @override
  Future<bool> storeTrxnMap(String amount, bool isBuy, String paymentMethod,
      String reference, String toGet, context) async {
    try {
      String uid = userBox.get(USER)[USER][UID];

      double exchRate = crypD.get(EX_RATES)[USDT] ?? 0;
      String adminAmount = (double.parse(amount) / exchRate).toStringAsFixed(2);
      Map<String, dynamic> data = {
        UID: uid,
        AMOUNT: amount,
        ADMIN_AMOUNT: adminAmount,
        CURRENCY: currency(),
        PAYMENT_METHOD: paymentMethod,
        REFERENCE: reference,
        TO_GET: toGet,
        TYPE: isBuy ? 0 : 1,
      };
      await _userSql.storeTransaction(data, context);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<Map> coinbasePayment(
    String coin,
    String amount,
  ) async {
    String? coinBaseKey = dotenv.env['COINBASE_KEY'];

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'X-CC-Api-Key': coinBaseKey!,
      'X-CC-Version': '2018-03-22',
    };

    Map<String, dynamic> chargeBody = {
      'name': coin,
      'description': 'Purchase of ${currency()} $amount worth of $coin ',
      'pricing_type': 'fixed_price',
      'local_price': {
        'amount': amount,
        'currency': currency(),
      },
    };
    String url = 'https://api.commerce.coinbase.com/charges';

    http.Response response = await http.post(
      (Uri.parse(url)),
      headers: headers,
      body: jsonEncode(chargeBody),
    );
    var res = jsonDecode(response.body)[DATA];

    Map data = {
      ADDRESS: res[ADDRESSES][coin],
      REFERENCE: res[CODE],
      TIMESTAMP: res[EXPIRES_AT],
      AMOUNT: res[PRICING][coin][AMOUNT],
    };

    return data;
  }

  @override
  Future<Map?> nowPayment(String coin, String amount) async {
    try {
      String ref = randomString(8);
      String? nowPayment = dotenv.env['NOW_PAYMENTS'];

      Map<String, String> headers = {
        'Content-type': 'application/json',
        'x-api-key': nowPayment!,
      };
      Map<String, dynamic> chargeBody = {
        'price_amount': double.parse(amount),
        'price_currency': currency(),
        'pay_currency': coin == BNB ? 'bnbbsc' : coin,
        'order_id': ref,
        'order_description':
            'Purchase of ${currency()} $amount worth of $coin ',
      };

      http.Response response = await http.post(
        (Uri.parse(nowPayUrl)),
        headers: headers,
        body: jsonEncode(chargeBody),
      );
      var res = jsonDecode(response.body);

      Map data = {
        ADDRESS: res['pay_address'],
        PAYMENTID: res['payment_id'],
        AMOUNT: res['pay_amount'],
      };

      return data;
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<Map?> nowPaymentGetPayStatus(String payId) async {
    try {
      String? nowPayment = dotenv.env['NOW_PAYMENTS'];

      Map<String, String> headers = {
        'Content-type': 'application/json',
        'x-api-key': nowPayment!,
      };
      http.Response response = await http.get(
        (Uri.parse(nowPayUrl)),
        headers: headers,
      );
      var res = jsonDecode(response.body);

      Map data = {
        PAYMENT_STATUS: res['payment_status'],
        AMOUNT_PAID: res['actually_paid'],
        REFERENCE: res['order_id'],
        TRXN_HASH: res['payin_hash'],
        PAYMENTID: res['payment_id'],
        UPDATED_AT: res['updated_at'],
      };

      return data;
    } catch (e) {
      print(e);
    }
  }

  // @override
  // braintreePayment(String amount, String displayName, String countryCode, toGet,
  //     context) async {
  //   try {
  //     var request = BraintreeDropInRequest(
  //       tokenizationKey: dotenv.env['BRAINTREE_TOKENIZATION_KEY'],
  //       collectDeviceData: true,
  //       amount: amount,
  //       applePayRequest: BraintreeApplePayRequest(
  //         currencyCode: currency(),
  //         // amount: double.parse(amount),
  //         countryCode: currency(),
  //         appleMerchantID: dotenv.env['BRAINTREE_APPLE_MERCHANT_ID']!,
  //         displayName: displayName, paymentSummaryItems: [],
  //       ),
  //       googlePaymentRequest: BraintreeGooglePaymentRequest(
  //         totalPrice: amount,
  //         currencyCode: currency(),
  //         billingAddressRequired: false,
  //         googleMerchantID: dotenv.env['BRAINTREE_GOOGLE_MERCHANT_ID'],
  //       ),
  //       paypalRequest: BraintreePayPalRequest(
  //         amount: amount,
  //         displayName: displayName,
  //         currencyCode: currency(),
  //       ),
  //       cardEnabled: true,
  //     );
  //     final result = await BraintreeDropIn.start(request);
  //     if (result != null) {
  //       String nounce = result.paymentMethodNonce.nonce;

  //       //
  //       await _activitiesSql.storeUserActivitiesSql(4);

  //       //Store Trxn

  //       await storeTrxnMap(amount, true, 'Braintree',
  //           result.paymentMethodNonce.nonce, toGet, context);

  //       //
  //       _callFunctions.showPopUp(
  //         context,
  //         TrnsText(title: 'Payment sent', extra2: nounce),
  //         [
  //           CupertinoButton(
  //             child: const TrnsText(title: 'Ok'),
  //             onPressed: () => Navigator.pop(context),
  //           ),
  //         ],
  //         [
  //           TextButton(
  //             child: const TrnsText(title: 'Ok'),
  //             onPressed: () => Navigator.pop(context),
  //           ),
  //         ],
  //       );
  //     } else {
  //       _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // @override
  // void initPaystack() {
  //   _paystack.initialize(publicKey: dotenv.env['PAYSTACK_P_KEY']!);
  // }

  // @override
  // paystackPayment(
  //     BuildContext context, String email, double amount, toGet) async {
  //   String message = '';
  //   try {
  //     String? _accessCode = await _getAccessCode(amount, email, context);

  //     if (_accessCode != null) {
  //       Charge charge = Charge()
  //         ..amount = (amount * 100).toInt()
  //         ..accessCode = _accessCode
  //         ..email = email
  //         ..currency = currency().toUpperCase();

  //       CheckoutResponse response = await _paystack.checkout(
  //         context,
  //         method: CheckoutMethod.selectable,
  //         charge: charge,
  //       );

  //       if (response.status) {
  //         message = 'Charge was successful. Ref: ${response.reference}';
  //         await _activitiesSql.storeUserActivitiesSql(4);

  //         //Store Trxn

  //         await storeTrxnMap(amount.toStringAsFixed(2), true, 'Braintree',
  //             response.reference!, toGet, context);

  //         _callFunctions.showPopUp(context, Text(message), [
  //           CupertinoButton(
  //             child: const TrnsText(title: 'Ok'),
  //             onPressed: () => Navigator.pop(context),
  //           ),
  //         ], [
  //           TextButton(
  //             child: const TrnsText(title: 'Ok'),
  //             onPressed: () => Navigator.pop(context),
  //           ),
  //         ]);
  //       } else {
  //         _callFunctions.showSnacky('Failed:', false, context,
  //             extra2: response.message);
  //       }
  //     } else {
  //       _callFunctions.showSnacky('Payment Error', false, context);
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // _getAccessCode(double amount, String email, context) async {
  //   String? paystackkey = dotenv.env['PAYSTACK_S_KEY'];

  //   Map<String, String> headers = {
  //     'Content-type': 'application/json',
  //     'Authorization': 'Bearer $paystackkey'
  //   };

  //   if (currency() == NGN) {
  //     try {
  //       String url = 'https://api.paystack.co/transaction/initialize';
  //       Map data = {
  //         'email': email,
  //         'amount': '${amount * 100}',
  //         'currency': currency().toUpperCase(),
  //         'channels': [
  //           'card',
  //           'bank',
  //           'ussd',
  //           'qr',
  //           'mobile_money',
  //           'bank_transfer'
  //         ]
  //       };
  //       http.Response response = await http.post(
  //         Uri.parse(url),
  //         headers: headers,
  //         body: jsonEncode(data),
  //       );
  //       var body = jsonDecode(response.body);

  //       return body[DATA]['access_code'];
  //     } catch (e) {
  //       print(e);
  //     }
  //   } else {
  //     _callFunctions.showSnacky(
  //       'Unsupported Currency Type',
  //       false,
  //       context,
  //       extra2: currency().toUpperCase(),
  //     );
  //   }
  // }

  @override
  razorpayPayment(double amount, String phone, String email) {
    var options = {
      'key': dotenv.env['RAZOR_PAY_KEY'],
      'amount': (amount * 100).toInt(),
      'currency': currency().toUpperCase(),
      'name': APP_NAME,
      'description': 'Purchase of Coin from ' + COMPANY_NAME,
      'prefill': {
        'contact': '07069486764',
        'email': email,
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  @override
  initRazorpay(Function _handlePaymentSuccess, Function _handlePaymentError,
      Function _handleExternalWallet) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  disposeRazorpay() {
    _razorpay.clear();
  }
}
