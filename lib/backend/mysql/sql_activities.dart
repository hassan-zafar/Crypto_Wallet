import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '../../helpers/strings.dart';

abstract class BaseActivitiesSql {
  storeUserActivitiesSql(int type);
  getUserActivitiesSql();
  getNotificationsSql();
  storeUserDeviceActivitiesSql();
  getUserDeviceActivitiesSql();
  getUserKycStatusSql();
}

// class ActivitiesSql implements BaseActivitiesSql {
//   final DeviceInfoFxn _deviceInfoFxn = DeviceInfoFxn();

//   String url = 'asd';
//   // dotenv.env['ENDPOINT_URL']!;
//   static String username = 
//   dotenv.env['ENDPOINT_USERNAME']!;
//   static String password = dotenv.env['ENDPOINT_PASSWORD']!;
//   static String base64encodedData =
//       base64Encode(utf8.encode('$username:$password'));

//   Map<String, String> header = {
//     'Authorization': 'Basic $base64encodedData',
//   };

//   static Box userBox = Hive.box(USERS);
//   String uid = userBox.isNotEmpty ? userBox.get(USER)[USER][UID] : "";

//   @override
//   Future<List> getUserActivitiesSql() async {
//     List datas = [];
//     try {
//       Map<String, String> body = {
//         UID: uid,
//       };
//       http.Response response = await http.post(
//         Uri.parse('${url}get-activities.php'),
//         headers: header,
//         body: body,
//       );
//       var resbody = json.decode(response.body);
//       datas = resbody[MESSAGE];
//       return datas;
//     } catch (e) {
//       print(e);
//     }
//     return datas;
//   }

//   @override
//   Future<List> getUserDeviceActivitiesSql() async {
//     List datas = [];

//     try {
//       Map<String, String> body = {
//         UID: uid,
//       };
//       http.Response response = await http.post(
//         Uri.parse('${url}get-device.php'),
//         headers: header,
//         body: body,
//       );
//       var resbody = json.decode(response.body);
//       datas = resbody[MESSAGE];
//       return datas;
//     } catch (e) {
//       print(e);
//     }
//     return datas;
//   }

//   @override
//   storeUserActivitiesSql(int type) async {
//     try {
//       Map<String, String> body = {
//         TYPE: type.toString(),
//         UID: uid,
//       };

//       http.Response response = await http.post(
//         Uri.parse(url + 'store-activities.php'),
//         headers: header,
//         body: body,
//       );

//       var resbody = json.decode(response.body);
//       return resbody;
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   storeUserDeviceActivitiesSql() async {
//     try {
//       Map<String, dynamic>? dts = await _deviceInfoFxn.getDeviceIp();
//       dts![UID] = uid;

//       http.Response response = await http.post(
//         Uri.parse(url + 'store-device.php'),
//         headers: header,
//         body: dts,
//       );
//       var resbody = json.decode(response.body);
//       return resbody;
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Future<List> getNotificationsSql() async {
//     List datas = [];
//     try {
//       Map<String, String> body = {
//         UID: uid,
//       };
//       http.Response response = await http.post(
//         Uri.parse(url + 'get-notifications.php'),
//         headers: header,
//         body: body,
//       );
//       var resbody = json.decode(response.body);

//       if (resbody[STATUS] == 'success') {
//         datas = resbody[MESSAGE];
//         return datas;
//       } else {
//         return datas;
//       }
//     } catch (e) {
//       print(e);
//       return datas;
//     }
//   }

//   @override
//   Future<int> getUserKycStatusSql() async {
//     int status = 0;
//     try {
//       Map<String, String> body = {
//         UID: uid,
//       };
//       http.Response response = await http.post(
//         Uri.parse(url + 'get-kyc-status.php'),
//         headers: header,
//         body: body,
//       );
//       var resbody = json.decode(response.body);

//       if (resbody[STATUS] == 'success') {
//         status = resbody[MESSAGE];
//         return status;
//       } else {
//         return status;
//       }
//     } catch (e) {
//       print(e);
//       return status;
//     }
//   }
// }
