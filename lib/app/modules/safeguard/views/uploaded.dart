import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import '../../../models/pdf.dart';
import '../../../style/constantes.dart';
import '../../../widgets/doc_skeleton.dart';
import '../../../widgets/list_tile_pdf.dart';
import '../controllers/safeguard_controller.dart';

class Uploaded extends StatelessWidget {
  Uploaded({super.key});

  final controller = Get.put(SafeguardController());

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> uploadDocumentsStream =
    controller.db.collection(CollectionNames.documents.name).where("supplierId", isEqualTo: '1').snapshots();

    return SafeArea(
        child: StreamBuilder(
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

