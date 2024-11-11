import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sign_up.dart';
import 'btn.dart';
import 'login_controller.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final LoginController loginController =
      Get.put(LoginController()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 30),
            // Email TextField
            CustomTextField(
              onChanged: (value) => loginController.setEmail(value),
              hintText: 'Email',
              icon: Icons.email,
            ),
            const SizedBox(height: 20),
            // Password TextField
            CustomTextField(
              onChanged: (value) => loginController.setPassword(value),
              hintText: 'Password',
              icon: Icons.lock,
              isPassword: true,
              // border: OutlineInputBorder(),
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: 'Sign In',
              onPressed: () {
                loginController.login(); // Call the login function
              },
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.to(() => SignUpPage());
              },
              child: const Text(
                'Don\'t have an account? Sign Up',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
