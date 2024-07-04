import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_cycle_app/Features/home/ViewModel/cubit/HomeScreenCubit.dart';
import 'package:green_cycle_app/Features/home/ViewModel/cubit/HomeScreenState.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Set<Polyline> _mypoli = {};
  final Set<Marker> mymarker = {};
  static Position? currentPosition;

  List<LatLng> points = [
    LatLng(31.019505580916057, 31.2290409201519),
    LatLng(31.076485407118653, 31.239078081561754)
  ];
  @override
  void initState() {
    super.initState();
    for (int a = 0; a < points.length; a++) {
      mymarker.add(Marker(
          markerId: MarkerId(a.toString()),
          position: points[a],
          infoWindow: InfoWindow(snippet: '10/10'),
          icon: BitmapDescriptor.defaultMarker));
      setState(() {});
    }
    _mypoli.add(Polyline(
        polylineId: PolylineId("first"),
        points: points,
        width: 1,
        color: Colors.cyan));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        var cubit = HomeScreenCubit.get(context);
        return SafeArea(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(31.019505580916057, 31.2290409201519), zoom: 11),
            myLocationEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            mapType: MapType.normal,
            markers: mymarker,
            polylines: _mypoli,
          ),
        );
      },
    );
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
}
