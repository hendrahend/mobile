import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing1/app/data/model/User.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  var profile = User().obs;
  // var firstName = "".obs;
  // var lastName = "".obs;
  // var email = "".obs;
  // var image = "".obs;
  // var username = "".obs;

  void changePage(int index) {
    currentIndex.value = index;
  }

  Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user =
        jsonDecode(prefs.getString('user') ?? "") as Map<String, dynamic>;
    // firstName.value = user['firstName'];
    // email.value = user['email'];
    // lastName.value = user['lastName'];
    // image.value = user['image'];
    // username.value = user['username'];

    profile.value = User(
      firstName: user['firstName'],
      lastName: user['lastName'],
      email: user['email'],
      image: user['image'],
      username: user['username'],
      gender: user['gender'],
    );
  }
}
