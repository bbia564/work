import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:work_summary/main.dart';
import 'package:work_summary/router/work_names.dart';

import 'work_first_logic.dart';

class WorkFirstPage extends GetView<WorkFirstLogic> {
  Widget _topItem(int index) {
    final titles = ['Today summary','Week summary', 'Month summary'];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work summary'),
        backgroundColor: Colors.white,
        actions: [
          Icon(
            Icons.add_box,
            size: 25,
            color: primaryColor,
          ).marginOnly(right: 20).gestures(onTap: () {
            controller.addWorkSummary(context);
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
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        child: <Widget>[
                          <Widget>[
                            Expanded(
                              child: <Widget>[
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
                                  entity.title,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ))
                              ].toRow(),
                            ),
                            Text(
                              entity.createdTimeStr,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            )
                          ].toRow(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              entity.content,
                              maxLines: 3,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ).decorated(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10))
                        ].toColumn(),
                      )
                          .decorated(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10))
                          .marginOnly(bottom: 10)
                          .gestures(onTap: () {
                        Get.toNamed(WorkNames.workFirstDetails,
                                arguments: entity)
                            ?.then((_) {
                          controller.getData();
                        });
                      });
                    });
          }),
        ))
      ].toColumn(),
    );
  }
}
