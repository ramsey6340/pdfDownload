import 'dart:math';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../style/constantes.dart';

class UploadController extends GetxController {
  //TODO: Implement UploadController

  final selectedTypes = <String>[].obs;
  final selectedAcademicLevel = <String>[].obs;
  final fileBytes = Uint8List(0).obs;
  final fileName = "".obs;
  final fileSize = "".obs;
  final fileExtension = "".obs;
  final filePath = "".obs;
  final uploaded = UploadStatus.finished.obs;
  final adminEmail = "".obs;
  final uploadProgress = Rx<double?>(null);

  final db = FirebaseFirestore.instance;
  final dbStorage = FirebaseStorage.instance;
  TextEditingController publicationYearController = TextEditingController();
  TextEditingController authorNameController = TextEditingController();
  TextEditingController commentController = TextEditingController();

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

  void addType(String type) => selectedTypes.add(type);
  void removeType(String type) => selectedTypes.remove(type);

  void addAcademicLevel(String level) => selectedAcademicLevel.add(level);
  void removeAcademicLevel(String level) => selectedAcademicLevel.remove(level);

  void updateFileBytes(Uint8List bytes) => fileBytes(bytes);
  void updateFileName(String name) => fileName(name);
  void updateFileExtension(String? extension) => fileExtension(extension);
  void updateFilePath(String? path) => filePath(path);

  void updateFileSize(int size) {
    if((size/pow(2, 10))<0.1){
      fileSize("${(size/pow(2, 10)).toStringAsFixed(2)} Ko");
    }
    else{
      fileSize("${(size/pow(2, 20)).toStringAsFixed(2)} Mo");
    }
  }

  void updateUploaded(UploadStatus value) => uploaded(value);

  void chooseAdmin() {
    print("Dans Choose");
    final docRef = db.collection(CollectionNames.admins.name).doc("emails");
    docRef.get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        dynamic emails = data['emails'] ?? [];

        Random random = Random();
        // Obtenez une valeur aléatoire dans le tableau
        String randomEmail = emails[random.nextInt(emails.length)];
        adminEmail(randomEmail);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  void showProgressDialog() {
    Get.defaultDialog(
      title: 'Progression',
      content: Obx(() {
        double progress = uploadProgress.value ?? 0.0;

        if (progress == 1.0) {
          Get.back();
        }
        return Column(
          children: [
            Text('${(progress * 100).toStringAsFixed(2)}%',
              style: const TextStyle(color: kPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),),
            const SizedBox(height: 20),
            CircularProgressIndicator(value: progress),
          ],
        );
      }),
      barrierDismissible: false,
    );
  }
}
