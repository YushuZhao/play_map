import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:flutter/material.dart';

import '../location/amap_helper.dart';
import '../location/widget.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late Future<AMapPosition> position;
  LatLng? latlng;

  @override
  void initState() {
    super.initState();
    getPosition();
    getLocationListener();
  }

  Future<void> getPosition() async {
    position = AMapHelper().startLocation();
  }

  void locationResultCallBack(result) {
    // print("=====================");
    // print(result);
    double longitude = double.tryParse(result['longitude'].toString()) ?? 0;
    double latitude = double.tryParse(result['latitude'].toString()) ?? 0;
    setState(() {
      latlng = LatLng(latitude, longitude);
    });
  }

  Future<void> getLocationListener() async {
    AMapHelper().onLocationChanged(locationResultCallBack);
  }

  @override
  Widget build(BuildContext context) {
    if (null == latlng) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(
            Color.fromRGBO(112, 113, 135, 1.0),
          ),
        ),
      );
    }
    return MapLocationPicker(arguments: {
      "lat": double.parse(latlng!.latitude.toString()),
      "lng": double.parse(latlng!.longitude.toString()),
      "isMapImage": true
    });
  }
}

// {callbackTime: 2023-06-06 10:30:21,
  //locationTime: 2023-06-06 10:30:21,
  //locationType: 5,
  //latitude: 39.825047,
  //longitude: 116.301453,
  //accuracy: 30.0,
  //altitude: 0.0,
  //bearing: 0.0,
  //speed: 0.0,
  //country: 中国,
  //province: 北京市,
  //city: 北京市,
  //district: 丰台区,
  //street: 五圈路,
  //streetNumber: 1号院,
  //cityCode: 010,
  //adCode: 110106,
  //address: 北京市丰台区五圈路1号院靠近诺德中心2期,
  //description: 在诺德中心2期附近}
