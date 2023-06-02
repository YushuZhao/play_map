import 'package:flutter/material.dart';

import '../location/amap_helper.dart';
import '../location/widget.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late Future<AMapPosition> position;
  @override
  void initState() {
    super.initState();
    getPosition();
  }

  Future<void> getPosition() async {
    position = AMapHelper().startLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<AMapPosition>(
        future: position,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MapLocationPicker(arguments: {
              "lat": double.parse(snapshot.data!.latLng.latitude.toString()),
              "lng": double.parse(snapshot.data!.latLng.longitude.toString()),
              "isMapImage": true
            });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                Color.fromRGBO(112, 113, 135, 1.0),
              ),
            ),
          );
        },
      ),
    );
  }
}
