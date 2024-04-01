import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:some_ride/util/bindings/internetbinding.dart';
import 'package:some_ride/util/bindings/pages.dart';
import 'package:some_ride/util/theme/themedata.dart';

void main() {
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
      initialRoute: '/',
    );
  }
}
