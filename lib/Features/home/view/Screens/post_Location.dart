import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:green_cycle_app/Features/home/Model/place_details_model/place_details_model.dart';
import 'package:green_cycle_app/Features/home/view/components/google_maps_place_service.dart';
import 'package:green_cycle_app/core/Services/spacing.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_cycle_app/core/Services/location_helper.dart';
import 'package:green_cycle_app/core/colors.dart';
// import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../../Model/place_autocomplete_model/place_autocomplete_model.dart';
import '../../ViewModel/cubit/HomeScreenCubit.dart';
import '../../ViewModel/cubit/HomeScreenState.dart';
import '../components/customlistview.dart';
import '../components/home/map_search.dart';

class MapPostLocationScreen extends StatefulWidget {
  const MapPostLocationScreen({super.key});

  @override
  State<MapPostLocationScreen> createState() => MapSampleState();
}

class MapSampleState extends State<MapPostLocationScreen> {
  late TextEditingController textEditingController;
  // late MapServices mapServices;
  Timer? debounce;
  List<PlaceModel> places = [];
  late PlacesService placesService;
  String? sesstionToken;
  late Uuid uuid;
  @override
  void initState() {
    // mapServices = MapServices();
    placesService = PlacesService();
    uuid = const Uuid();
    textEditingController = TextEditingController();
    // initalCameraPoistion = const CameraPosition(target: LatLng(0, 0));
    fetchPredictions();
    super.initState();
  }

  void fetchPredictions() {
    textEditingController.addListener(() async {
      if (textEditingController.text.isNotEmpty) {
        var result = await placesService.getPredictions(
            input: textEditingController.text);
        places.addAll(result);
        places.clear();
        setState(() {});
      } else {}
      places.clear();
      setState(() {});
    });
  }

  void dispose() {
    textEditingController.dispose();
    // debounce?.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeScreenCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: MyColors.greenColor,
            elevation: 0.0,
            leading: IconButton(
                onPressed: () => Navigator.pop,
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 30.sp,
                )),
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              GoogleMap(
                initialCameraPosition: cubit.kGooglePlex,
                mapType: MapType.hybrid,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  cubit.mapController.complete(controller);
                },
              ),
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Column(
                  children: [
                    Map_Search_Bar(
                      textEditingController: textEditingController,
                    ),
                    verticalSpace(15),
                    customListView(
                      onplaceselect: (PlaceDetailsModel) {
                        textEditingController.clear();
                        places.clear();
                        setState(() {});
                        print(
                            "${PlaceDetailsModel.geometry!.location!.lat}/${PlaceDetailsModel.geometry!.location!.lng}");
                      },
                      places: places,
                      placesService: placesService,
                    )
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 8, 30),
            child: FloatingActionButton(
              backgroundColor: MyColors.greenColor,
              onPressed: cubit.goToMyCurrentLocation,
              child: Icon(
                Icons.place,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
