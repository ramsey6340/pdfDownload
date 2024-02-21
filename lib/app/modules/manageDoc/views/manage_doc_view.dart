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
import '../../../widgets/list_tile_manage_doc.dart';
import '../controllers/manage_doc_controller.dart';

class ManageDocView extends StatelessWidget {
  ManageDocView({Key? key}) : super(key: key);

  final controller = Get.put(ManageDocController());
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

    final Stream<QuerySnapshot> documentsStream =
    controller.db.collection(CollectionNames.documents.name)
        .where("validatorEmail", isEqualTo: globalController.currentUSer.value?.email)
        .where("status", isEqualTo: DocStatus.traitement.name).snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Documents partagés'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: StreamBuilder(
          stream: documentsStream,
          builder: (context, snapshot) {
            if(snapshot.hasData && snapshot.data != null) {
              final docs = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final docMap = docs[index]
                    as DocumentSnapshot<Map<String, dynamic>>;
                    final document = PDF.fromFirestore(docMap, null);

                    return ListTileManageDoc(pdf: document);
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
          }),
    );
  }
}
