import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Room {
  int id;
  String name;
  String description;
  int categoryId;
  int price;
  int capacity;

  Room(
      {required this.id,
      required this.name,
      required this.price,
      required this.capacity,
      required this.description,
      required this.categoryId});

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        capacity: json['capacity'],
        description: json['description'],
        categoryId: json['categoryId']);
  }
}

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

class RoomController extends GetxController {
  var roomList = <Room>[].obs;
  var categories = <Map<String, dynamic>>[].obs;

  var categoryList = <Category>[].obs; // List of categories

  // Method to get category name by categoryId
  String getCategoryName(int categoryId) {
    final category = categoryList.firstWhere(
      (cat) => cat.id == categoryId,
    );
    return category.name;
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user =
        jsonDecode(prefs.getString('user') ?? "") as Map<String, dynamic>;
    var token = user['accessToken'];

    try {
      var url = Uri.parse('https://simaru.amisbudi.cloud/api/rooms');
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        roomList.value = data.map((room) => Room.fromJson(room)).toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch todos: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }

  Future<void> addRoom(Map<String, dynamic> roomData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user =
        jsonDecode(prefs.getString('user') ?? "") as Map<String, dynamic>;
    var token = user['accessToken'];

    try {
      var url = Uri.parse('https://simaru.amisbudi.cloud/api/rooms');
      print('Room Data: $roomData');
      http.Response response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(roomData),
      );

      if (response.statusCode == 201) {
        // Optionally, you can refresh the room list or navigate back
        Get.snackbar('Success', 'Room added successfully!');
        await getData();
        Get.back();
      } else {
        Get.snackbar('Error', 'Failed to add room: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }

  Future<void> updateRoom(Map<String, dynamic> roomData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user =
        jsonDecode(prefs.getString('user') ?? "") as Map<String, dynamic>;
    var token = user['accessToken'];

    try {
      var url = Uri.parse(
          'https://simaru.amisbudi.cloud/api/rooms/${roomData['id']}');
      print('Room Data: $roomData');
      http.Response response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(roomData),
      );

      if (response.statusCode == 200) {
        // Optionally, you can refresh the room list or navigate back
        Get.snackbar('Success', 'Room updated successfully!');
        await getData();
      } else {
        Get.snackbar('Error', 'Failed to add room: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }

  Future<void> deleteRoom(int id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final user =
          jsonDecode(prefs.getString('user') ?? "") as Map<String, dynamic>;
      var token = user['accessToken'];

      var url = Uri.parse('https://simaru.amisbudi.cloud/api/rooms/$id');
      http.Response response = await http.delete(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        Get.snackbar('Success', "Room deleted successfully!");
        Get.back();
      } else {
        Get.snackbar('Error', 'Failed to delete room: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }

  Future<void> getCategory() async {
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
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        categories.value =
            data.map((category) => category as Map<String, dynamic>).toList();
      } else {
        print('Failed to load categories');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }
}
