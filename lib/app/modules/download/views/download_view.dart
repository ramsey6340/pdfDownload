import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';
import 'package:pdf_download/app/controllers/global_controller.dart';
import 'package:pdf_download/app/style/constantes.dart';
import 'package:skeletons/skeletons.dart';
import '../../../models/pdf.dart';
import '../../../widgets/app_drawer.dart';
import '../../../widgets/doc_skeleton.dart';
import '../../../widgets/list_tile_pdf.dart';
import '../../manageDoc/controllers/manage_doc_controller.dart';
import '../controllers/download_controller.dart';

class DownloadView extends StatelessWidget {
  DownloadView({Key? key}) : super(key: key);
  final controller = Get.put(DownloadController());
  final globalController = Get.put(GlobalController());
  final manageDocController = Get.put(ManageDocController());

  @override
  Widget build(BuildContext context) {
    /*final Stream<QuerySnapshot> documentsStream =
        controller.db.collection(CollectionNames.documents.name)
            .where("status", isEqualTo: DocStatus.ok.name).snapshots();*/
    manageDocController.countDocumentsInCollection(CollectionNames.documents.name);
    return Obx(() {
      return Scaffold(
        key: controller.scaffoldKey,
        endDrawer: AppDrawer(),
        appBar: AppBar(
          title: CupertinoSearchTextField(
              controller: controller.searchTextController.value,
              onChanged: (value) {
                controller.setSearchText(value);
                print(controller.searchText.value);
              }
          ),
          actions: [
            badges.Badge(
              position: badges.BadgePosition.topStart(),
              showBadge: manageDocController.nbDocs.value > 0 && globalController.userRole.value == Role.admin.name,
              badgeContent: Text('${manageDocController.nbDocs.value}'),
              child: IconButton(
                onPressed: () {
                  controller.scaffoldKey.currentState?.openEndDrawer();
                },
                icon: const Icon(Icons.account_circle_outlined),
              ),
            )
          ],
        ),
        body: StreamBuilder(
            stream: controller.db.collection(CollectionNames.documents.name)

                .where("title", isGreaterThanOrEqualTo: 'Q')
                .snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasData && snapshot.data != null) {
                final docs = snapshot.data!.docs;

                return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final docMap = docs[index];
                      final document = PDF.fromFirestore(docMap, null);

                      return ListTilePDF(pdf: document);
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
    });

  }
}



