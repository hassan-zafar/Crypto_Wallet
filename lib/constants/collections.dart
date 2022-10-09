import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wuu_crypto_wallet/models/app_user.dart';

final CollectionReference<Map<String, dynamic>> userRef =
    FirebaseFirestore.instance.collection('users');
final CollectionReference<Map<String, dynamic>> walletRef =
    FirebaseFirestore.instance.collection('wallets');

