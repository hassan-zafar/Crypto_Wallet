import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../backend/erc_20_wallet.dart';
import '../backend/wallet_addresses.dart';
import '../constants/collections.dart';
import '../functions/time_date_functions.dart';
import '../helpers/app_config.dart';
import '../helpers/strings.dart';
import '../models/app_user.dart';
import '../widget/custom_widgets/custom_toast.dart';
import 'user_api.dart';
import 'user_local_data.dart';

class AuthMethods {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get getCurrentUser => _auth.currentUser;

  static String get uid => _auth.currentUser?.uid ?? '';

  static String get uniqueID => uid + TimeDateFunctions.timestamp.toString();

  Future<User?> signupWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential result = await _auth
          .createUserWithEmailAndPassword(
        email: email.toLowerCase().trim(),
        password: password.trim(),
      )
          .catchError((Object obj) {
        CustomToast.errorToast(message: obj.toString());
      });
      final User? user = result.user;
      assert(user != null);
      await UserAPI().addUser(
        AppUserModel(
          uid: user!.uid,
          name: '',
          email: email,
          username: '',
          imageURL: '',
          seedPhrase: '',
        ),
      );

      return user;
    } catch (signUpError) {
      CustomToast.errorToast(message: signUpError.toString());
      return null;
    }
  }

  Future<AppUserModel> fetchUserInfoFromFirebase({
    required String uid,
  }) async {
    final DocumentSnapshot _user = await userRef.doc(uid).get();
    currentUser = AppUserModel.fromDoc(_user);
    return currentUser!;
  }

  Future<bool> fetchWalletInfoFromFirebase({
    required String seedPhrase,
  }) async {
    final DocumentSnapshot walletSnapshot =
        await walletRef.doc(seedPhrase).get();
    walletAddMap = walletSnapshot.data()! as Map<String, dynamic>;
    return walletSnapshot.exists;
  }

  Future<User?> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential result = await _auth
          .signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      )
          .catchError((Object obj) {
        CustomToast.errorToast(message: obj.toString());
      });
      final User? user = result.user;
      final AppUserModel? appUser = await UserAPI().getInfo(uid: user!.uid);
      UserLocalData().storeAppUserData(appUser: appUser!);
      // await walletRef.doc(user.uid).get().then((doc) {
      //   walletAddMap = doc.data() as Map<String, dynamic>;
      // });
      return user;
    } catch (signUpError) {
      CustomToast.errorToast(message: signUpError.toString());
      return null;
    }
  }

  Future<bool> forgetPassword(String email) async {
    try {
      _auth.sendPasswordResetEmail(email: email.trim());
      return true;
    } catch (error) {
      CustomToast.errorToast(message: error.toString());
    }
    return false;
  }

  Future<void> signOut() async {
    UserLocalData.signout();
    await _auth.signOut();
  }
}
