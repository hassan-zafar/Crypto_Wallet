// ignore_for_file: constant_identifier_names

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const String APP_NAME = 'WUU Walet';
const String COMPANY_NAME = 'WUU Inc';

const String ID = 'id';
const String NAME = 'name';
const String IMAGE = 'image';
const String IMAGE_NAME = 'image_name';
const String SYMBOL = 'symbol';
const String CURRENT_PRICE = 'current_price';
const String PRICE_CHANGE_PERCENTAGE_24H = 'price_change_percentage_24h';
const String SPARKLINE_IN_7D = 'sparkline_in_7d';
const String SPOTS = 'spots';
const String PRICE = 'price';

const String BALANCES = 'balances';
const String EX_RATES = 'exRates';

//! RefBonus in USD (will multiply accordingly with exchange rate);
const double REFBONUS = 10.0;

const String BITCOIN = 'bitcoin';
const String ETHEREUM = 'ethereum';
const String BINANCE = 'binancecoin';
const String DOGECOIN = 'dogecoin';
const String LITECOIN = 'litecoin';
const String BITCOINCASH = 'bitcoin-cash';

const String BTC = 'btc';
const String ETH = 'eth';
const String BNB = 'bnb';
const String DOGE = 'doge';
const String BCH = 'bch';
const String LTC = 'ltc';
const String USDT = 'usdt';

const String ERC20 = 'erc20';
const String WALLETS = 'wallets';
const String ADDRESS = 'address';
const String ADDRESSES = 'addresses';
const String BTCADDRESS = 'btcAddress';
const String ETHADDRESS = 'ethAddress';
const String DOGEADDRESS = 'dogeAddress';

const String TRANSFERKEY = 'transfer_key';
const String WALLETID = 'wallet_id';
const String WALLET = 'wallet';
const String AVAILABLE = 'available';
const String TOTAL = 'total';
const String DESTINATIONS = 'destinations';
const String NOTIFICATION = 'notification';
const String MESSAGE = 'message';
const String ITEMS = 'items';
const String DATE = 'date';

const String ETH_URL = 'https://api.etherscan.io';
const String BSC_URL = 'https://api.bscscan.com';
const String BTC_EXPLORER = 'https://www.blockchain.com/btc/tx/';
const String ETH_EXPLORER = 'https://etherscan.io/tx/';
const String BNB_EXPLORER = 'https://bscscan.com/tx/';
const String DOGE_EXPLORER = 'https://dogechain.info/tx/';

const List CRYPTOCURRENCIES = [
  BITCOIN,
  ETHEREUM,
  // BINANCE,
  LITECOIN,
  BITCOINCASH,
  DOGECOIN,
];
const List UNITS = [
  BTC,
  ETH,
  BNB,
  DOGE,
  LTC,
];

const List ERC20LIST = [
  ETH,
  BNB,
];

const String USD = 'usd';
const String EUR = 'eur';
const String RUB = 'rub';
const String AUD = 'aud';
const String INR = 'inr';
const String NGN = 'ngn';
const String CNY = 'cny';
const String JPY = 'jpy';
const String IDR = 'idr';

const List CURRENCIES = [
  USD,
  EUR,
  RUB,
  AUD,
  INR,
  NGN,
  CNY,
  JPY,
  IDR,
];

const String ENGLISH = 'english';
const String FRENCH = 'french';
const String JAPANESE = 'japanese';
const String CHINESE = 'chinese';
const String HINDI = 'hindi';
const String RUSSIAN = 'russian';
const String KOREAN = 'korean';
const String BELGIUM = 'belgium';
const String GERMAN = 'german';
const String SPANISH = 'spanish';
const String PORTUGUESE = 'portuguese';
const String INDONESIAN = 'indonesian';
const String ARABIC = 'arabic';

const List<String> LANGUAGE_CODES = [
  'ar',
  'de',
  'en',
  'es',
  'fr',
  'hi',
  'id',
  'ja',
  'ko',
  'nl',
  'pt',
  'ru',
  'zh',
];

