import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:some_ride/features/ongoing/controllers/ongoing_controller.dart';
import 'package:some_ride/features/ongoing/presentation/ongoing.dart';
import 'package:some_ride/features/home/controllers/home_controller.dart';
import 'package:some_ride/features/home/presentation/toggle_service.dart';
import 'package:some_ride/features/history/presentation/history.dart';
import 'package:some_ride/features/profile/presentation/profile.dart';
import 'package:some_ride/features/wallet/presentation/wallet.dart';

class HomeLanding extends StatelessWidget {
  HomeLanding({super.key});

  final HomeController controller = Get.find<HomeController>();
  final onGoingController =
      Get.lazyPut<OnGoingController>(() => OnGoingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (controller.currentPage.value) {
          case 0:
            return const TogglePages();
          case 1:
            return const OnGoing();
          case 2:
            return const Wallet();
          case 3:
            return const History();
          case 4:
            return const Profile();
          default:
            return const SizedBox.shrink();
        }
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentPage.value,
          onTap: (index) {
            controller.changePage(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow),
              label: 'OnGoing',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).textTheme.bodyMedium!.color,
          unselectedItemColor: Colors.grey.withOpacity(0.6),
        ),
      ),
    );
  }
}
