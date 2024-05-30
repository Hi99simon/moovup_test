import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:moovup_test/controller/data_controller.dart';
import 'package:moovup_test/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initControllers();
  runApp(const MyApp());
}

initControllers() {
  Get.put(DataController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIMON TEST',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
