import 'dart:math';
import 'dart:html' as html;
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_download/app/style/constantes.dart';

import '../../../controllers/global_controller.dart';

class DownloadController extends GetxController {
  //TODO: Implement DownloadController

  final db = FirebaseFirestore.instance;
  final dbStorage = FirebaseStorage.instance;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final searchTextController = TextEditingController().obs;
  final searchText = ''.obs;
  final filteredDocuments = <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;
  final globalController = Get.put(GlobalController());

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

  void setSearchText(String text) {
    searchText(text);
  }

  void setFilteredDocuments(List<QueryDocumentSnapshot<Map<String, dynamic>>> documents) {
    filteredDocuments(documents);
    print(filteredDocuments.length);
  }

  Future<void> webDownloadFile(String url, String filename) async {
    try {
      final anchor = html.AnchorElement(href: url)
        ..download = filename
        ..click();
    } catch (e) {
      print('Erreur de téléchargement : $e');
    }
  }

  Future<String> getCustomDownloadDirectory() async {
    final appDirectory = await getApplicationDocumentsDirectory();
    final customDownloadDirectory = '${appDirectory.path}/pdfDownload';

    // Création du répertoire s'il n'existe pas déjà
    if (!(await Directory(customDownloadDirectory).exists())) {
      await Directory(customDownloadDirectory).create(recursive: true);
    }

    return customDownloadDirectory;
  }

  Future download(String url, String filename) async {
    /*var savePath = '/storage/emulated/0/Download/$filename';*/
    var savePath = '${await getCustomDownloadDirectory()}/$filename';
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    try {
      var response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: const Duration(seconds: 0),
        ),
      );
      var file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      debugPrint((received / total * 100).toStringAsFixed(0) + '%');
    }
  }

}
