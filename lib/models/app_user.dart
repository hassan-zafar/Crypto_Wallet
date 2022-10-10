import 'package:cloud_firestore/cloud_firestore.dart';

class AppUserModel {
  AppUserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.username,
    required this.imageURL,
    required this.seedPhrase,
  });

  final String uid;
  final String name;
  final String email;
  final String username;
  final String seedPhrase;
  final String imageURL;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'user_name': username,
      'imageURL': imageURL,
      'seed_phrase': seedPhrase,
    };
  }

  // ignore: sort_constructors_first
  factory AppUserModel.fromDoc(doc) {
    return AppUserModel(
      uid: doc.data()?['uid'] ?? '',
      name: doc.data()?['name'] ?? '',
      email: doc.data()?['email'] ?? '',
      username: doc.data()?['user_name'] ?? '',
      imageURL: doc.data()?['imageURL'] ?? '',
      seedPhrase: doc.data()?['seed_phrase'] ?? '',
    );
  }
}
