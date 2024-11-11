import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing1/app/modules/profile_page.dart';
import 'home_controller.dart';
import 'settings_page.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  final List<Widget> pages = [
    const Center(
        child: Text("Welcome to the Home Page!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
    // const Center(
    //     child: Text("This is the Profile Page.",
    //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
    ProfilePage(),
    SettingsPage(),
    const Center(
        child: Text("This is the Profile Page.",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
    // Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       const Text(
    //         "Settings Page",
    //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //       ),
    //       const SizedBox(height: 20),
    //       ElevatedButton(
    //         onPressed: () {
    //           Get.find<LoginController>().logout(); // Call logout method
    //         },
    //         style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
    //         child: const Text("Logout", style: TextStyle(color: Colors.white)),
    //       ),
    //     ],
    //   ),
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    homeController.loadUser();
    return Scaffold(
      appBar: AppBar(
        title: Obx(
            () => Text("Welcome ${homeController.profile.value.firstName}")),
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
              icon: Icon(Icons.person),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: "Account",
            ),
          ],
          selectedItemColor: Colors.blue[800],
        ),
      ),
    );
  }
}
