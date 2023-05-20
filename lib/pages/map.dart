import 'package:flutter/material.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'dart:math';

class AmapConfig {
  // 高德地图 key
  static const amapAndroidKey = '567436eaeea04e732abf8efb1215fc3b';

  static const AMapApiKey amapApiKeys = AMapApiKey(androidKey: amapAndroidKey);

  static const AMapPrivacyStatement amapPrivacyStatement =
      AMapPrivacyStatement(hasContains: true, hasShow: true, hasAgree: true);
}

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  AMapController? _mapController;

  // Marker
  static const LatLng mapCenter = LatLng(39.909187, 116.397451);
  final Map<String, Marker> _initMarkerMap = <String, Marker>{};

  @override
  void initState() {
    super.initState();
    _requestLocaitonPermission();
  }

  @override
  void reassemble() {
    super.reassemble();
    _requestLocaitonPermission();
  }

  void _requestLocaitonPermission() async {
    PermissionStatus status = await Permission.location.request();
    print('permissionStatus=================> $status');
  }

  void onMapCreated(AMapController controller) {
    _mapController = controller;
    getApprovalNumber();
  }

  /// 获取审图号
  void getApprovalNumber() async {
    // 普通地图审图号
    String? mapContentApprovalNumber =
        await _mapController?.getMapContentApprovalNumber();
    // 卫星地图审图号
    String? satelliteImageApprovalNumber =
        await _mapController?.getSatelliteImageApprovalNumber();

    print('地图审图号（普通地图）: $mapContentApprovalNumber');
    print('地图审图号（卫星地图): $satelliteImageApprovalNumber');
  }

  /// 设置定位参数
  void setLocationOption(AMapLocationOption locationOption) {}

  void startLocation() {}

  void stopLocation() {}

  void destroy() {}

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 10; i++) {
      LatLng position = LatLng(mapCenter.latitude + sin(i * pi / 12.0) / 20.0,
          mapCenter.longitude + cos(i * pi / 12.0) / 20.0);
      Marker marker = Marker(position: position);
      _initMarkerMap[marker.id] = marker;
    }

    final AMapWidget map = AMapWidget(
        apiKey: AmapConfig.amapApiKeys,
        privacyStatement: AmapConfig.amapPrivacyStatement,
        mapType: MapType.normal,
        // normal 普通地图 , satellite 卫星地图 , night 夜间视图 , navi 导航视图 , bus 公交视图
        onMapCreated: onMapCreated,
        markers: Set<Marker>.of(_initMarkerMap.values),
        // limitBounds: LatLngBounds(
        //     southwest: LatLng(39.83309, 116.290176),
        //     northeast: LatLng(39.99951, 116.501663)),
        myLocationStyleOptions: MyLocationStyleOptions(true,
            circleFillColor: Colors.lightBlue,
            circleStrokeColor: Colors.blue,
            circleStrokeWidth: 10));

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: map,
    );
  }
}
