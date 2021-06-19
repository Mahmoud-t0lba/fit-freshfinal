import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit/model/user_modal.dart';
import 'package:fit/services/firebase_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isAdmin = false;

  Future<String> signUp(
      String email, String password, String name, String phone) async {
    final authresult = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // emai , name, address
    await _firestore.collection('users').doc(authresult.user.uid).set({
      'email': email,
      'name': name,
      'phone': phone,
      'isAdmin': isAdmin,
    });
    await _auth.currentUser.sendEmailVerification();
    {}
    return authresult.user.uid;
  }

  Future<String> signIn(String email, String password) async {
    final authresult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('userId', authresult.user.uid);

    if (email == 'abdelwahabhassan2000@gmail.com') {
      String fcm = await FirebaseNotifications().getFCM();
      await _firestore.collection('admin').add({'fcm': fcm});
    }
    return authresult.user.uid;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('userId');
  }

  Future<String> currentUser() async {
    User user = _auth.currentUser;
    return user.uid;
  }

  // ignore: missing_return
  Future<UserCredential> resetPassword(String email) async {
    // ignore: unused_local_variable
    final result = await _auth
        .sendPasswordResetEmail(
          email: email,
        )
        .then((value) => print("Check Your Mail"));
  }

  Future<bool> isLoggedIn() async {
    _auth.currentUser;
    if (_auth.currentUser == null) {
      return false;
    }
    return _auth.currentUser.emailVerified == true;
  }

  /// get user information
  Future getUser() async {
    User user = _auth.currentUser;
    final uid = user.uid;
    final userData = await _firestore.collection('users').doc(uid).get();
    return UserModal.fromJson(userData.data());
  }

  /// update username
  Future<void> updateUserName(userId, name) async {
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    user.doc(userId).update({'name': name}).then((value) {
      print('update user');
    }).catchError((error) => print('failed to update name $error'));
  }

  /// update email
  Future<void> updateEmail(userId, email) async {
    var user = _auth.currentUser;
    user.updateEmail(email).then((value) {
      print('email updating successful');
      CollectionReference user = FirebaseFirestore.instance.collection('users');
      user.doc(userId).update({'email': email});
    }).catchError((error) {
      print('failed to update email $error');
    });
  }

  /// update phone
  Future<void> updatePhone(userId, phone) async {
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    user.doc(userId).update({'phone': phone}).then((value) {
      print('update user phone');
    }).catchError((error) => print('failed to update name $error'));
  }
}
