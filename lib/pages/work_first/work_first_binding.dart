import 'package:get/get.dart';

import 'work_first_logic.dart';

class WorkFirstBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WorkFirstLogic());
  }
}
