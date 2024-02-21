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
    return Drawer(
        child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
                child: DrawerHeader(
                  margin: const EdgeInsets.all(0.0),
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: (globalController.userCredential.value!=null)?Center(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        child: Text('${globalController.userCredential.value?.user!.email?[0].toUpperCase()}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
                      title: Text('${globalController.userCredential.value?.user?.email}'
                        , style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    ),
                  ):const SizedBox(),
                ),
              ),
              const SizedBox(height: 20,),
              if(globalController.userRole.value == Role.admin.name)
                TextButton.icon(onPressed: (){
                  Get.toNamed(Routes.MANAGE_DOC);
                }, icon: const Icon(Icons.description),
                    label: const Text("Nouveau document",)),

              TextButton.icon(onPressed: (){}, icon: const Icon(Icons.logout, color: Colors.red,),
                  label: const Text("Se deconnecter", style: TextStyle(color: Colors.red),)),
            ]
        )
    );
  }
}