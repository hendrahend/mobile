import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Category {
  final int id;
  final String name;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class CategoryController extends GetxController {
  var roomList = <Category>[].obs;
  // var listType = [].obs;
  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user =
        jsonDecode(prefs.getString('user') ?? "") as Map<String, dynamic>;
    var token = user['accessToken'];

    try {
      var url = Uri.parse('https://simaru.amisbudi.cloud/api/categories');
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      // if (response.statusCode == 200) {
      //   final List<dynamic> data = json.decode(response.body)['data'];
      //   roomList.value = data.map((room) => Room.fromJson(room)).toList();
      // } else {
      //   Get.snackbar('Error', 'Failed to fetch todos: ${response.body}');
      // }

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        // final categories = data.map((category) => Category.fromJson(category));
        // print(categories);
        // roomList.value = categories.toList();
        roomList.value =
            data.map((category) => Category.fromJson(category)).toList();
      } else {
        print('Failed to load todos');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }
}
