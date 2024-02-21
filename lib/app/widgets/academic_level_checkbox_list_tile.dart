import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_download/app/style/constantes.dart';
import '../modules/upload/controllers/upload_controller.dart';

class AcademicLevelCheckboxListTile extends StatelessWidget {
  const AcademicLevelCheckboxListTile({
    super.key,
    required this.academicLevel,
    required this.controller
  });
  final AcademicLevel academicLevel;
  final UploadController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onTap: (){
          if(!controller.selectedAcademicLevel.contains(academicLevel.name)){
            controller.addAcademicLevel(academicLevel.name);
          }
          else{
            controller.removeAcademicLevel(academicLevel.name);
          }
        },
        title: Text(academicLevel.name.toUpperCase()),
        trailing: Obx(() => Checkbox(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          value: controller.selectedAcademicLevel.contains(academicLevel.name),
          onChanged: (value) {
            (value==true)?controller.addAcademicLevel(academicLevel.name):
            controller.removeAcademicLevel(academicLevel.name);
          },
        )),
      ),
    );
  }
}