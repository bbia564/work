import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'work_third_logic.dart';

class WorkThirdPage extends GetView<WorkThirdLogic> {

  Widget _workSetItem(int index, BuildContext context) {
    final titles = [
      'Clean all data',
      'Version'
    ];
    return Container(
      color: Colors.transparent,
      height: 40,
      child: <Widget>[
        Text(titles[index]),
        index == 0 ? const Icon(
          Icons.keyboard_arrow_right,
          size: 20,
          color: Colors.grey,
        ) : Text('1.0.0')
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    ).gestures(onTap: () {
      switch (index) {
        case 0:
          controller.cleanWorkData();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("More"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: <Widget>[
                Container(
                  padding: const EdgeInsets.all(12),
                  child: <Widget>[
                    _workSetItem(0, context),
                    _workSetItem(1, context),
                  ].toColumn(
                      separator: Divider(
                        height: 15,
                        color: Colors.grey.withOpacity(0.3),
                      )),
                ).decorated(
                    color: Colors.white, borderRadius: BorderRadius.circular(12))
              ].toColumn(),
            ).marginAll(15)),
      ),
    );
  }
}
