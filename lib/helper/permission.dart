import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestLocationPermission() async {
  bool isEnabled = await Permission.location.serviceStatus.isEnabled;
  bool isEnabled2 = await Permission.locationWhenInUse.serviceStatus.isEnabled;
  debugPrint("getLocation location.serviceStatus $isEnabled");
  if (isEnabled == false && isEnabled2 == false) {
    EasyLoading.showInfo("您还没有打开位置信息服务".tr);
    // openAppSettings();
    return false;
  }
  //获取当前的权限
  var status = await Permission.location.status;
  if (status == PermissionStatus.granted) {
    //已经授权
    return true;
  } else {
    //未授权则发起一次申请
    status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}
