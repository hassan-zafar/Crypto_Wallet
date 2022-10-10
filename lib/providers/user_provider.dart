import 'package:flutter/material.dart';
import '../models/app_user.dart';

class UserProvider extends ChangeNotifier {
  AppUserModel get currentUser => _user;
  final AppUserModel _user = AppUserModel(
    uid: 'null',
    name: 'Test User',
    username: 'null',
    email: 'test@test.com',
    imageURL: '', seedPhrase: '',
  );
}
