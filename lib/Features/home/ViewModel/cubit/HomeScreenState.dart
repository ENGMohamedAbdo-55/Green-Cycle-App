import '../../Model/placeSuggestion.dart';

abstract class HomeScreenState {}

class homeScreenInitState extends HomeScreenState {}

class changeindex extends HomeScreenState {}

class ChangeGroupValue extends HomeScreenState {}

class AddPostLoadingState extends HomeScreenState {}

class AddPostSuccessState extends HomeScreenState {}

class AddPostErrorState extends HomeScreenState {}

class GetPostLoading extends HomeScreenState {}

class GetPostSuccess extends HomeScreenState {}

class GetPostError extends HomeScreenState {}

class PickPhotoLoading extends HomeScreenState {}

class PickPhotoSuccess extends HomeScreenState {}

class PickPhotoError extends HomeScreenState {}

class TakePhotoLoading extends HomeScreenState {}

class TakePhotoSuccess extends HomeScreenState {}
class GetCurrentLocationSussesState extends HomeScreenState {}

class TakePhotoError extends HomeScreenState {}


class CartLoading extends HomeScreenState {}

class CartLoaded extends HomeScreenState {
  
}

class CartError extends HomeScreenState {
 
}

// class PlacesLoaded extends HomeScreenState {
//   final List<PlaceSuggestion> places;

//   PlacesLoaded(this.places);

// }

// class PlaceLocationLoaded extends HomeScreenState {
//   final Place place;

//   PlaceLocationLoaded(this.place);

// }


// class DirectionsLoaded extends HomeScreenState {
//   final PlaceDirections placeDirections;

//   DirectionsLoaded(this.placeDirections);

// }
