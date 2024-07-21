import 'package:get/get.dart';

import 'work_third_logic.dart';

class WorkThirdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WorkThirdLogic());
  }
}
