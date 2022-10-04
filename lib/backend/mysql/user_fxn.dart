import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import '../../helpers/strings.dart';
import '../../helpers/user_model.dart';
import '../call_functions.dart';
import '../erc_20_wallet.dart';
import '../miscellenous.dart';
import '../notifications_repo.dart';
import '../wallet_addresses.dart';

abstract class BaseUserSql {
  getUser(String email);
  Future<Map> signUp(String email, String password, String firstName,
      String lastName, String phone, String country, String refBy, context);
  Future<bool> signIn(String email, String password, context);
  Future<bool> signOut(context);
  forgetPassword(String email, context);
  changePassword(String uid, String password, String newPass, context);

  updateProfile(Map<String, dynamic> data, String slug, context);
  updateProfilePic(String imgPath);
  Future<List?> getTransactions();
  Future<bool?> requestRefPayout(context);
  storeTransaction(Map<String, dynamic> data, context);
  Future<bool> kycVerification(Map<String, dynamic> data, context);
}

class UserSql implements BaseUserSql {
  // final ActivitiesSql _activitiesSql = ActivitiesSql();

  final ERC20WalletAd _erc20walletAd = ERC20WalletAd();
  final WalletAd _walletAd = WalletAd();
  final CallFunctions _callFunctions = CallFunctions();
  final MiscRepo _miscRepo = MiscRepo();
  final NotificationsRepo _notificationsRepo = NotificationsRepo();

  // Box userBox = Hive.box(USERS);

  String url = dotenv.env['ENDPOINT_URL']!;
  static String username = dotenv.env['ENDPOINT_USERNAME']!;
  static String password = dotenv.env['ENDPOINT_PASSWORD']!;
  static String base64encodedData =
      base64Encode(utf8.encode('$username:$password'));

  Map<String, String> header = {
    'Authorization': 'Basic $base64encodedData',
  };

