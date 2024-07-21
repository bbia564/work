import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:work_summary/db_work/db_work.dart';
import 'package:work_summary/db_work/work_entity.dart';
import 'package:work_summary/main.dart';
import 'package:work_summary/pages/work_first/work_text_field.dart';

class WorkSecondLogic extends GetxController {
  DBWork dbWork = Get.find<DBWork>();

  var threeNumList = [0, 0, 0];

  var list = <WorkEntity>[].obs;

  DateTime? scheduleTime;
  String scheduleTimeStr = '';
  String content = '';

  List<WorkEntity> getThisWeekEntities(List<WorkEntity> workEntities) {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 7));

    return workEntities
        .where((entity) =>
    entity.scheduleTime.isAfter(startOfWeek) &&
        entity.scheduleTime.isBefore(endOfWeek))
        .toList();
  }

  List<WorkEntity> getThisMonthEntities(List<WorkEntity> workEntities) {
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 1);

    return workEntities
        .where((entity) =>
    entity.scheduleTime.isAfter(startOfMonth) &&
        entity.scheduleTime.isBefore(endOfMonth))
        .toList();
  }

  void getData() async {
    final result = await dbWork.getWorksData();
    var result1 = result.where((e) => e.type == 1).toList();
    result1.sort((a, b) {
      return a.scheduleTime.compareTo(b.scheduleTime);
    });
    list.value = result1;
    final todayList = list.value
        .where((e) =>
    e.scheduleTime.year == DateTime
        .now()
        .year &&
        e.scheduleTime.month == DateTime
            .now()
            .month &&
        e.scheduleTime.day == DateTime
            .now()
            .day)
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

  void selectTime(BuildContext context) {
    DatePicker.showDatePicker(context,
        pickerMode: DateTimePickerMode.date,
        dateFormat: 'yyyy-MM-dd HH:mm', onConfirm: (date, dateList) {
          scheduleTime = date;
          scheduleTimeStr = DateFormat('yyyy-MM-dd HH:mm').format(date);
          update(['scheduleBottomSheetRefresh']);
        });
  }

  void deleteSchedule(int id) async {
    await dbWork.dbBase.delete('work', where: 'id = ?', whereArgs: [id]);
    getData();
  }

  void addSchedule(BuildContext context) {
    Get.bottomSheet(
        Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          height: 400,
          child: SafeArea(
            child: GetBuilder<WorkSecondLogic>(id: 'scheduleBottomSheetRefresh',builder: (_) {
              return SingleChildScrollView(
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
                      'Add schedule',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Commit',
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ).gestures(onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (scheduleTime == null || content.isEmpty) {
                        Fluttertoast.showToast(msg: 'Please fill in the information completely');
                        return;
                      }
                      await dbWork.dbBase.insert('work', {
                        'createdTime': DateTime.now().toIso8601String(),
                        'type': 1,
                        'title': '',
                        'content': content,
                        'scheduleTime': scheduleTime!.toIso8601String()
                      });
                      scheduleTime = null;
                      scheduleTimeStr = '';
                      content = '';
                      update(['scheduleBottomSheetRefresh']);
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
                      'Schedule time',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      color: Colors.transparent,
                      width: double.infinity,
                      height: 40,
                      child: <Widget>[
                        Expanded(
                            child: IgnorePointer(
                              ignoring: true,
                              child: WorkTextField(
                                  hintText: 'Please select the time',
                                  value: scheduleTimeStr,
                                  padding: EdgeInsets.zero,
                                  onChange: (value) {}),
                            )),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          size: 20,
                          color: Colors.grey,
                        )
                      ].toRow(),
                    ).gestures(onTap: () {
                      selectTime(context);
                    }),
                    Divider(
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Schedule content',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
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
              );
            }),
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
