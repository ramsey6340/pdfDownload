import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

import '../style/constantes.dart';

class GlobalController extends GetxController {
  //TODO: Implement GlobalController

  final userRole = Role.admin.name.obs;
  final userCredential = Rx<UserCredential?>(null);

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

  void setRole(String role) {
    userRole(role);
  }

  void openPDF(String pdfUrl) async {
    // Utilisez la fonction openFile du package open_file pour ouvrir le fichier PDF
    await OpenFile.open(pdfUrl);
  }

  void openPDFForWeb(String pdfUrl) {
    window.open(pdfUrl, '_blank');
  }

  void setUserCredential(UserCredential? credential) {
    userCredential(credential);
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
