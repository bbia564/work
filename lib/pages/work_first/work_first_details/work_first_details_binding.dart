import 'package:get/get.dart';

import 'work_first_details_logic.dart';

class WorkFirstDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WorkFirstDetailsLogic());
  }
}
