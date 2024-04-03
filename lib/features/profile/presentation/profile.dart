import 'package:flutter/material.dart';
import 'package:some_ride/features/authentication/services/firebase_services.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings page
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirmation"),
                    content: const Text("Are you sure you want to log out?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          AuthController.instance.signOut();
                        },
                        child: const Text("Yes"),
                      ),
                      TextButton(
                        onPressed: () {
                          // Cancel log out action
                          Navigator.of(context).pop();
                        },
                        child: const Text("No"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Profile"),
            ],
          ),
        ],
      ),
    );
  }
}
