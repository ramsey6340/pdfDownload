import 'package:get/get.dart';

import '../controllers/safeguard_controller.dart';

class SafeguardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SafeguardController>(
      () => SafeguardController(),
    );
  }
}
