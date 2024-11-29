import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing1/app/modules/sign_in.dart';
import 'sign_up.dart';
import 'home_page.dart';
import 'login_controller.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final LoginController controller = Get.put(LoginController());

  @override
  void initState() {
    super.initState();

    controller.loadUser();
    Future.delayed(const Duration(seconds: 3), () {
      if (controller.user.value == "") {
        Get.off(() => SignInPage());
      } else {
        Get.off(() => HomePage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.white,
          ),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      'https://th.bing.com/th/id/OIP.pXL0MqW_4A1OgxUpNbngmAHaHa?w=172&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7'), // Your logo image
                ),
                SizedBox(height: 20),
                Text(
                  '',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
                SizedBox(height: 20),
                Text(
                  'Your journey starts here...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
