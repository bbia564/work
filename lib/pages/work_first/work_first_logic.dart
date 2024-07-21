import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:work_summary/db_work/db_work.dart';
import 'package:work_summary/db_work/work_entity.dart';
import 'package:work_summary/main.dart';
import 'package:work_summary/pages/work_first/work_text_field.dart';

class WorkFirstLogic extends GetxController {
  DBWork dbWork = Get.find<DBWork>();

  var threeNumList = [0, 0, 0];

  var list = <WorkEntity>[].obs;

  String title = '';
  String content = '';

  List<WorkEntity> getThisWeekEntities(List<WorkEntity> workEntities) {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 7));

    return workEntities
        .where((entity) =>
            entity.createdTime.isAfter(startOfWeek) &&
            entity.createdTime.isBefore(endOfWeek))
        .toList();
  }

  List<WorkEntity> getThisMonthEntities(List<WorkEntity> workEntities) {
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 1);

    return workEntities
        .where((entity) =>
            entity.createdTime.isAfter(startOfMonth) &&
            entity.createdTime.isBefore(endOfMonth))
        .toList();
  }

  void getData() async {
    final result = await dbWork.getWorksData();
    list.value = result.where((e) => e.type == 0).toList();
    final todayList = list.value
        .where((e) =>
            e.createdTime.year == DateTime.now().year &&
            e.createdTime.month == DateTime.now().month &&
            e.createdTime.day == DateTime.now().day)
        .toList();
    List<WorkEntity> thisWeekEntities = getThisWeekEntities(list.value);
    List<WorkEntity> thisMonthEntities = getThisMonthEntities(list.value);
    threeNumList = [
      todayList.length,
      thisWeekEntities.length,
      thisMonthEntities.length
    ];
    update();
  }

  void addWorkSummary(BuildContext context) {
    Get.bottomSheet(
        Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          height: 400,
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: <Widget>[
                <Widget>[
                  const Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ).gestures(onTap: () {
                    Get.back();
                  }),
                  const Text(
                    'Add job summary',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Commit',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ).gestures(onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (title.isEmpty || content.isEmpty) {
                      Fluttertoast.showToast(msg: 'Please fill in the information completely');
                      return;
                    }
                    await dbWork.dbBase.insert('work', {
                      'createdTime': DateTime.now().toIso8601String(),
                      'type': 0,
                      'title': title,
                      'content': content,
                      'scheduleTime': DateTime.now().toIso8601String()
                    });
                    title = '';
                    content = '';
                    getData();
                    Get.back();
                  })
                ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                Divider(
                  height: 20,
                  color: Colors.grey.withOpacity(0.3),
                ),
                <Widget>[
                  const Text(
                    'Summary name',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: WorkTextField(
                        padding: EdgeInsets.zero,
                        maxLength: 20,
                        value: title,
                        onChange: (value) {
                          title = value;
                        }),
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Summary content',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: WorkTextField(
                        padding: EdgeInsets.zero,
                        maxLength: 500,
                        maxLines: 5,
                        value: content,
                        onChange: (value) {
                          content = value;
                        }),
                  ),
                ].toColumn(crossAxisAlignment: CrossAxisAlignment.start)
              ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
            ),
          ),
        ).decorated(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        enterBottomSheetDuration: const Duration(milliseconds: 200),
        exitBottomSheetDuration: const Duration(milliseconds: 200));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }
}
