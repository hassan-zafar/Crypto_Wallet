import 'package:flutter/material.dart';
import '../models/app_user.dart';

class UserProvider extends ChangeNotifier {
  AppUser get currentUser => _user;
  final AppUser _user = AppUser(
    uid: 'null',
    name: 'Test User',
    username: 'null',
    email: 'test@test.com',
    imageURL: '',
  );
}
