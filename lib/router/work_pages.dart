
import 'package:get/get.dart';
import 'package:work_summary/pages/work_first/work_first_details/work_first_details_binding.dart';
import 'package:work_summary/pages/work_first/work_first_details/work_first_details_view.dart';
import 'package:work_summary/pages/work_tab/work_tab_binding.dart';
import 'package:work_summary/pages/work_tab/work_tab_view.dart';
import 'package:work_summary/router/work_names.dart';

import '../pages/work_first/work_first_binding.dart';
import '../pages/work_first/work_first_view.dart';
import '../pages/work_second/work_second_binding.dart';
import '../pages/work_second/work_second_view.dart';
import '../pages/work_third/work_third_binding.dart';
import '../pages/work_third/work_third_view.dart';


class WorkPages {

  static pageBuilder({
    required String name,
    required GetPageBuilder page,
    Bindings? binding,
  }) {
    return GetPage(
      name: name,
      page: page,
      binding: binding,
      preventDuplicates: true,
      transition: Transition.cupertino,
      popGesture: true,
    );
  }

  static List<GetPage> list = [
    pageBuilder(name: WorkNames.workTab, page: () => WorkTabPage(), binding: WorkTabBinding()),
    pageBuilder(name: WorkNames.workFirst, page: () => WorkFirstPage(), binding: WorkFirstBinding()),
    pageBuilder(name: WorkNames.workSecond, page: () => WorkSecondPage(), binding: WorkSecondBinding()),
    pageBuilder(name: WorkNames.workThird, page: () => WorkThirdPage(), binding: WorkThirdBinding()),
    pageBuilder(name: WorkNames.workFirstDetails, page: () => WorkFirstDetailsPage(),binding: WorkFirstDetailsBinding())
  ];
}