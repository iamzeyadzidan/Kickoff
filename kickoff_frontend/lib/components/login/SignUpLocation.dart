import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class FindLocation extends StatelessWidget {
  FindLocation({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  static var Locationaddress;
  static var X_axis;
  static var Y_axis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: OpenStreetMapSearchAndPick(
            center: LatLong(31.2160786, 29.9469253),
            buttonColor: Color(0XFF4CAF50),
            buttonText: 'اختر الموقع',
            onPicked: (pickedData) {
              Locationaddress = pickedData.address;
              X_axis = pickedData.latLong.latitude;
              Y_axis = pickedData.latLong.longitude;
            }),
      ),
    );
  }
}
