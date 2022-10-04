import 'package:encrypt/encrypt.dart';

abstract class BaseEncrypt {
  appEncrypt(String data);
  appDecrypt(String encrypted);
}

class EncryptApp implements BaseEncrypt {
  static final key = Key.fromLength(32);
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  String appEncrypt(String data) {
    final Encrypted encrypted = encrypter.encrypt(data, iv: iv);
    final String encrypted64 = encrypted.base64;
    return encrypted64;
  }

  String appDecrypt(String encrypted) {
    final String decrypted64 = encrypter.decrypt64(encrypted, iv: iv);

    return decrypted64;
  }
}
