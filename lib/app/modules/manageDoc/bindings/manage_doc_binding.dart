import 'package:get/get.dart';

import '../controllers/manage_doc_controller.dart';

class ManageDocBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageDocController>(
      () => ManageDocController(),
    );
  }
}
