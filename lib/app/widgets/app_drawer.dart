import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_download/app/controllers/global_controller.dart';

import '../routes/app_pages.dart';
import '../style/constantes.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({
    super.key,
  });

  final globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    globalController.firebaseAuth
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        Get.toNamed(Routes.LOGIN);
      } else {
        print('User is signed in!');
        globalController.setCurrentUser(user);
      }
    });

    return Obx(() => Drawer(
        child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
                child: DrawerHeader(
                  margin: const EdgeInsets.all(0.0),
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        child: Text('${globalController.currentUSer.value?.email?[0].toUpperCase()}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
                      title: Text('${globalController.currentUSer.value?.email}'
                        , style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              if(globalController.userRole.value == Role.admin.name)
                TextButton.icon(onPressed: (){
                  Get.toNamed(Routes.MANAGE_DOC);
                }, icon: const Icon(Icons.description),
                    label: const Text("Nouveau document",)),

              TextButton.icon(
                  onPressed: (){globalController.logout();}, icon: const Icon(Icons.logout, color: Colors.red,),
                  label: const Text("Se deconnecter", style: TextStyle(color: Colors.red),)),
            ]
        )
    ));
  }
}