import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../constants/collections.dart';
import '../models/app_user.dart';
import '../widget/custom_widgets/custom_toast.dart';

class UserAPI {
  static const String _collection = 'users';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  // functions
  Future<List<AppUserModel>> getAllUsers() async {
    final List<AppUserModel> appUser = <AppUserModel>[];
    final QuerySnapshot<Map<String, dynamic>> doc =
        await _instance.collection(_collection).get();

    for (DocumentSnapshot<Map<String, dynamic>> element in doc.docs) {
      appUser.add(AppUserModel.fromDoc(element));
    }
    return appUser;
  }

  // functions
  Future<AppUserModel?>? getInfo({required String uid}) async {
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await _instance.collection(_collection).doc(uid).get();
    if (doc.data() == null) return null;
    return AppUserModel.fromDoc(doc);
  }

  Future<bool> addUser(AppUserModel appUser) async {
    try {
      await userRef
          .doc(appUser.uid)
          .set(appUser.toMap());
      return true;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return false;
    }
  }

  Future<String> uploadImage(File file, String uid) async {
    TaskSnapshot snapshot =
        await FirebaseStorage.instance.ref('profile_images/$uid').putFile(file);
    String url = (await snapshot.ref.getDownloadURL()).toString();
    return url;
  }

  Future<List<AppUserModel>> getAllfirebaseusersbyName(String name) async {
    List<AppUserModel> users = <AppUserModel>[];
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection(_collection).get();

    List<DocumentSnapshot<Map<String, dynamic>>> docs = snapshot.docs;
    for (DocumentSnapshot<Map<String, dynamic>> doc in docs) {
      AppUserModel appUser = AppUserModel.fromDoc(doc);
      if (appUser.name.contains(name)) {
        users.add(appUser);
      }
    }
    return users;
  }
}