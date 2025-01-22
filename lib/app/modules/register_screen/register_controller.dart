import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:testing1/app/modules/login_screen/sign_in.dart';

class RegisterController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var passwordConfirmation = ''.obs;

  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final passwordConfirmationFocusNode = FocusNode();

  void setName(String value) {
    name.value = value;
    nameFocusNode.requestFocus();
  }

  void setEmail(String value) {
    email.value = value;
    emailFocusNode.requestFocus();
  }

  void setPassword(String value) {
    password.value = value;
    passwordFocusNode.requestFocus();
  }

  void setPasswordConfirmation(String value) {
    passwordConfirmation.value = value;
    passwordConfirmationFocusNode.requestFocus();
  }

  Future<void> register() async {
    var url = Uri.parse('https://simaru.amisbudi.cloud/api/auth/register');
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'name': name.value,
          'email': email.value,
          'password': password.value,
          'password_confirmation': passwordConfirmation.value,
        }));
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      Get.snackbar('Success', 'Registrasi Berhasil!');
      Get.off(() => SignInPage());
    } else {
      Get.snackbar('Error', response.body);
    }
  }
}
