// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:memoapp/bottombar/btmbar.dart';
import 'package:memoapp/modules/appcolor.dart';

class SignInController extends GetxController {
  var isObscured = true.obs;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  Widget emailField() {
    return TextFormField(
      cursorColor: Color.fromARGB(255, 0, 0, 0),
      style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) return "Please Enter Email";
        String pattern = r'\w+@\w+\.\w+';
        if (!RegExp(pattern).hasMatch(value)) return 'Invalid Email format';
        return null;
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
          borderRadius: BorderRadius.circular(15),
        ),
        prefixIcon: const Icon(Icons.mail, color: Color.fromARGB(255, 0, 0, 0)),
        hintText: "Email",
        hintStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    );
  }

  Widget passwordField() {
    return TextFormField(
      cursorColor: Color.fromARGB(255, 0, 0, 0),
      style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      obscureText: isObscured.value,
      controller: passwordController,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) return "Please Enter Password";
        if (!regex.hasMatch(value))
          return "Please Enter Valid Password(Min 6 character)";
        return null;
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
          borderRadius: BorderRadius.circular(15),
        ),
        prefixIcon:
            const Icon(Icons.vpn_key, color: Color.fromARGB(255, 0, 0, 0)),
        suffixIcon: IconButton(
          onPressed: () {
            isObscured.value = !isObscured.value;
          },
          icon: isObscured.value
              ? Icon(Icons.visibility_outlined)
              : Icon(Icons.visibility_off_outlined),
        ),
        hintText: "Password",
        hintStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    );
  }

  Widget loginButton(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: AppColors.tertiaryColor,
      child: MaterialButton(
        splashColor: Color.fromARGB(255, 240, 243, 242),
        padding: const EdgeInsets.fromLTRB(60, 15, 60, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn(emailController.text, passwordController.text);
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        Fluttertoast.showToast(msg: "Login Successful");
        Get.offAll(() => const Home());
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(msg: e.message ?? "An error occurred");
      } catch (e) {
        Fluttertoast.showToast(msg: "An unexpected error occurred");
      }
    }
  }
}
