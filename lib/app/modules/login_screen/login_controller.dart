import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../home_screen/home_page.dart';
import 'sign_in.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var user = ''.obs;

  void setEmail(String value) => email.value = value;
  void setPassword(String value) => password.value = value;

  Future<void> login() async {
    var url = Uri.parse('https://simaru.amisbudi.cloud/api/auth/login');
    http.Response response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'email': email.value,
          'password': password.value,
        }));
    print('Response body: ${response.body}');

    var userData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonEncode(userData));
      Get.off(() => HomePage());
    } else {
      Get.snackbar('Error', response.body);
    }
  }

  // Future<void> loadUser() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   user.value = prefs.getString('user') ?? "";
  // }
  Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString('user');
    if (userString != null && userString.isNotEmpty) {
      var userData = jsonDecode(userString);
      user.value = userData['accessToken'] ?? "";
    } else {
      user.value = "";
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.off(() => SignInPage());
  }
}
