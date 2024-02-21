import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_download/app/models/docType.dart';
import '../modules/upload/controllers/upload_controller.dart';

class CatCheckboxListTile extends StatelessWidget {
  CatCheckboxListTile({
    super.key,
    required this.docType,
    required this.controller
  });
  final DocType docType;

  final UploadController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onTap: (){
          if(!controller.selectedTypes.contains(docType.name)){
            controller.addType(docType.name);
          }
          else{
            controller.removeType(docType.name);
          }
        },
        leading: Image.asset(docType.image),
        title: Text(docType.name),
        trailing: Obx(() => Checkbox(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          value: controller.selectedTypes.contains(docType.name),
          onChanged: (value) {
            (value==true)?controller.addType(docType.name):controller.removeType(docType.name);
          },
        )),
      ),
    );
  }
}