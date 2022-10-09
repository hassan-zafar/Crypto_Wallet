
import 'package:wuu_crypto_wallet/helpers/strings.dart';

import '../models/coin_market_place/coin.dart';

const String DEFAULT_COUNTRY_PREFIX = '+32';
const String DEFAULT_COUNTRY = 'BE';

//! URLS
//Edit Urls
const String WEBSITE_URL = 'https://';
const String HELP_CENTER_URL = 'https://';
const String FAQ_URL = 'https://';
const String PRIVACY_POLICY_URL = 'https://';
const String KYC_AML_URL = 'https://';
const String TERMS_URL = 'https://';
const String SUPPORT_URL = 'https://';
const String MAKE_SUGGESTION_URL = 'https://';

//! Socials
// Edit Socials
const String FACEBOOK_URL = 'https://facebook.com/';
const String INSTAGRAM_URL = 'https://instagram.com/';
const String TWITTER_URL = 'https://twitter.com/';
const String TELEGRAM_URL = 'https://telegram.com/';
const String REDDIT_URL = 'https://reddit.com/';
const String YOUTUBE_URL = 'https://youtube.com/';
const String MEDIUM_URL = 'https://medium.com/';

const int DISABLE_END = 14;

Map<String, dynamic> walletAddMap = {};
var totalBalance;

List<String> units = [BTC, DOGE, BCH, LTC];
List<Coin> coins = [];
Map<String,dynamic> rates = {};