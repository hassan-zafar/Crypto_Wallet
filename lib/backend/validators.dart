

import 'package:wuu_crypto_wallet/backend/call_functions.dart';

abstract class BaseValidators {
  String? validateEmpty(String? value, String? title, context);
  String? validateOTPRegex(String? value, context);
  String? validateName(String value, context);
  String? validateEmail(String value, context);
  String? validatePassword(String value, context);
  String? validateCPassword(String value, String password, context);
  String? ethAddressValidator(String? value, context);
  String? validateOtp(String value, otpCode, context);
  String? validateAmount(bool _hasBal, String value, double balance,
      double minimum, double maximum, context,
      {bool notNull = true});
  String? btcAddressValidator(String? value, context);
  String? dogeAddressValidator(String? value, context);
  String? litecoinAddressValidator(String? value, context);
}

class ValidatorsFxn implements BaseValidators {
  final CallFunctions _callFunctions = CallFunctions();
  @override
  String? validateEmpty(String? value, String? title, context) {
    if (value!.trim().length == 0) {
      return _callFunctions.multiTranslation(
        context,
        [title!, 'is Required'],
      );
    }
    return null;
  }

  @override
  String? validateOTPRegex(String? value, context) {
    String pattern = r'^[0-9]+$';
    RegExp regExp = RegExp(pattern);

    if (value!.trim().length == 0) {
      return _callFunctions.translation(context, "OTP is Required");
    } else if (value.trim().length < 6) {
      return _callFunctions.translation(context, "Invalid OTP lenght");
    } else if (!regExp.hasMatch(value.trim())) {
      return _callFunctions.translation(context, "Invalid Input");
    } else {
      return null;
    }
  }

  @override
  String? validateName(String? value, context) {
    if (value!.trim().length == 0) {
      return _callFunctions.multiTranslation(context, ["Name", "is Required"]);
    } else if (value.trim().length < 2) {
      return _callFunctions.translation(context, "Invalid name length");
    }
    return null;
  }

  @override
  String? validateEmail(String? value, context) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value!.trim().length == 0) {
      return _callFunctions.multiTranslation(context, ["Email", "is Required"]);
    } else if (!regExp.hasMatch(value.trim())) {
      return _callFunctions.translation(context, "Invalid Email");
    } else {
      return null;
    }
  }

  @override
  String? validatePassword(String? value, context) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (value!.trim().length <= 0) {
      return _callFunctions
          .multiTranslation(context, ["Password", "is Required"]);
    } else if (!regExp.hasMatch(value.trim())) {
      return _callFunctions.translation(
          context, "Upper,Lower Case, Number and Special chars");
    }
    return null;
  }

  @override
  String? validateCPassword(String? value, String? password, context) {
    if (value!.trim().length <= 0) {
      return _callFunctions
          .multiTranslation(context, ["Confirm Password", "is Required"]);
    } else if (value != password) {
      return _callFunctions.translation(context, "Passwords don't match");
    }
    return null;
  }

  @override
  String? validateOtp(String? value, otpCode, context) {
    if (value!.trim().length < 6) {
      return _callFunctions.translation(context, "Invalid OTP lenght");
    } else if (value != otpCode) {
      return _callFunctions.translation(context, "Otp don't match input");
    }
    return null;
  }

  @override
  String? validateAmount(bool? hasBal, String? value, double? balance,
      double? minimum, double? maximum, context,
      {bool? notNull = true}) {
    if (value == null || value == "" || value == ".") {
      return _callFunctions.translation(context, "Invalid amount");
    } else if (double.parse(value) < minimum!) {
      return _callFunctions.translation(context, "Amount less than minimum");
    } else if (double.parse(value) > maximum!) {
      return _callFunctions.translation(context, "Amount greater than maximum");
    } else if (hasBal! && (double.parse(value) > balance!)) {
      return _callFunctions.translation(context, "Amount greater than balance");
    }

    return notNull! ? "" : null;
  }

  @override
  String? ethAddressValidator(String? value, context) {
    String pattern = r"^0x[a-fA-F0-9]{40}$";
    RegExp regExp = RegExp(pattern);
    if (value != "" &&
        value != "." &&
        value != null &&
        !regExp.hasMatch(value)) {
      return _callFunctions.translation(context, "Invalid Address");
    }
    return null;
  }

  @override
  String? btcAddressValidator(String? value, context) {
    String pattern = r"^([13]|bc1)[A-HJ-NP-Za-km-z1-9]{27,34}$";
    RegExp regExp = RegExp(pattern);
    if (value != "" &&
        value != "." &&
        value != null &&
        !regExp.hasMatch(value)) {
      return _callFunctions.translation(context, "Invalid Address");
    }
    return null;
  }

  @override
  String? dogeAddressValidator(String? value, context) {
    String pattern = r"^(D|A|9)[a-km-zA-HJ-NP-Z1-9]{33,34}$";
    RegExp regExp = RegExp(pattern);
    if (value != "" &&
        value != "." &&
        value != null &&
        !regExp.hasMatch(value)) {
      return _callFunctions.translation(context, "Invalid Address");
    }
    return null;
  }

  @override
  String? litecoinAddressValidator(String? value, context) {
    String pattern = r"^[LM3][a-km-zA-HJ-NP-Z1-9]{26,33}$";
    RegExp regExp = RegExp(pattern);
    if (value != "" &&
        value != "." &&
        value != null &&
        !regExp.hasMatch(value)) {
      return _callFunctions.translation(context, "Invalid Address");
    }
    return null;
  }
}
