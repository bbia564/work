import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:work_summary/db_work/work_entity.dart';

import '../../main.dart';
import '../../router/work_names.dart';
import 'work_second_logic.dart';

class WorkSecondPage extends GetView<WorkSecondLogic> {
  Widget _topItem(int index) {
    final titles = ['''Today's Agenda''','''Week's Agenda''', '''Month's Agenda'''];
    return <Widget>[
      Text(
        titles[index],
        style: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        controller.threeNumList[index].toString(),
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    ].toColumn();
  }

  double calculateTextHeight(String text, TextStyle style, double maxWidth) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: null,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: maxWidth);
    return textPainter.size.height;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
        backgroundColor: Colors.white,
        actions: [
          Icon(
            Icons.add_box,
            size: 25,
            color: primaryColor,
          ).marginOnly(right: 20).gestures(onTap: () {
            controller.addSchedule(context);
          })
        ],
      ),
      body: <Widget>[
        Container(
          width: double.infinity,
          height: 70,
          child: <Widget>[
            Expanded(child: _topItem(0)),
            Expanded(child: _topItem(1)),
            Expanded(child: _topItem(2))
          ].toRow(),
        ).decorated(color: Colors.white),
        const SizedBox(
          height: 10,
        ),
        Expanded(child: SafeArea(
          child: Obx(() {
            return controller.list.value.isEmpty
                ? const Center(
                    child: Text('No data'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: controller.list.value.length,
                    itemBuilder: (_, index) {
                      final entity = controller.list.value[index];
                      final hereMaxWidth = MediaQuery.of(context).size.width -
                          48 -
                          8 -
                          10 -
                          12 * 2 -
                          10 -
                          20;
                      final countHeight = calculateTextHeight(
                              entity.content,
                              const TextStyle(fontSize: 12, color: Colors.grey),
                              hereMaxWidth) +
                          20 +
                          24 +
                          20;

                      return TimelineTile(
                        entity: entity,
                        index: index,
                        listLength: controller.list.value.length,
                        countHeight: countHeight,
                        delTap: () {
                          controller.deleteSchedule(entity.id);
                        },
                      );
                    });
          }),
        ))
      ].toColumn(),
    );
  }
}

class TimelineTile extends StatelessWidget {
  final WorkEntity entity;
  final double countHeight;
  final int index;
  final int listLength;
  final VoidCallback? delTap;

  TimelineTile(
      {required this.entity,
      required this.index,
      required this.listLength,
      this.countHeight = 0,
      this.delTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 1,
                height: 8,
                color: index == 0 ? Colors.transparent : primaryColor,
              ),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
              Visibility(
                visible: index < listLength - 1,
                child: Container(
                  width: 1,
                  height: countHeight,
                  color: primaryColor,
                ),
              ),
            ],
          ).marginOnly(top: 0),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entity.scheduleTimeStr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(entity.content,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey))),
                      Icon(
                        Icons.close,
                        color: primaryColor,
                        size: 20,
                      ).gestures(onTap: () {
                        delTap?.call();
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
