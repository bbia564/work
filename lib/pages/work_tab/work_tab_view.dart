import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_summary/pages/work_first/work_first_view.dart';
import 'package:work_summary/pages/work_second/work_second_view.dart';
import 'package:work_summary/pages/work_third/work_third_view.dart';

import '../../main.dart';
import 'work_tab_logic.dart';

class WorkTabPage extends GetView<WorkTabLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [
          WorkFirstPage(),
          WorkSecondPage(),
          WorkThirdPage()
        ],
      ),
      bottomNavigationBar: Obx(()=>_navWorkBars()),
    );
  }

  Widget _navWorkBars() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled,color: Colors.grey.withOpacity(0.6)),
          activeIcon:Icon(Icons.home_filled,color: primaryColor),
          label: 'Summary',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_rounded,color: Colors.grey.withOpacity(0.6)),
          activeIcon:Icon(Icons.calendar_month_rounded,color: primaryColor),
          label: 'Schedule',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings,color: Colors.grey.withOpacity(0.6)),
          activeIcon:Icon(Icons.settings,color: primaryColor),
          label: 'More',
        ),
      ],
      currentIndex: controller.currentIndex.value,
      onTap: (index) {
        controller.currentIndex.value = index;
        controller.pageController.jumpToPage(index);
      },
    );
  }
}
