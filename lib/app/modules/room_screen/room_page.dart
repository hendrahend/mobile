import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'room_controller.dart';

class RoomPage extends StatelessWidget {
  final RoomController controller = Get.put(RoomController());

  @override
  Widget build(BuildContext context) {
    controller.getData();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Room Management",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
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
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Text(
                          room.name[0].toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        room.name.toUpperCase(),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Category: ${room.categoryId}'),
                          Text('Price: ${room.price}'),
                          Text('Capacity: ${room.capacity}'),
                          Text('Description: ${room.description}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              _showUpdateRoomPopup(context, controller, room);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await controller.deleteRoom(room.id);
                              controller.roomList.removeAt(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddRoomPopup(context, controller),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showUpdateRoomPopup(
      BuildContext context, RoomController controller, Room room) {
    final nameController = TextEditingController(text: room.name);
    final priceController = TextEditingController(text: room.price.toString());
    final capacityController =
        TextEditingController(text: room.capacity.toString());
    final descriptionController = TextEditingController(text: room.description);
    int? selectedCategoryId = room.categoryId;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Room'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: capacityController,
                  decoration: const InputDecoration(labelText: 'Capacity'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                DropdownButton<int>(
                  value: selectedCategoryId,
                  onChanged: (int? newValue) {
                    selectedCategoryId = newValue;
                  },
                  items: controller.categoryList.map((Category category) {
                    return DropdownMenuItem<int>(
                      value: category.id,
                      child: Text(category.name),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (selectedCategoryId == null) {
                  Get.snackbar('Error', 'Please select a category');
                  return;
                }

                try {
                  int price = int.parse(priceController.text);
                  int capacity = int.parse(capacityController.text);

                  Map<String, dynamic> roomData = {
                    "id": room.id,
                    "name": nameController.text,
                    "categoryId": selectedCategoryId,
                    "price": price,
                    "capacity": capacity,
                    "description": descriptionController.text,
                  };
                  await controller.updateRoom(roomData);
                  Navigator.pop(context); // Close the dialog
                } catch (e) {
                  Get.snackbar('Error', 'Invalid input: ${e.toString()}');
                }
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  void _showAddRoomPopup(BuildContext context, RoomController controller) {
    final TextEditingController nameController = TextEditingController();
    int? selectedCategoryId;
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController capacityController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    // Fetch categories before showing the popup
    controller.getCategory();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Create New Room"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Room Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() {
                  return DropdownButtonFormField<int>(
                    decoration: const InputDecoration(
                      labelText: "Category",
                      border: OutlineInputBorder(),
                    ),
                    items: controller.categories.map((category) {
                      return DropdownMenuItem<int>(
                        value: category['id'],
                        child: Text(category['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedCategoryId = value;
                    },
                    value: selectedCategoryId,
                  );
                }),
                const SizedBox(height: 10),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: "Price",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: capacityController,
                  decoration: const InputDecoration(
                    labelText: "Capacity",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (selectedCategoryId == null) {
                  Get.snackbar('Error', 'Please select a category');
                  return;
                }

                try {
                  int price = int.parse(priceController.text);
                  int capacity = int.parse(capacityController.text);

                  Map<String, dynamic> roomData = {
                    "name": nameController.text,
                    "categoryId": selectedCategoryId,
                    "price": price,
                    "capacity": capacity,
                    "description": descriptionController.text,
                  };
                  await controller.addRoom(roomData);
                  Navigator.pop(context); // Close the dialog
                } catch (e) {
                  Get.snackbar('Error', 'Invalid input: ${e.toString()}');
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
