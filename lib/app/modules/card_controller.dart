import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class Item {
  String todo;
  bool completed;

  Item({required this.todo, required this.completed});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(todo: json['todo'], completed: json['completed']);
  }
}

class CardController extends GetxController {
  var itemList = <Item>[].obs;

  Future<void> getDataTodos() async {
    try {
      var url = Uri.parse('https://dummyjson.com/todos?limit=10&skip=3');
      var response =
          await http.get(url); // Use GET instead of POST for fetching todos

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        // Extract todos and map to a list of Item objects
        List todos = data['todos'] ?? [];
        var fetchedItems = todos.map((json) => Item.fromJson(json)).toList();

        itemList.assignAll(fetchedItems); // Update the observable list
      } else {
        Get.snackbar('Error', 'Failed to fetch todos: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }

  // var items = <String>[].obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchItems();
  // }

  // void fetchItems() {
  //   items.addAll(List.generate(10, (index) => "Item $index"));
  // }

  // void addItem(String item) {
  //   items.add(item);
  // }

  // void removeItem(int index) {
  //   items.removeAt(index);
  // }
}
