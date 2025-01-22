import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing1/app/modules/categories_screen/category_controller.dart';

class CategoryPage extends StatelessWidget {
  final CategoryController controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    // Fetch todos when the widget is loaded
    controller.getData();

    return Scaffold(
      body: Obx(() {
        if (controller.roomList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: controller.roomList.length,
          itemBuilder: (context, index) {
            final room = controller.roomList[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(room.name),
              ),
            );
          },
        );
      }),
    );
  }
}