  @override
  getUser(String email) async {
    try {
      Map<String, String> body = {
        EMAIL: email,
      };
      http.Response response = await http.post(
        Uri.parse('${url}get-user.php'),
        headers: header,
        body: body,
      );
      var resbody = json.decode(response.body);

      // userBox.put(
      //   USER,
      //   {
      //     USER: resbody[USER],
      //     WALLET: resbody[WALLET],
      //     FINANCIAL: resbody[FINANCIAL],
      //     OTPS: resbody[OTPS],
      //   },
      // );
      return resbody;
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<Map> signUp(
      String email,
      String password,
      String firstName,
      String lastName,
      String phone,
      String country,
      String refBy,
      context) async {
    Map dats = {};

    try {
      User user;
      String uid = const Uuid().v4().toString();

      String userRefCode = randomString(7).toString();

      user = User(
        uid: uid,
        email: email,
        password: password,
        fName: firstName,
        lName: lastName,
        phone: phone,
        country: country,
        refCode: userRefCode.toUpperCase(),
        refBy: refBy,
      );

      http.Response response = await http.post(
        Uri.parse('${url}sign-up.php'),
        headers: header,
        body: user.toMap(user),
      );

      var resbody = json.decode(response.body);

      if (resbody[STATUS] == 'success') {
        await _walletFxn(uid, context);
        dats = {
          STATUS: true,
          MESSAGE: resbody[MESSAGE],
        };

        // await _activitiesSql.storeUserActivitiesSql(1);
        // await _activitiesSql.storeUserDeviceActivitiesSql();

        await _notificationsRepo.subscribeToTopics();
      } else {
        dats = {
          STATUS: false,
          MESSAGE: resbody[MESSAGE],
        };

        _callFunctions.showSnacky(resbody[MESSAGE], false, context);
      }

      return dats;
    } catch (e) {
      _callFunctions.showSnacky(DEFAULT_ERROR, false, context);

      print(e);
    }

    return dats;
  }

  _walletFxn(String uid, context) async {
    try {
      Map walletAddMap = await _walletAd.createWallet();

      Map? erc20Add = await _erc20walletAd.createErcWallet();

      walletAddMap.addAll(erc20Add);
      walletAddMap[UID] = uid;

      http.Response response = await http.post(
        Uri.parse('${url}store-wallets.php'),
        headers: header,
        body: walletAddMap,
      );

      var resbody = json.decode(response.body);

      if (resbody[STATUS] == 'failed') {
        _callFunctions.showSnacky(resbody[MESSAGE], false, context);
      }
    } catch (e) {
      _callFunctions.showSnacky(DEFAULT_ERROR, false, context);

      print(e);
    }
  }

  @override
  Future<bool> signIn(String email, String password, context) async {
    bool status = false;
    try {
      Map<String, String> body = {
        EMAIL: email,
        PASSWORD: password,
      };
      http.Response response = await http.post(
        Uri.parse('${url}sign-in.php'),
        headers: header,
        body: body,
      );

      var resbody = json.decode(response.body);

      if (resbody[STATUS] == 'success') {
        status = true;
        await getUser(email);

        // await _activitiesSql.storeUserActivitiesSql(0);
        // await _activitiesSql.storeUserDeviceActivitiesSql();

        await _notificationsRepo.getnStoreToken(userStoreToken);

        _callFunctions.showSnacky(resbody[MESSAGE], true, context);
      } else {
        status = false;
        _callFunctions.showSnacky(resbody[MESSAGE], false, context);
      }

      return status;
    } catch (e) {
      _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
      print(e);
    }
    return status;
  }

  userStoreToken(token) async {
    try {
      String uid = _miscRepo.getUser(UID);

      String btc = _miscRepo.getWallet('${BTC}_$WALLETID');
      String doge = _miscRepo.getWallet('${DOGE}_$WALLETID');
      String erc20 = _miscRepo.getWallet('${ERC20}_$ADDRESS');

      Map<String, dynamic> body = {
        UID: uid,
        'btc_wallet_id': btc,
        'doge_wallet_id': doge,
        ADDRESS: erc20,
        TOKEN: token,
      };
      await http.post(
        Uri.parse('${url}store-notification-token.php'),
        headers: header,
        body: body,
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  updateProfile(Map<String, dynamic> data, String slug, context) async {
    try {
      String email = _miscRepo.getUser(EMAIL);
      String uid = _miscRepo.getUser(UID);

      data[UID] = uid;

      http.Response response = await http.post(
        Uri.parse(url + slug),
        headers: header,
        body: data,
      );

      var resbody = json.decode(response.body);

      if (resbody[STATUS] == 'success') {
        // await _activitiesSql.storeUserActivitiesSql(11);

        getUser(email);

        _callFunctions.showSnacky(resbody[MESSAGE], true, context);
      } else {
        _callFunctions.showSnacky(resbody[MESSAGE], false, context);
      }

      return resbody;
    } catch (e) {
      _callFunctions.showSnacky(DEFAULT_ERROR, false, context);

      print(e);
    }
  }

  @override
  updateProfilePic(String imgPath) async {
    try {
      String uid = _miscRepo.getUser(UID);

      final Uri uri = Uri.parse('${url}update-ppic.php');
      http.MultipartRequest request = http.MultipartRequest('POST', uri);
      String imgName = '${APP_NAME}_${randomString(8)}.jpg';
      request.fields[UID] = uid;

      String base64encodedData =
          base64Encode(utf8.encode('$username:$password'));

      String header = 'Basic $base64encodedData';

      request.headers['Authorization'] = header;

      http.MultipartFile pic = await http.MultipartFile.fromPath(
        "image",
        imgPath,
        filename: imgName,
      );

      request.files.add(pic);
      await request.send();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<bool> kycVerification(Map<String, dynamic> data, context) async {
    try {
      String uid = _miscRepo.getUser(UID);

      final Uri uri = Uri.parse('${url}kyc.php');
      http.MultipartRequest request = http.MultipartRequest('POST', uri);
      String imgName = '${APP_NAME}_KYC_${randomString(8)}.jpg';
      request.fields[UID] = uid;

      String base64encodedData =
          base64Encode(utf8.encode('$username:$password'));

      String header = 'Basic $base64encodedData';

      request.headers['Authorization'] = header;
      request.fields[NAME] = data[NAME];
      request.fields[ADDRESS] = data[ADDRESS];
      request.fields[CITY] = data[CITY];
      request.fields[STATE] = data[STATE];
      request.fields[DOB] = data[DOB];
      request.fields[ID_TYPE] = data[ID_TYPE];
      request.fields[ID_NO] = data[ID_NO];

      http.MultipartFile pic = await http.MultipartFile.fromPath(
        IMAGE,
        data[IMAGE],
        filename: imgName,
      );

      request.files.add(pic);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  Future<bool> forgetPassword(String email, context) async {
    bool status = false;

    try {
      Map<String, String> body = {
        EMAIL: email,
      };
      http.Response response = await http.post(
        Uri.parse('${url}reset-request.php'),
        headers: header,
        body: body,
      );

      var resbody = json.decode(response.body);

      if (resbody[STATUS] == 'success') {
        status = true;

        // await _activitiesSql.storeUserActivitiesSql(2);

        _callFunctions.showSnacky(resbody[MESSAGE], true, context);
      } else {
        status = false;
        _callFunctions.showSnacky(resbody[MESSAGE], false, context);
      }

      return status;
    } catch (e) {
      _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
      print(e);
    }
    return status;
  }

  @override
  storeTransaction(Map<String, dynamic> data, context) async {
    try {
      http.Response response = await http.post(
        Uri.parse('${url}store-transactions.php'),
        headers: header,
        body: data,
      );
      var resbody = json.decode(response.body);

      if (resbody[STATUS] == 'success') {
        // await _activitiesSql.storeUserActivitiesSql(data[TYPE]);
      }

      return resbody;
    } catch (e) {
      print(e);
      _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
    }
  }

  @override
  Future<List?> getTransactions() async {
    String uid = _miscRepo.getUser(UID);

    try {
      Map<String, String> body = {
        UID: uid,
      };
      http.Response response = await http.post(
        Uri.parse('${url}get-transactions.php'),
        headers: header,
        body: body,
      );
      var resbody = json.decode(response.body);

      if (resbody[STATUS] == 'success') {
        return resbody[MESSAGE];
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  changePassword(String uid, String password, String newPass, context) async {
    try {
      Map<String, String> body = {
        UID: uid,
        PASSWORD: password,
        NEW_PASSWORD: newPass,
      };
      http.Response response = await http.post(
        Uri.parse('${url}change-password.php'),
        headers: header,
        body: body,
      );
      var resbody = json.decode(response.body);

      if (resbody[STATUS] == 'success') {
        _callFunctions.showSnacky(resbody[MESSAGE], true, context);

        // await _activitiesSql.storeUserActivitiesSql(3);
      } else {
        _callFunctions.showSnacky(resbody[MESSAGE], false, context);
      }

      return resbody;
    } catch (e) {
      print(e);
      _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
    }
  }

  @override
  Future<bool> signOut(context) async {
    bool status = false;
    try {
      Navigator.pushReplacementNamed(context, '/start-page/');
      await Future.delayed(Duration(seconds: 2));
      // await userBox.clear();
      status = true;
    } catch (e) {
      status = false;

      print(e);
      _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
    }
    return status;
  }

  @override
  Future<bool?> requestRefPayout(context) async {
    String uid = _miscRepo.getUser(UID);
    String fName = _miscRepo.getUser(FIRST_NAME);
    String lName = _miscRepo.getUser(LAST_NAME);
    String name = '$fName $lName';
    String refCode = _miscRepo.getUser(REFCODE);
    String ref = randomString(8);

    try {
      Map<String, String> body = {
        UID: uid,
        REFERENCE: ref,
        REFCODE: refCode,
        NAME: name,
      };
      http.Response response = await http.post(
        Uri.parse('${url}request_ref_pay.php'),
        headers: header,
        body: body,
      );
      var resbody = json.decode(response.body);

      if (resbody[STATUS] == 'success') {
        _callFunctions.showSnacky(resbody[MESSAGE], true, context);
        // _activitiesSql.storeUserActivitiesSql(12);
        return true;
      } else {
        _callFunctions.showSnacky(resbody[MESSAGE], false, context);
        return false;
      }
    } catch (e) {
      print(e);
      _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
      return false;
    }
  }
}
