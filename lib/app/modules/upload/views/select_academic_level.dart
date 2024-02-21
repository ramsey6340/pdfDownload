import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_download/app/style/constantes.dart';
import '../../../widgets/academic_level_checkbox_list_tile.dart';
import '../controllers/upload_controller.dart';

class SelectAcademicLevel extends StatelessWidget {
  SelectAcademicLevel({Key? key}) : super(key: key);
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
                if (controller.selectedAcademicLevel.isEmpty) {
                  Get.snackbar("Erreur", "Selectionner au moins un niveau academic",
                      snackPosition: SnackPosition.BOTTOM);
                } else {
                  Get.toNamed('/selectPdf');
                }
              },
              child: const Text("Suivant"))
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Text(
            "Niveaux academiques du documents",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
            itemCount: kAcademicLevelList.length,
            itemBuilder: (context, index) {
              return AcademicLevelCheckboxListTile(
                academicLevel: kAcademicLevelList[index],
                controller: controller,
              );
            }),
      ),
    );
  }
}
