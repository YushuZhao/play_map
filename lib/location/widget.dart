import 'dart:async';
import 'dart:math';

import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:play_map/location/amap_helper.dart';

// ignore: must_be_immutable
class MapLocationPicker extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MapLocationPickerState createState() => _MapLocationPickerState();
  Object? arguments;
  LatLng? latLng;
  bool isMapImage = false;

  MapLocationPicker({super.key, this.arguments}) {
    latLng = LatLng((arguments as Map)["lat"] as double,
        (arguments as Map)["lng"] as double);
    isMapImage = (arguments as Map)["isMapImage"];
  }
}

class _MapLocationPickerState extends State<MapLocationPicker>
    with SingleTickerProviderStateMixin, _BLoCMixin, _AnimationMixin {
  double _currentZoom = 15.0;

  AMapController? _controller;

  CustomStyleOptions customStyleOptions = CustomStyleOptions(false);
  MyLocationStyleOptions myLocationStyleOptions = MyLocationStyleOptions(true);

  LatLng _currentCenterCoordinate = const LatLng(39.909187, 116.397451);
  CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(39.909187, 116.397451),
    zoom: 15.0,
    tilt: 30,
    bearing: 0,
  );

  final Map<String, Marker> _markers = <String, Marker>{};

  @override
  void initState() {
    super.initState();
    _currentCenterCoordinate = widget.latLng!;
    _kInitialPosition = CameraPosition(
      target: widget.latLng!,
      zoom: _currentZoom,
      tilt: 30,
      bearing: 0,
    );
  }

  void onMapCreated(AMapController controller) {
    setState(() {
      _controller = controller;
    });
  }

  /// 获取审图号
  void getApprovalNumber() async {
    // 普通地图审图号
    String? mapContentApprovalNumber =
        await _controller?.getMapContentApprovalNumber();
    // 卫星地图审图号
    String? satelliteImageApprovalNumber =
        await _controller?.getSatelliteImageApprovalNumber();

    print('地图审图号（普通地图）: $mapContentApprovalNumber');
    print('地图审图号（卫星地图): $satelliteImageApprovalNumber');
  }

  @override
  Widget build(BuildContext context) {
    // for (int i = 0; i < 10; i++) {
    //   LatLng position = LatLng(
    //       _currentCenterCoordinate.latitude + sin(i * pi / 15.0) / 50.0,
    //       _currentCenterCoordinate.longitude + cos(i * pi / 15.0) / 50.0);
    //   Marker marker = Marker(position: position);
    //   _markers[marker.id] = marker;
    // }
    final AMapWidget amap = AMapWidget(
      privacyStatement: AMapPrivacyStatement(
        hasContains: true,
        hasShow: true,
        hasAgree: true,
      ),
      apiKey: AMapApiKey(
          androidKey: dotenv.get("AMAP_ANDROID_KEY"),
          iosKey: dotenv.get("AMAP_IOS_KEY")),
      initialCameraPosition: _kInitialPosition,
      mapType: MapType.normal,
      buildingsEnabled: true,
      compassEnabled: false,
      labelsEnabled: true,
      scaleEnabled: true,
      touchPoiEnabled: true,
      rotateGesturesEnabled: true,
      scrollGesturesEnabled: true,
      tiltGesturesEnabled: true,
      zoomGesturesEnabled: true,
      onMapCreated: onMapCreated,
      customStyleOptions: customStyleOptions,
      myLocationStyleOptions: myLocationStyleOptions,
      markers: Set<Marker>.of(_markers.values),
    );
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: amap);
  }
}

mixin _BLoCMixin on State<MapLocationPicker> {
  final poiStream = StreamController<List<AMapPosition>>();

  final _onMyLocation = StreamController<bool>();

  @override
  void dispose() {
    poiStream.close();
    _onMyLocation.close();
    super.dispose();
  }
}

mixin _AnimationMixin on SingleTickerProviderStateMixin<MapLocationPicker> {
  late AnimationController _jumpController;
  late Animation<Offset> _tween;

  @override
  void initState() {
    super.initState();
    _jumpController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _tween = Tween(begin: const Offset(0, 0), end: const Offset(0, -15))
        .animate(
            CurvedAnimation(parent: _jumpController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _jumpController.dispose();
    super.dispose();
  }
}
