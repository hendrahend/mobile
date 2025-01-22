import 'package:flutter/material.dart';
import '../btn.dart';
import 'package:get/get.dart';
import '../login_screen/sign_in.dart';
import 'register_controller.dart';

class SignUpPage extends StatelessWidget {
  final RegisterController registerController = Get.put(RegisterController());

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
            CustomTextField(
              hintText: 'Name',
              icon: Icons.abc_outlined,
              onChanged: (value) => registerController.setName(value),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: 'Email',
              icon: Icons.email,
              onChanged: (value) => registerController.setEmail(value),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: 'Password',
              icon: Icons.lock,
              isPassword: true,
              onChanged: (value) => registerController.setPassword(value),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: 'Confirm Password',
              icon: Icons.lock,
              isPassword: true,
              onChanged: (value) =>
                  registerController.setPasswordConfirmation(value),
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: 'Sign Up',
              onPressed: () => {registerController.register()},
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
