
import 'package:wuu_crypto_wallet/helpers/strings.dart';

class User {
  String? uid;
  String? email;
  String? password;
  String? fName;
  String? lName;
  String? phone;
  String? country;
  String? refBy;
  String? refCode;

  User({
    this.uid,
    this.email,
    this.password,
    this.fName,
    this.lName,
    this.phone,
    this.country,
    this.refBy,
    this.refCode,
  });

  Map toMap(User user) {
    var data = Map<String, dynamic>();
    data[UID] = user.uid;
    data[EMAIL] = user.email;
    data[PASSWORD] = user.password;
    data[FIRST_NAME] = user.fName;
    data[LAST_NAME] = user.lName;
    data[PHONE] = user.phone;
    data[COUNTRY] = user.country;
    data[REFERREDBY] = user.refBy;
    data[REFCODE] = user.refCode;

    return data;
  }

  User.fromMap(List mapData) {
    uid = mapData[0][UID] ?? '';
    email = mapData[0][EMAIL] ?? '';
    password = mapData[0][PASSWORD] ?? '';
    fName = mapData[0][FIRST_NAME] ?? '';
    lName = mapData[0][LAST_NAME] ?? '';
    phone = mapData[0][PHONE] ?? '';
    country = mapData[0][COUNTRY] ?? '';
    refBy = mapData[0][REFERREDBY] ?? '';
    refCode = mapData[0][REFCODE] ?? '';
  }
}
