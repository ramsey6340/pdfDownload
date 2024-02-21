import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_download/app/controllers/global_controller.dart';
import 'package:skeletons/skeletons.dart';
import '../../../models/pdf.dart';
import '../../../routes/app_pages.dart';
import '../../../style/constantes.dart';
import '../../../widgets/doc_skeleton.dart';
import '../../../widgets/list_tile_pdf.dart';
import '../controllers/shared_controller.dart';

class SharedView extends StatelessWidget {
  SharedView({Key? key}) : super(key: key);
  final controller = Get.put(SharedController());
  final globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    globalController.firebaseAuth
        .userChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        Get.toNamed(Routes.LOGIN);
      } else {
        print('User is signed in!');
        globalController.setCurrentUser(user);
      }
    });

    final Stream<QuerySnapshot> uploadDocumentsStream =
    controller.db.collection(CollectionNames.documents.name)
        .where("supplierId", isEqualTo: globalController.currentUSer.value?.uid).snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes partages"),
        centerTitle: true,
      ),
        body: StreamBuilder(
            stream: uploadDocumentsStream,
            builder: (context, snapshot) {
              if(snapshot.hasData && snapshot.data != null) {
                final docs = snapshot.data!.docs;
                return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final docMap = docs[index]
                      as DocumentSnapshot<Map<String, dynamic>>;
                      final document = PDF.fromFirestore(docMap, null);

                      return ListTilePDF(
                        pdf: document,
                        processing: true,
                      );
                    });
              }
              else{
                return SkeletonTheme(
                  themeMode: (Get.isDarkMode)? ThemeMode.dark : ThemeMode.light,
                  shimmerGradient: (Get.isDarkMode)? kShimmerDarkGradient : kShimmerLightGradient,
                  child: Skeleton(
                    duration: const Duration(milliseconds: 800),
                    isLoading: snapshot.hasData && snapshot.data != null,
                    skeleton: const DocSkeleton(),
                    child: Container(),
                  ),
                );
              }
            }));
  }
}
