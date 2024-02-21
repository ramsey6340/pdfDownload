import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pdf_download/app/modules/download/views/download_view.dart';
import 'package:pdf_download/app/modules/safeguard/views/safeguard_view.dart';
import 'package:pdf_download/app/modules/shared/views/shared_view.dart';
import 'package:pdf_download/app/modules/upload/views/upload_view.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../style/constantes.dart';

class HomeController extends GetxController {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);
  //TODO: Implement HomeController

  final count = 0.obs;
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

  void increment() => count.value++;


  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_filled),
        title: "Home",
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: kInactiveColorPrimary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.add),
        title: "Add",
        activeColorPrimary: kPrimaryColor,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: kInactiveColorPrimary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.folder),
        title: "Partages",
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: kInactiveColorPrimary,
      ),
    ];
  }

  List<Widget> buildScreens() {
    return [
      DownloadView(),
      UploadView(),
      SharedView()
    ];
  }
}
