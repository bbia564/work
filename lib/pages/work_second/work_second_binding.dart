import 'package:get/get.dart';

import 'work_second_logic.dart';

class WorkSecondBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WorkSecondLogic());
  }
}
