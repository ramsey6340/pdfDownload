import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../controllers/global_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../style/constantes.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    globalController.firebaseAuth
        .userChanges()
        .listen((User? user) {
      if (user == null) {
      } else {
        Get.toNamed(Routes.HOME);
        globalController.setCurrentUser(user);
      }
    });

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Image.asset("assets/images/logo64.png"),
            const Text("Rejoingnez-nous pour télécharger et partager des documents"
                " sur n'importe quelle domaine educative.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,),
            const SizedBox(height: 80),
            ElevatedButton.icon(
              onPressed: () {
                controller.setLoginPageType(LoginPageType.signUp);
                Get.toNamed('/signView');
                },
              icon: const Icon(Icons.email),
              label: const Text("S'inscrire"),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                controller.setLoginPageType(LoginPageType.signIn);
                Get.toNamed('/signView');
                },
              icon: const Icon(Icons.email),
              label: const Text("Se connécter"),
            ),
          ],
        ),
      ),
    );
  }
}
