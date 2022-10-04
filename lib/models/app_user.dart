import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.username,
    required this.imageURL,
  });

  final String uid;
  final String name;
  final String email;
  final String username;
  final String imageURL;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'user_name': username,
      'imageURL': imageURL,
    };
  }

  // ignore: sort_constructors_first
  factory AppUser.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    return AppUser(
      uid: doc.data()?['uid'] ?? '',
      name: doc.data()?['name'] ?? '',
      email: doc.data()?['email'] ?? '',
      username: doc.data()?['user_name'] ?? '',
      imageURL: doc.data()?['imageURL'] ?? '',
    );
  }
}
