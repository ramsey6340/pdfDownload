import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_download/app/controllers/global_controller.dart';
import 'package:pdf_download/app/models/pdf.dart';
import 'package:pdf_download/app/modules/manageDoc/controllers/manage_doc_controller.dart';
import '../modules/download/controllers/download_controller.dart';
import '../style/constantes.dart';

class ListTileManageDoc extends StatelessWidget {
  ListTileManageDoc({
    super.key,
    required this.pdf,
  });
  final PDF pdf;
  final controller = Get.put(ManageDocController());
  final globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListTile(
          onTap: (){
            if(!kIsWeb) {
              globalController.openPDF(pdf.fileUrl);
            }
            else{
              globalController.openPDFForWeb(pdf.fileUrl);
            }
          },
          leading: Image.asset((pdf.extension == 'pdf')
              ? "assets/images/pdf36.png"
              : (pdf.extension == 'docx')
              ? "assets/images/docx36.png"
              : "assets/images/ppt36.png"),
          title: Text(
            pdf.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('${pdf.size} Mo'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: (){
                    Get.defaultDialog(
                      title: "Confirmation",
                      middleText: "Êtes-vous sûr de voloir refuire ce document ?",
                      actions: [
                        TextButton(
                          onPressed: (){
                            controller.refuseDoc(pdf.id, pdf.title);
                            Get.back();
                          },
                          child: const Text("Oui", style: TextStyle(color: Colors.blue),),
                        ),
                        TextButton(
                          onPressed: (){
                            Get.back();
                            },
                          child: const Text("Nom", style: TextStyle(color: Colors.red),),
                        )
                      ]
                    );
                  },
                  icon: const Icon(Icons.cancel, color: Colors.red)
              ),
              const SizedBox(width: 5),
              IconButton(
                  onPressed: (){
                    controller.acceptDoc(pdf.id);
                  },
                  icon: const Icon(Icons.check_circle, color: Colors.green)
              )
            ],
          ),
        ),
        const Divider(indent: kDividerIndent, endIndent: kDividerIndent),
      ],
    );
  }
}
