import 'dart:io';
import 'package:local_auth/local_auth.dart';

import '../helpers/strings.dart';

abstract class BaseBio {
  Future<bool?> checkAvailability();
  Future<String?> getAvailableBiometric();
  Future<bool?> authenticate();
}

class BiometricsFxn implements BaseBio {
  LocalAuthentication localAuth = LocalAuthentication();

  @override
  Future<bool?> checkAvailability() async {
    bool? canCheckBiometrics;
    try {
      canCheckBiometrics = await localAuth.canCheckBiometrics;
    } catch (e) {
      print(e);
    }
    return canCheckBiometrics;
  }

  @override
  Future<bool?> authenticate() async {
    bool? didAuthenticate =true;
    // try {
    //   const iosStrings = IOSAuthMessages(
    //     cancelButton: 'cancel',
    //     goToSettingsButton: 'settings',
    //     goToSettingsDescription: 'settings',
    //     lockOut: 'Please re-enable your Biometrics',
    //   );
    //   didAuthenticate = await localAuth.authenticate(
    //     localizedReason: 'Please authenticate',
    //     useErrorDialogs: false,
    //     iOSAuthStrings: iosStrings,
    //   );
    // } catch (e) {
    //   print(e);
    // }
    return didAuthenticate;
  }

  @override
  Future<String?> getAvailableBiometric() async {
    String? bioType;
    try {
      List<BiometricType> availableBiometrics =
          await localAuth.getAvailableBiometrics();

      if (Platform.isIOS) {
        if (availableBiometrics.contains(BiometricType.face)) {
          // Face ID.
          bioType = FACE;
        } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
          // Touch ID.
          bioType = TOUCHID;
        }
      }
    } catch (e) {
      print(e);
    }
    return bioType;
  }
}
