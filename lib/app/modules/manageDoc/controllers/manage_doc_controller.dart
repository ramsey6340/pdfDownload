import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import '../../../controllers/global_controller.dart';
import '../../../style/constantes.dart';

class ManageDocController extends GetxController {
  //TODO: Implement ManageDocController

  final db = FirebaseFirestore.instance;
  final dbStorage = FirebaseStorage.instance;
  final globalController = Get.put(GlobalController());
  final nbDocs = 0.obs;

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

  acceptDoc(String? pdfId) async {
    final docRef = db.collection(CollectionNames.documents.name).doc(pdfId);
    docRef.update({"status": DocStatus.ok.name});
    await countDocumentsInCollection(CollectionNames.documents.name);
    print('Dans Accept : ${nbDocs.value}');
  }

  refuseDoc(String? pdfId, String fileName) async {
    db.collection(CollectionNames.documents.name).doc(pdfId).delete();
    final docRef = dbStorage.ref().child("${CollectionNames.documents.name}/$fileName");
    await docRef.delete();
    await countDocumentsInCollection(CollectionNames.documents.name);
    print('Dans Refuse : ${nbDocs.value}');
  }

  Future<void> countDocumentsInCollection(String collectionName) async {
    try {
      QuerySnapshot querySnapshot = await db.collection(collectionName)
          .where("validatorEmail", isEqualTo: globalController.currentUSer.value?.email)
          .where("status", isEqualTo: DocStatus.traitement.name).get();
      nbDocs.value = querySnapshot.size;
      print('Dans Count : ${nbDocs.value}');
    } catch (e) {
      print("Error counting documents: $e");
    }
  }

}