const List<String?> LANGUAGES = [
  ARABIC,
  GERMAN,
  ENGLISH,
  SPANISH,
  FRENCH,
  HINDI,
  INDONESIAN,
  JAPANESE,
  KOREAN,
  BELGIUM,
  PORTUGUESE,
  RUSSIAN,
  CHINESE,
];

const String PAYSTACK = 'Paystack';
const String RAZOR_PAY = 'RazorPay';
const String PAYPAL = 'Paypal';

const List<String> PAYMENT_METHODS = [
  PAYSTACK,
  RAZOR_PAY,
  PAYPAL,
  BANK,
];

const Map<String?, Map<String?, String?>> PAYMENT_MAP = {
  PAYSTACK: {
    IMAGE: 'assets/images/paystack.png',
  },
  RAZOR_PAY: {
    IMAGE: 'assets/images/razorpay.png',
  },
  PAYPAL: {
    IMAGE: 'assets/images/paypal.png',
  },
  BANK: {
    IMAGE: 'assets/images/bank.png',
  },
};

const List<String> PAYOUT_METHODS = [
  BANK,
  PAYPAL,
  PAYONEER,
];

const Map<String?, Map<String?, String?>> PAYOUT_MAP = {
  BANK: {
    IMAGE: 'assets/images/bank.png',
  },
  PAYPAL: {
    IMAGE: 'assets/images/paypal.png',
  },
  PAYONEER: {
    IMAGE: 'assets/images/payoneer.png',
  },
};

const List ACTIVITY_MAP = [
  {
    TYPE: 0,
    ACTIVITY: LOGIN,
    MESSAGE: 'New Login to account',
  },
  {
    TYPE: 1,
    ACTIVITY: REGISTER,
    MESSAGE: 'Registered an account',
  },
  {
    TYPE: 2,
    ACTIVITY: FORGET_PASS,
    MESSAGE: 'Requested a password reset',
  },
  {
    TYPE: 3,
    ACTIVITY: CHANGE_PASS,
    MESSAGE: 'Changed your password',
  },
  {
    TYPE: 4,
    ACTIVITY: SWAP,
    MESSAGE: 'Swapped some coins',
  },
  {
    TYPE: 5,
    ACTIVITY: BUY,
    MESSAGE: 'Purchased some coins',
  },
  {
    TYPE: 6,
    ACTIVITY: SELL,
    MESSAGE: 'Sold some coins',
  },
  {
    TYPE: 7,
    ACTIVITY: SEND,
    MESSAGE: 'Sent some coins',
  },
  {
    TYPE: 8,
    ACTIVITY: RECEIVE,
    MESSAGE: 'Received some coins',
  },
  {
    TYPE: 9,
    ACTIVITY: DISABLE,
    MESSAGE: 'You have disabled your account',
  },
  {
    TYPE: 10,
    ACTIVITY: ENABLE,
    MESSAGE: 'You have enabled your account',
  },
  {
    TYPE: 11,
    ACTIVITY: UPDATE,
    MESSAGE: 'You have updated your account',
  },
  {
    TYPE: 12,
    ACTIVITY: REQUEST,
    MESSAGE: 'You have requested for referral payout',
  },
];

List<FlSpot> defaultSpark = [
  FlSpot(1.0, 46472.897998044195),
  FlSpot(2.0, 46662.46215816087),
  FlSpot(3.0, 47028.076433708644),
  FlSpot(4.0, 47121.06246521769),
  FlSpot(5.0, 47084.74403976415),
  FlSpot(6.0, 47299.9215486446),
  FlSpot(7.0, 46965.17806527827),
  FlSpot(8.0, 46704.30601005894),
  FlSpot(9.0, 46738.78980221296),
  FlSpot(10.0, 46421.951512502914),
  FlSpot(11.0, 46558.6155768435),
  FlSpot(12.0, 46632.204099543065),
  FlSpot(13.0, 46514.6448955016),
  FlSpot(14.0, 46806.57355652654),
  FlSpot(15.0, 47128.00342748428),
  FlSpot(16.0, 46869.31500189539),
  FlSpot(17.0, 46783.178748500046),
  FlSpot(18.0, 46807.18639553805),
  FlSpot(19.0, 46881.53103760189),
  FlSpot(20.0, 46581.248266822884),
  FlSpot(21.0, 46382.55602736656),
];

