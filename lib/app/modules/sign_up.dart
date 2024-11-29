import 'package:flutter/material.dart';
import 'btn.dart';
import 'package:get/get.dart';
import 'sign_in.dart';

class SignUpPage extends StatelessWidget {
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
              'Create Account',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 30),
            const CustomTextField(
              hintText: 'Full Name',
              icon: Icons.person,
            ),
            const SizedBox(height: 20),
            const CustomTextField(
              hintText: 'Username',
              icon: Icons.abc_outlined,
            ),
            const SizedBox(height: 20),
            const CustomTextField(
              hintText: 'Email',
              icon: Icons.email,
            ),
            const SizedBox(height: 20),
            const CustomTextField(
              hintText: 'Password',
              icon: Icons.lock,
              isPassword: true,
            ),
            const SizedBox(height: 20),
            const CustomTextField(
              hintText: 'Confirm Password',
              icon: Icons.lock,
              isPassword: true,
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: 'Sign Up',
              onPressed: () {
                // Handle Sign Up
              },
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.to(() =>
                    SignInPage()); // Using GetX navigation to go to SignInPage
              },
              child: const Text(
                'Already have an account? Sign In',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
