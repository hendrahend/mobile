import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'card_controller.dart';

class CardListScreen extends StatelessWidget {
  final CardController controller = Get.put(CardController());

  @override
  Widget build(BuildContext context) {
    // Fetch todos when the widget is loaded
    controller.getDataTodos();

    return Scaffold(
      body: Obx(() {
        if (controller.itemList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: controller.itemList.length,
          itemBuilder: (context, index) {
            final item = controller.itemList[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              color: item.completed ? Colors.green[100] : Colors.red[100],
              child: ListTile(
                title: Text(item.todo),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    controller.itemList.removeAt(index);
                  },
                ),

                // subtitle: Text(
                //   item.completed ? 'Completed' : 'Incomplete',
                //   style: TextStyle(
                //     color: item.completed ? Colors.green : Colors.red,
                //   ),
                // ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Optionally add new items manually
          controller.itemList.add(
            Item(
                todo: "New Task ${controller.itemList.length}",
                completed: false),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