const String PASSPORT = 'passport';
const String DRIVERS_LICENSE = 'drivers_license';
const String NATIONAL_ID = 'national_id';
const String ID_TYPE = 'id_type';
const String ID_NO = 'id_no';

const List<String> TYPE_ID = [
  PASSPORT,
  DRIVERS_LICENSE,
  NATIONAL_ID,
];

const String AMOUNT = 'amount';
const String ADMIN_AMOUNT = 'admin_amount';
const String TOKEN = 'token';
const String CONTRACTADD = 'contractAddress';
const String TYPE = 'type';
const String INCOME = 'income';
const String TITLE = 'title';
const String BODY = 'body';
const String UNIT = 'unit';
const String VALUE = 'value';
const String TIMESTAMP = 'timeStamp';
const String EXPIRES_AT = 'expires_at';
const String CREATED_AT = 'created_at';
const String UPDATED_AT = 'updated_at';
const String TRXN_HASH = 'payin_hash';
const String CODE = 'code';
const String EMAIL_OTP = 'otp';
const String OTPS = 'otps';
const String REFERENCE = 'reference';
const String TO_GET = 'to_get';
const String PAYMENTID = 'actually_paid';
const String AMOUNT_PAID = 'payment_id';
const String PAYMENT_STATUS = 'payment_status';
const String PAYMENT_METHOD = 'payment_method';
const String STATUS = 'status';
const String TO = 'to';
const String FROM = 'from';
const String DATA = 'data';
const String GAS_FEE = 'gasFee';
const String HASH = 'hash';
const String RESULT = 'result';
const String BOUGHT = 'bought';
const String SOLD = 'sold';
const String PRICING = 'pricing';

const String TRANSACTIONS = 'transactions';
const String ACTIVITY = 'activity';
const String ACTIVITIES = 'activities';
const String DEVICE_ACTIVITIES = 'deviceActivities';

const String LOGIN = 'login';
const String REGISTER = 'register';
const String UPDATE = 'update';
const String DELETE = 'delete';
const String DISABLE = 'disable';
const String ENABLE = 'enable';
const String FORGET_PASS = 'forget password';
const String CHANGE_PASS = 'change password';
const String SWAP = 'swap';
const String BUY = 'buy';
const String SELL = 'sell';
const String SEND = 'send';
const String RECEIVE = 'receive';
const String REQUEST = 'request';

const String CATEGORY = 'category';
const String DATETIME = 'datetime';
const String HEADLINE = 'headline';
const String SOURCE = 'source';
const String URL = 'url';
const String SUMMARY = 'summary';

const String ALL_CRYPTO_DATAS = 'allcCryptoDatas';
const String CRYPTO_DATAS = 'cryptoDatas';
const String ALL_COINS_LIST = 'allCoinsList';
const String MAX_MIN_LIST = 'maxMinList';
const String MIN_LIST = 'minList';

String? infura = dotenv.env['INFURA_PROJECT_ID'];

String eTHRPCURL = 'https://mainnet.infura.io/v3/$infura';
const String BSC_RPC_URL = 'https://bsc-dataseed.binance.org/';
const String BSC_TEST_RPC_URL =
    'https://data-seed-prebsc-1-s1.binance.org:8545/';

const String USERS = 'users';
const String ADMINS = 'admins';

