import 'package:shared_preferences/shared_preferences.dart';
import '../database/auth_methods.dart';
import '../models/app_user.dart';

class UserLocalData {
  static late SharedPreferences? _preferences;
  static Future<void> init() async =>
      _preferences = await SharedPreferences.getInstance();

  static void signout() => _preferences!.clear();

  static const String _uidKey = 'UIDKEY';
  static const String _displayNameKey = 'DISPLAYNAMEKEY';
  static const String _usernameKey = 'USERNAMEKEY';
  static const String _imageURLKey = 'IMAGEURLKEY';
  static const String _emailKey = 'EMAILKEY';

  //
  // Setters
  //
  static Future<void> setUID(String uid) async =>
      _preferences!.setString(_uidKey, uid);

  static Future<void> setDisplayName(String name) async =>
      _preferences!.setString(_displayNameKey, name);

  static Future<void> setUsername(String username) async =>
      _preferences!.setString(_usernameKey, username);

  static Future<void> setImageUrl(String url) async =>
      _preferences!.setString(_imageURLKey, url);

  static Future<void> setEmail(String email) async =>
      _preferences!.setString(_emailKey, email);

  //
  // Getters
  //
  static String get getUID => _preferences!.getString(_uidKey) ?? '';
  static String get getDisplayName =>
      _preferences!.getString(_displayNameKey) ?? '';
  static String get getUsername => _preferences!.getString(_usernameKey) ?? '';
  static String get getImageURL => _preferences!.getString(_imageURLKey) ?? '';
  static String get getEmail => _preferences!.getString(_emailKey) ?? '';

  void storeAppUserData({required AppUser appUser}) {
    setUID(appUser.uid);
    setDisplayName(appUser.name );
    setUsername(appUser.username);
    setImageUrl(appUser.imageURL);
    setEmail(appUser.email);
  }

  AppUser get user {
    return AppUser(
      uid: AuthMethods.uid,
      name: getDisplayName,
      username: getUsername,
      imageURL: getImageURL,
      email: getEmail,
    );
  }
}