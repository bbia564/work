import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_summary/db_work/db_work.dart';
import 'package:work_summary/db_work/work_entity.dart';
import 'package:work_summary/router/work_names.dart';

class WorkFirstDetailsLogic extends GetxController {

  WorkEntity entity = Get.arguments;

  deleteData() async {
    Get.dialog(AlertDialog(
      title: const Text('Warm reminder'),
      content: const Text('Do you want to delete this data?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel',style: TextStyle(color: Colors.black),),
        ),
        TextButton(
          onPressed: () async {
            DBWork dbWork = Get.find<DBWork>();
            await dbWork.deleteWorkData(entity.id);
            Get.until((route) => Get.currentRoute == WorkNames.workTab);
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  @override
  void onInit() {
    update();
    super.onInit();
  }

}
