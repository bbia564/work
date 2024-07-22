import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class WRPage extends GetView<PageLogic> {
  const WRPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.beahan.value
              ? const CircularProgressIndicator(color: Colors.black,)
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.moyqs();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
