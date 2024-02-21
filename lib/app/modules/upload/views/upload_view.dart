import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_download/app/data/datatest.dart';
import '../../../widgets/cat_checkbox_list_tile.dart';
import '../controllers/upload_controller.dart';

class UploadView extends StatelessWidget {
  UploadView({Key? key}) : super(key: key);
  final controller = Get.put(UploadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un document'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                if (controller.selectedTypes.isEmpty) {
                  Get.snackbar("Erreur", "Selectionner au moins un type",
                      snackPosition: SnackPosition.BOTTOM);
                } else {
                  Get.toNamed('/selectAcademicLevel');
                }
              },
              child: const Text("Suivant"))
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Text(
            "Types du documents",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
            itemCount: docTypes.length,
            itemBuilder: (context, index) {
              return CatCheckboxListTile(
                docType: docTypes[index],
                controller: controller,
              );
            }),
      ),
    );
  }
}
