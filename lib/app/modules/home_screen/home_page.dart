import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing1/app/modules/profile_screen/profile_page.dart';
import 'package:testing1/app/modules/room_screen/room_page.dart';
import 'package:testing1/app/modules/categories_screen/category_page.dart';
import 'package:testing1/app/modules/bookings_screen/booking_page.dart';
import 'home_controller.dart';
import '../setting_screen/settings_page.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  final List<Widget> pages = [
    const Center(
        child: Text("Welcome to the Home Page!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
    // const Center(
    //     child: Text("This is the Profile Page.",
    //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
    // ProductPage(),
    BookingPage(),
    RoomPage(),
    // CategoryPage(),
    ProfilePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    homeController.loadUser();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text("Welcome ${homeController.profile.value.name}!")),
      ),
      body: Obx(() => pages[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: "Booking",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.room_preferences),
              label: "Room",
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.category),
            //   label: "Category",
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
          selectedItemColor: Colors.blue[800],
        ),
      ),
    );
  }
}
