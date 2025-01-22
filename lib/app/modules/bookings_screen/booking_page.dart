import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'booking_controller.dart';

class BookingPage extends StatelessWidget {
  final BookingController controller = Get.put(BookingController());

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
              "Booking Management",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.bookingList.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                itemCount: controller.bookingList.length,
                itemBuilder: (context, index) {
                  final room = controller.bookingList[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        "Booking ID: ${room.id}",
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Booking Date: ${room.bookingDate}'),
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
                              await controller.deleteBooking(room.id);
                              controller.bookingList.removeAt(index);
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
      BuildContext context, BookingController controller, Booking booking) {
    final bookingDateController = TextEditingController();
    int? selectedroomId = booking.roomId;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Room'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: bookingDateController,
                  decoration: const InputDecoration(labelText: 'Booking Date'),
                  readOnly: true,
                  onTap: () async {},
                ),
                // Add other fields as needed
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
                try {
                  DateTime bookingDate =
                      DateTime.parse(bookingDateController.text);
                  Map<String, dynamic> bookingData = {
                    "id": booking.id,
                    "bookingDate": bookingDate.toIso8601String(),
                    "roomId": selectedroomId,
                    // Add other fields as needed
                  };
                  await controller.updateBooking(bookingData);
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

  void _showAddRoomPopup(BuildContext context, BookingController controller) {
    final TextEditingController bookingDateController = TextEditingController();
    int? selectedRoomId;

    controller.getRoom();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Create New Booking"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Obx(() {
                //   // Ensure the dropdown shows only when room data is available
                //   if (controller.bookingList.isEmpty) {
                //     return const CircularProgressIndicator();
                //   }
                //   return DropdownButtonFormField<int>(
                //     decoration: const InputDecoration(
                //       labelText: "Room ID",
                //       border: OutlineInputBorder(),
                //     ),
                //     items: controller.bookingList.map((booking) {
                //       return DropdownMenuItem<int>(
                //         value: booking.roomId,
                //         child: Text('Room ${booking.roomId}'),
                //       );
                //     }).toList(),
                //     onChanged: (value) {
                //       selectedRoomId = value;
                //     },
                //   );
                // }),
                Obx(() {
                  return DropdownButtonFormField<int>(
                    decoration: const InputDecoration(
                      labelText: "Room",
                      border: OutlineInputBorder(),
                    ),
                    items: controller.rooms.map((room) {
                      return DropdownMenuItem<int>(
                        value: room['id'],
                        child: Text(room['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedRoomId = value;
                    },
                    value: selectedRoomId,
                  );
                }),
                const SizedBox(height: 10),
                TextField(
                  controller: bookingDateController,
                  decoration: const InputDecoration(
                    labelText: "Booking Date",
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      bookingDateController.text =
                          selectedDate.toIso8601String().split('T').first;
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (selectedRoomId == null ||
                    bookingDateController.text.isEmpty) {
                  Get.snackbar("Error", "Please fill in all fields.");
                  return;
                }
                try {
                  await controller.addBooking({
                    "roomId": selectedRoomId,
                    "bookingDate": bookingDateController.text,
                  });
                  Navigator.of(context).pop();
                } catch (e) {
                  Get.snackbar("Error", "Failed to create booking: $e");
                }
              },
              child: const Text("Create"),
            ),
          ],
        );
      },
    );
  }
}
