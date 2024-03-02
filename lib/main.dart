import 'package:flutter/material.dart';
import 'package:flutter_app/screen/login.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Alfian',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 48, 116, 233)),
        useMaterial3: true,
      ),
      home: Login(),
    );
  }
}
