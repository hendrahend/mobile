import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../login_screen/login_controller.dart';

class SettingsPage extends StatelessWidget {
  final LoginController loginController =
      Get.find(); // Access the LoginController

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Settings Page",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              loginController.logout(); // Call logout method
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
