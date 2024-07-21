import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:work_summary/main.dart';

import 'work_first_details_logic.dart';

class WorkFirstDetailsPage extends GetView<WorkFirstDetailsLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary details'),
        backgroundColor: Colors.white,
        actions: [
          Text(
            'Delete',
            style: TextStyle(color: primaryColor, fontSize: 14),
          ).marginOnly(right: 20).gestures(onTap: () {
            controller.deleteData();
          })
        ],
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(12),
          child: GetBuilder<WorkFirstDetailsLogic>(builder: (_) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: <Widget>[
                <Widget>[
                  Container(
                    width: 8,
                    height: 8,
                  ).decorated(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(4)),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Text(
                    controller.entity.title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ))
                ].toRow(),
                Text(
                  controller.entity.createdTimeStr,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ).marginSymmetric(vertical: 10, horizontal: 13),
                Divider(
                  color: Colors.grey.withOpacity(0.3),
                ).marginOnly(bottom: 10),
                Text(
                  controller.entity.content,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                )
              ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
            );
          }),
        )
            .decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(10))
            .marginAll(15),
      ),
    );
  }
}
