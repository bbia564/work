import 'package:get/get.dart';

import 'logic.dart';

class WRBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
