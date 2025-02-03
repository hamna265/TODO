import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:memoapp/bottombar/btmbar.dart';

import '../../Model/model.dart';

class SignUpController extends GetxController {
  final _auth = FirebaseAuth.instance;
  var _isObscured = true.obs;
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  bool get isObscured => _isObscured.value;

  void togglePasswordVisibility() {
    _isObscured.value = !_isObscured.value;
  }

  // Sign up logic
  Future<void> signUp(String email, String password) async {
    if (password != confirmpasswordController.text) {
      Fluttertoast.showToast(msg: "Password don't match");
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await postDetailsToFirebase();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  // Post user details to Firestore
  Future<void> postDetailsToFirebase() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel()
      ..email = user!.email
      ..uid = user.uid
      ..firstname = firstnameController.text
      ..lastname = lastnameController.text;

    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.tomap());
    Fluttertoast.showToast(msg: "Account created successfully :)");
    Get.to(() => const Home()); // Navigate to Welcome screen
  }
}
