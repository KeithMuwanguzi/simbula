import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:some_ride/features/authentication/services/firebase_services.dart';
import 'package:some_ride/util/bindings/internetbinding.dart';
import 'package:some_ride/util/bindings/pages.dart';
import 'package:some_ride/util/theme/themedata.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then(
    (value) => Get.put(
      AuthController(),
    ),
  );
  runApp(const MyApp());
  InternetBinding.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MyAppTheme.lightTheme,
      darkTheme: MyAppTheme.darkTheme,
      getPages: getpages,
    );
  }
}
