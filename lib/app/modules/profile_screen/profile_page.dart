import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing1/app/modules/btn.dart';
import 'package:testing1/app/modules/home_screen/home_controller.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    homeController.loadUser();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Profile Page",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Obx(() => CircleAvatar(
                radius: 50,
                backgroundImage: homeController.profile.value.image.isNotEmpty
                    ? NetworkImage(homeController.profile.value.image)
                    : const NetworkImage(
                            'https://th.bing.com/th/id/OIP.Cl56H6WgxJ8npVqyhefTdQHaHa?w=203&h=203&c=7&r=0&o=5&dpr=1.3&pid=1.7')
                        as ImageProvider,
              )),
          const SizedBox(height: 20),
          Obx(() => CustomTextField(
                label: 'Username',
                hintText: 'Username',
                icon: Icons.abc_sharp,
                text: '${homeController.profile.value.name}',
              )),
          const SizedBox(height: 20),
          Obx(() => CustomTextField(
                label: 'Full Name',
                hintText: 'Full Name',
                icon: Icons.person,
                text:
                    '${homeController.profile.value.firstName} ${homeController.profile.value.lastName}',
              )),
          const SizedBox(height: 20),
          Obx(() => CustomTextField(
                label: 'Email',
                hintText: 'Email',
                icon: Icons.email,
                text: '${homeController.profile.value.email}',
              )),
          const SizedBox(height: 20),
          Obx(() => CustomTextField(
                label: 'Gender',
                hintText: 'Gender',
                icon: Icons.people,
                text: '${homeController.profile.value.gender}',
              )),
        ],
      ),
    );
  }
}
