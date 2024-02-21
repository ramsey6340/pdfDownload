import 'package:get/get.dart';

import '../controllers/shared_controller.dart';

class SharedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SharedController>(
      () => SharedController(),
    );
  }
}
