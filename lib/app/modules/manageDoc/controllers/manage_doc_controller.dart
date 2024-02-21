import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../../style/constantes.dart';

class ManageDocController extends GetxController {
  //TODO: Implement ManageDocController

  final db = FirebaseFirestore.instance;
  final dbStorage = FirebaseStorage.instance;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  acceptDoc(String? pdfId) {
    final docRef = db.collection(CollectionNames.documents.name).doc(pdfId);
    docRef.update({"status": DocStatus.ok.name});
  }

  refuseDoc(String? pdfId, String fileName) async {
    db.collection(CollectionNames.documents.name).doc(pdfId).delete();
    final docRef = dbStorage.ref().child("${CollectionNames.processing.name}/$fileName");
    await docRef.delete();
  }

}
