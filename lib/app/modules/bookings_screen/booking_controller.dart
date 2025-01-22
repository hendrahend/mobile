import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Booking {
  int id;
  int roomId;
  int userId;
  String bookingDate;

  Booking({
    required this.id,
    required this.roomId,
    required this.userId,
    required this.bookingDate,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
        id: json['id'],
        userId: json['userId'],
        roomId: json['roomId'],
        bookingDate: json['bookingDate']);
  }
}

class BookingController extends GetxController {
  var bookingList = <Booking>[].obs;
  var rooms = <Map<String, dynamic>>[].obs;

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user =
        jsonDecode(prefs.getString('user') ?? "") as Map<String, dynamic>;
    var token = user['accessToken'];

    try {
      var url = Uri.parse('https://simaru.amisbudi.cloud/api/bookings');
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        // print(response.body);
        final List<dynamic> data = json.decode(response.body)['data'];
        bookingList.value =
            data.map((bookings) => Booking.fromJson(bookings)).toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }

  Future<void> addBooking(Map<String, dynamic> roomData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user =
        jsonDecode(prefs.getString('user') ?? "") as Map<String, dynamic>;
    var token = user['accessToken'];

    try {
      var url = Uri.parse('https://simaru.amisbudi.cloud/api/bookings');
      // print('Room Data: $roomData');
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
        Get.snackbar('Success', 'Booking added successfully!');
        await getData();
        Get.back();
      } else {
        Get.snackbar('Error', 'Failed to add booking: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }

  Future<void> updateBooking(Map<String, dynamic> bookingData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user =
        jsonDecode(prefs.getString('user') ?? "") as Map<String, dynamic>;
    var token = user['accessToken'];

    try {
      var url = Uri.parse(
          'https://simaru.amisbudi.cloud/api/bookings/${bookingData['id']}');
      // print('Booking Data: $bookingData');
      http.Response response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(bookingData),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Booking updated successfully!');
        await getData();
      } else {
        Get.snackbar('Error', 'Failed to update booking: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }

  Future<void> deleteBooking(int id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final user =
          jsonDecode(prefs.getString('user') ?? "") as Map<String, dynamic>;
      var token = user['accessToken'];

      var url = Uri.parse('https://simaru.amisbudi.cloud/api/bookings/$id');
      http.Response response = await http.delete(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        Get.snackbar('Success', "Booking deleted successfully!");
        Get.back();
      } else {
        Get.snackbar('Error', 'Failed to delete booking: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }

  Future<void> getRoom() async {
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
        print(response.body);
        final List<dynamic> data = json.decode(response.body)['data'];
        rooms.value = data.map((room) => room as Map<String, dynamic>).toList();
      } else {
        print('Failed to load rooms');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }
}
