// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoapp/Login/sign_in/sign_in_view.dart';

import '../../modules/appcolor.dart';
import 'sign_up_state.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final Size screenSize = MediaQuery.of(context).size;
          final double screenHeight = screenSize.height;
          final double screenWidth = screenSize.width;

          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 230,
                        width: 550,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "TODO",
                              style: TextStyle(
                                  color: AppColors.tertiaryColor,
                                  fontSize: 45,
                                  fontWeight: FontWeight.w600),
                            ),
                            Icon(
                              Icons.task,
                              color: AppColors.tertiaryColor,
                              size: 40,
                            )
                          ],
                        )),
                      ),
                      buildTextField(
                          "First Name", controller.firstnameController),
                      SizedBox(height: 20),
                      buildTextField(
                          "Last Name", controller.lastnameController),
                      SizedBox(height: 20),
                      buildTextField("Email", controller.emailController),
                      SizedBox(height: 20),
                      buildPasswordField(controller),
                      SizedBox(height: 20),
                      buildPasswordField(controller, isConfirm: true),
                      SizedBox(height: 30),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.tertiaryColor,
                        child: MaterialButton(
                          padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {
                            controller.signUp(controller.emailController.text,
                                controller.passwordController.text);
                          },
                          child: Text(
                            "Sign Up",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?'),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const SignInView());
                            },
                            child: Text(" Login",
                                style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildTextField(String hintText, TextEditingController controller) {
    return TextFormField(
      cursorColor: Colors.black,
      controller: controller,
      validator: (value) =>
          value!.isEmpty ? 'This field cannot be empty' : null,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15)),
        prefixIcon: Icon(Icons.person, color: Colors.black),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget buildPasswordField(SignUpController controller,
      {bool isConfirm = false}) {
    return Obx(() {
      return TextFormField(
        controller: isConfirm
            ? controller.confirmpasswordController
            : controller.passwordController,
        obscureText: controller.isObscured,
        validator: (value) {
          if (value!.isEmpty) return 'Please enter a password';
          if (isConfirm && value != controller.passwordController.text)
            return "Passwords don't match";
          return null;
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(15)),
          prefixIcon: Icon(Icons.lock, color: Colors.black),
          suffixIcon: IconButton(
            onPressed: controller.togglePasswordVisibility,
            icon: Icon(controller.isObscured
                ? Icons.visibility
                : Icons.visibility_off),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: isConfirm ? 'Confirm Password' : 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      );
    });
  }
}
