import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';

import 'package:play_map/helper/permission.dart';

class AMapHelper {
  late AMapFlutterLocation location;
  late Completer<AMapPosition> completer;

  static final AMapHelper _to = AMapHelper._internal();

  factory AMapHelper() => _to;

  static void init() {
    updatePrivacyShow(true, true);
    updatePrivacyAgree(true);
    setApiKey();
  }

  static void setApiKey() {
    String androidKey = dotenv.get('AMAP_ANDROID_KEY');
    String iosKey = dotenv.get('AMAP_IOS_KEY');
    AMapFlutterLocation.setApiKey(androidKey, iosKey);
  }

  AMapHelper._internal() {
    location = AMapFlutterLocation();
    completer = Completer();
  }

  static void updatePrivacyShow(bool hasContains, bool hasShow) {
    AMapFlutterLocation.updatePrivacyShow(hasContains, hasShow);
  }

  static void updatePrivacyAgree(bool hasAgree) {
    AMapFlutterLocation.updatePrivacyAgree(hasAgree);
  }

  AMapLocationOption locationOption = AMapLocationOption(
    needAddress: true,
    geoLanguage: GeoLanguage.ZH,
    onceLocation: false,
    locationMode: AMapLocationMode.Hight_Accuracy,
    locationInterval: 2000,
    pausesLocationUpdatesAutomatically: false,
    desiredAccuracy: DesiredAccuracy.Best,
  );

  void setLocationOption(AMapFlutterLocation location) {
    location.setLocationOption(locationOption);
  }

  Future<AMapPosition> startLocation() async {
    bool p = await requestLocationPermission();
    print('has permission: $p');
    if (!p) {
      return AMapPosition(
          id: '',
          name: '',
          latLng: LatLng(0.0, 0.0),
          address: '',
          adCode: '',
          distance: '');
    }
    init();
    location.startLocation();
    return completer.future;
  }

  void stopLocation(AMapFlutterLocation location) {
    location.stopLocation();
  }

  void destroy(AMapFlutterLocation location) {
    location.destroy();
  }

  void onLocationChanged(locationResultCallBack) {
    location
        .onLocationChanged()
        .listen((Map<String, Object> result) => locationResultCallBack(result));
  }
}

class AMapPosition {
  String id = "";
  String name = "";
  LatLng latLng;
  String address = "";
  String adCode = "";
  String distance = "";

  AMapPosition({
    required this.id,
    required this.name,
    required this.latLng,
    required this.address,
    required this.adCode,
    required this.distance,
  });
}
