import 'package:get/get.dart';

import '../work_first/work_first_logic.dart';
import '../work_second/work_second_logic.dart';
import '../work_third/work_third_logic.dart';
import 'work_tab_logic.dart';

class WorkTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WorkTabLogic());
    Get.lazyPut(() => WorkFirstLogic());
    Get.lazyPut(() => WorkSecondLogic());
    Get.lazyPut(() => WorkThirdLogic());
  }
}
