import 'package:animeo/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/my_list_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final myListController = Get.put(MyListController());
    return GetMaterialApp(
      title: 'Animeo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xff069DEF),
        scaffoldBackgroundColor: const Color(0xFF181A20),
        backgroundColor: const Color(0xff161616),
        canvasColor: Colors.transparent,
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xff161616)),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff069DEF), brightness: Brightness.dark),
        tabBarTheme: const TabBarTheme(
          unselectedLabelColor: Color(0xff495057),
          labelColor: Color(0xff069DEF),
          indicatorSize: TabBarIndicatorSize.label,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Color(0xff069DEF), width: 2.0),
          ),
        ),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
