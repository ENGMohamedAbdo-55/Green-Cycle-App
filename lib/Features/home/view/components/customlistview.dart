import 'package:flutter/material.dart';
import 'package:green_cycle_app/Features/home/Model/place_details_model/place_details_model.dart';
import 'package:green_cycle_app/Features/home/view/components/google_maps_place_service.dart';

import '../../Model/place_autocomplete_model/place_autocomplete_model.dart';

class customListView extends StatelessWidget {
  const customListView({
    super.key,
    required this.places,
    required this.placesService,
    required this.onplaceselect,
  });
  final Function(PlaceDetailsModel) onplaceselect;

  final List<PlaceModel> places;
  final PlacesService placesService;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.location_on_sharp),
            title: Text(places[index].description!),
            trailing: IconButton(
              onPressed: () async {
                var placeDetails = await placesService.getPlaceDetails(
                  placeId: places[index].placeId.toString(),
                );
                onplaceselect(placeDetails);
              },
              icon: const Icon(Icons.arrow_circle_right_outlined),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 0,
          );
        },
        itemCount: places.length);
  }
}
