import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/controllers/global_controller.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final globalController = Get.put(GlobalController());

  runApp(
    GetMaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      title: "Application",
      initialRoute: (globalController.userCredential.value != null)?Routes.HOME:Routes.LOGIN,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