const String UID = 'uid';
const String USER = 'user';
const String FIRST_NAME = 'firstName';
const String LAST_NAME = 'lastName';
const String EMAIL = 'email';
const String PASSWORD = 'password';
const String NEW_PASSWORD = 'newPassword';
const String PROFILEPIC = 'profilePic';
const String COUNTRY = 'country';
const String CITY = 'city';
const String STATE = 'state';
const String COUNTRIES = 'countries';
const String PHONE = 'phone';
const String REFBALANCE = 'refBalance';
const String DATECREATED = 'dateCreated';
const String DOB = 'dob';
const String TWOFA = 'twoFa';
const String REFERREDBY = 'referredBy';
const String REFCODE = 'refCode';
const String REFCONFIRMCOUNT = 'refConfirmCount';
const String REFUNCONFIRMCOUNT = 'refUnconfirmCount';
const String CONFI = 'confi';
const String REFERCOUNT = 'referCount';
const String ISADMIN = 'isAdmin';
const String BLOCKED = 'blocked';
const String DISABLED = 'disabled';
const String DISABLE_END_DATE = 'disableEndDate';
const String VERIFIED = 'verified';
const String SESSION_END = 'session_end';
const String IDENTIFIED = 'identified';
const String UNVERIFIED = 'unverified';

// Bank
const String FINANCIAL = 'financial';

const String BANK = 'bank';
const String BANKNAME = 'bankName';
const String BANKCOUNTRY = 'bankCountry';
const String BANKSORTCODE = 'bankSortCode';
const String ACCOUNTNUMBER = 'accNum';
const String ACCOUNTNAME = 'accName';

//PayPal
const String PAYPALEMAIL = 'payPalEmail';

//Payoneer
const String PAYONEER = 'payoneer';
const String PAYONEERBANKNAME = 'payoneerBankName';
const String PAYONEERBANKCOUNTRY = 'payoneerBankCountry';
const String PAYONEERROUTINGBANKSORTCODE = 'payoneerRoutingBankSortCode';
const String PAYONEERACCOUNTNUMBER = 'payoneerAccNum';
const String PAYONEERACCOUNTTYPE = 'payoneerAccType';
const String PAYONEERBENEFICIARYNAME = 'payoneerBenficiaryName';

const String COMPLETED = 'completed';
const String PENDING = 'pending';
const String FAILED = 'failed';
const String SUCCESS = 'success';

const String CONFIRMED = 'confirmed';
const String UNCONFIRMED = 'unConfirmed';

const String DEVICENAME = 'deviceName';
const String IP = 'ip';
const String LOCATION = 'location';

const String SETTINGS = 'settings';
const String THEME = 'theme';
const String PASSCODE = 'passcode';
const String BIOMETRICS = 'biometrics';
const String APP_LOCK = 'appLock';
const String HAS_2FA = 'has_2fa';
const String PRIVACY_MODE = 'privacy';
const String TRXN_SIGNING = 'trxn';
const String LANGUAGE = 'language';
const String CURRENCY = 'currency';
const String RATE = 'rate';
const String DEFAULT_ERROR = 'Something went wrong';

const String HEXCHARS = 'abcdef0123456789';

String hexString(int strlen) {
  Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
  String result = '';
  for (int i = 0; i < strlen; i++) {
    result += HEXCHARS[rnd.nextInt(HEXCHARS.length)];
  }
  return result;
}

const String CHARS = 'abcdefghijklmnopqrstuvwxyz0123456789';

const String EMAIL_REGEX =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

String randomString(int strlen) {
  Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
  String result = '';
  for (int i = 0; i < strlen; i++) {
    result += CHARS[rnd.nextInt(CHARS.length)];
  }
  return result;
}

extension StringExtension on String? {
  String? capitalize() {
    return "${this![0].toUpperCase()}${this!.substring(1)}";
  }
}

const String FACE = 'Face';
const String TOUCHID = 'TouchId';
const String VERSION = 'version';

const String FLASHON = 'flashOn';
const String FRONTCAMERA = 'frontCamera';
const String FLASHOFF = 'flashOff';
const String BACKCAMERA = 'backCamera';

const String GOOGLE = 'google';
const String FACEBOOK = 'Facebook';
const String INSTAGRAM = 'Instagram';
const String TWITTER = 'Twitter';
const String TELEGRAM = 'Telegram';
const String REDDIT = 'Reddit';
const String YOUTUBE = 'Youtube';
const String MEDIUM = 'Medium';
