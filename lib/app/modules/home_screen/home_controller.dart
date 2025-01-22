import 'dart:convert';
import 'package:http/http.dart' as http;
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

  // Future<void> loadUser() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final user =
  //       jsonDecode(prefs.getString('user') ?? "") as Map<String, dynamic>;
  //   // firstName.value = user['firstName'];
  //   // email.value = user['email'];
  //   // lastName.value = user['lastName'];
  //   // image.value = user['image'];
  //   // username.value = user['username'];

  //   profile.value = User(
  //     name: user['name'],
  //     email: user['email'],
  //   );
  // }

  Future<void> loadUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final user =
          jsonDecode(prefs.getString('user') ?? "") as Map<String, dynamic>;
      var token = user['accessToken'];

      var url = Uri.parse('https://simaru.amisbudi.cloud/api/auth/me');
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['user'];
        profile.value = User.fromJson(data);
        // profile.value = User(name: user['name'], email: user['email']);
      } else {
        Get.snackbar('Error', 'Failed to delete booking: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }
}
