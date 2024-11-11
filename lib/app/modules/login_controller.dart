import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'home_page.dart';
import 'sign_in.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var user = ''.obs;

  void setEmail(String value) => email.value = value;
  void setPassword(String value) => password.value = value;

  Future<void> login() async {
    var url = Uri.https('dummyjson.com', 'auth/login');
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'username': email.value,
          'password': password.value,
          'expiresInMins': 30,
        }));
    print('Response body: ${response.body}');

    var userData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonEncode(userData));
      Get.offAll(HomePage());
    } else {
      Get.snackbar('Error', response.body);
    }
  }

  Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user.value = prefs.getString('user') ?? "";
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAll(() => SignInPage());
  }
}




// Future<void> loadUser 
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class LoginController extends GetxController {
//   var email = ''.obs;
//   var password = ''.obs;

//   void setEmail(String value) => email.value = value;
//   void setPassword(String value) => password.value = value;

//   Future<void> login() async {
//     if (email.value.isNotEmpty && password.value.isNotEmpty) {
//       try {
//         var url = Uri.https('dummyjson.com', 'auth/login'); // Adjust URL if necessary
//         var response = await http.post(
//           url,
//           headers: {"Content-Type": "application/json"},
//           body: jsonEncode({
//             'username': email.value,
//             'password': password.value,
//             'expiresInMins': 30,
//           }),
//         );

//         if (response.statusCode == 200) {
//           // Successful login
//           var responseData = jsonDecode(response.body);
//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           await prefs.setString('email', email.value);
//           await prefs.setString('token', responseData['token']);

//           Get.off(HomePage()); // Navigate to HomePage on success
//           Get.snackbar("Success", "Login successful");
//         } else {
//           // Login failed
//           Get.snackbar("Error", "Invalid username or password");
//         }
//       } catch (e) {
//         Get.snackbar("Error", "An error occurred");
//       }
//     } else {
//       Get.snackbar("Error", "Please fill in all fields");
//     }
//   }
// }
