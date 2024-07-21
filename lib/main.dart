import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_summary/db_work/db_work.dart';
import 'package:work_summary/pages/acs/fod.dart';
import 'package:work_summary/pages/work_first/work_first_binding.dart';
import 'package:work_summary/pages/work_first/work_first_details/work_first_details_binding.dart';
import 'package:work_summary/pages/work_first/work_first_details/work_first_details_view.dart';
import 'package:work_summary/pages/work_first/work_first_view.dart';
import 'package:work_summary/pages/work_second/work_second_binding.dart';
import 'package:work_summary/pages/work_second/work_second_view.dart';
import 'package:work_summary/pages/work_tab/work_tab_binding.dart';
import 'package:work_summary/pages/work_tab/work_tab_view.dart';
import 'package:work_summary/pages/work_third/work_third_binding.dart';
import 'package:work_summary/pages/work_third/work_third_view.dart';
import 'package:work_summary/pages/wr/binding.dart';
import 'package:work_summary/pages/wr/view.dart';
import 'package:work_summary/router/work_names.dart';

Color primaryColor = const Color(0xff59c2b3);
Color bgColor = const Color(0xfff4f6fa);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DBWork().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Pages,
      initialRoute: '/',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}

List<GetPage<dynamic>> Pages = [
  GetPage(name: '/', page: () => const WRPage(),binding: WRBinding()),
  GetPage(name: WorkNames.workTab, page: () => WorkTabPage(), binding: WorkTabBinding()),
  GetPage(name: WorkNames.workFirst, page: () => WorkFirstPage(), binding: WorkFirstBinding()),
  GetPage(name: WorkNames.workAcs, page: () => const AcsPage()),
  GetPage(name: WorkNames.workSecond, page: () => WorkSecondPage(), binding: WorkSecondBinding()),
  GetPage(name: WorkNames.workThird, page: () => WorkThirdPage(), binding: WorkThirdBinding()),
  GetPage(name: WorkNames.workFirstDetails, page: () => WorkFirstDetailsPage(),binding: WorkFirstDetailsBinding()),
];
