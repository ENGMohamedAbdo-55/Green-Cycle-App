import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_cycle_app/Features/chat/ui/chat_home.dart';
import 'package:green_cycle_app/Features/chat/ui/chat_screen.dart';
import 'package:green_cycle_app/Features/profile/view/screens/profile_screen.dart';
import 'package:green_cycle_app/core/Services/local/secure_keys.dart';
import 'package:green_cycle_app/core/Services/local/secure_storage.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../cart/view/screens/cartScreen.dart';
import '../../Model/post_model.dart';
import '../../view/layouts/Home_Layout.dart';
import '../../view/layouts/post_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'HomeScreenState.dart';
import '../firebase_collection/collection.dart' as col;

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(homeScreenInitState());
  static HomeScreenCubit get(context) => BlocProvider.of(context);
  var AddPostKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var locationController = TextEditingController();

  void initControllerFireBase() {
    cameraUrl = PostsFireBase[currentTaskIndex].cameraUrl;
    galleryUrl = PostsFireBase[currentTaskIndex].galleryUrl;
    titleController.text = PostsFireBase[currentTaskIndex].title ?? '';
    descriptionController.text =
        PostsFireBase[currentTaskIndex].description ?? '';
    dateController.text = PostsFireBase[currentTaskIndex].date ?? '';
    timeController.text = PostsFireBase[currentTaskIndex].time ?? '';
  }

  int currentTaskIndex = 0;
  void changeCurrentTask(int indexx) {
    currentTaskIndex = indexx;
  }

  int currentindex = 0;
  void changecurrentindex(index) {
    currentindex = index;
    emit(changeindex());
  }

  int groupValue = 1;
  void changeGroupValue() {
    groupValue = 1;
    emit(ChangeGroupValue());
  }

  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
    timeController.clear();
    // galleryUrl = '';
    // galleryFile = null;
    // cameraUrl = '';
    // cameraFile = null;
  }

  List<PostModelFireBase> cartList = [];
  Future<void> getCartPosts() async {
    emit(CartLoading());
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("Cart")
          .get();
      cartList = querySnapshot.docs
          .map((doc) =>
              PostModelFireBase.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      emit(CartLoaded());
    } catch (error) {
      print("Error fetching cart posts: $error");
      emit(CartError());
    }
  }

  List<QueryDocumentSnapshot> data = [];
  initialData() async {
    CollectionReference posts =
        FirebaseFirestore.instance.collection(col.posts);
    QuerySnapshot filter = await posts.where('title', isEqualTo: 'حديد').get();
    filter.docs.forEach((element) {
      data.add(element);
    });
  }

  File? cameraFile;
  String? cameraUrl;
  cameraImage() async {
    emit(TakePhotoLoading());
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? imageCamera = await picker.pickImage(source: ImageSource.camera);
      if (imageCamera != null) {
        cameraFile = File(imageCamera.path);
        var cameraImageName = basename(imageCamera.path);
        var camerafilerefrence = FirebaseStorage.instance.ref(cameraImageName);
        await camerafilerefrence.putFile(cameraFile!);
        cameraUrl = await camerafilerefrence.getDownloadURL();
        emit(TakePhotoSuccess());
      }
    } catch (e) {
      print('Error while capturing photo: $e');
    }
  }

  File? galleryFile;
  String? galleryUrl;
  galleryImage() async {
    // Pick an image.
    emit(PickPhotoLoading());
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? imageGallery =
          await picker.pickImage(source: ImageSource.gallery);
      if (imageGallery != null) {
        galleryFile = File(imageGallery.path);
        var galleryImageName = basename(imageGallery.path);
        var galleryfilerefrence =
            FirebaseStorage.instance.ref(galleryImageName);
        await galleryfilerefrence.putFile(galleryFile!);
        galleryUrl = await galleryfilerefrence.getDownloadURL();
      }

      emit(PickPhotoSuccess());
    } catch (e) {
      print('Error while capturing photo: $e');
    }
  }

  int activeindex = 0;
  int activeindexdetail = 0;
  final cato = <String>[
    'بلاستيك',
    'معادن',
    'ورق',
    'زجاج',
    'روبابيكيا',
  ];

  final items = <Widget>[
    Icon(
      Icons.home,
      size: 20.sp,
      color: Colors.white,
    ),
    Icon(
      Icons.chat,
      size: 30.sp,
      color: Colors.white,
    ),
    Icon(
      Icons.add,
      size: 30.sp,
      color: Colors.white,
    ),
    Icon(
      Icons.shopping_cart,
      size: 30.sp,
      color: Colors.white,
    ),
    Icon(
      Icons.account_circle_rounded,
      size: 30.sp,
      color: Colors.white,
    ),
  ];

  List<Widget> layouts = [
    const HomeLayoutScreen(),
    const ChatHome(),
    const Post_Screen(),
    CartScreen(),
    UserProfileScreen(),

    // DoctorsScreen(),
    // Search(),
    // History(),
    // UserProfileScreen()
  ];
  ///////////////add//////////////////

  addPostToFireBase() async {
    SecureStorage secureStorage = SecureStorage();
    String? id = await secureStorage.getSecureData(SecureKeys.userId);
    String? name = await secureStorage.getSecureData(SecureKeys.name);
    String? image = await secureStorage.getSecureData(SecureKeys.image);
    PostModelFireBase post = PostModelFireBase(
      title: titleController.text,
      description: descriptionController.text,
      date: dateController.text,
      time: timeController.text,
      cameraUrl: cameraUrl,
      // galleryUrl: galleryUrl,
      uId: id ?? '',
      name: name ?? '',
      image: image ?? '',
      phone: '',
      email: '',
    );
    emit(AddPostLoadingState());

    FirebaseFirestore.instance
        .collection('posts')
        .add(
          post.toJson(),
        )
        .then((value) {
      print('Add Post Successfully');
      emit(AddPostSuccessState());
    }).catchError((onError) {
      print('Add Post Error $onError');
      emit(AddPostErrorState());
    });
  }

/////////////////////////////$Get????????//////////

  List<PostModelFireBase> PostsFireBase = [];

  void getAllPostsFromFireBase() {
    emit(GetPostLoading());
    FirebaseFirestore.instance
        .collection(col.posts)
        .snapshots()
        .listen((value) {
      PostsFireBase = [];
      for (var element in value.docs) {
        PostModelFireBase currentPost =
            PostModelFireBase.fromJson(element.data());
        currentPost.id = element.id;
        PostsFireBase.add(
          currentPost,
        );
        // print(element.data());
      }
      emit(GetPostSuccess());
    }).onError((error) {
      print('Get All Posts FireBase Error $error');
      emit(GetPostError());
    });
  }

  //........................map.......................................
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(31.0500, 31.3833),
    zoom: 14.4746,
  );
  static Position? currentPosition;

  String? pickupLocationAddress;
  static final CameraPosition myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(currentPosition!.latitude, currentPosition!.longitude),
    // tilt: 0.0,
    zoom: 17,
  );

  goToMyCurrentLocation() async {
    currentPosition = await determinePosition(); //get my currlocation
    final GoogleMapController controller = await mapController.future;
    controller
        .animateCamera(
            CameraUpdate.newCameraPosition(myCurrentLocationCameraPosition))
        .then((value) {
      emit(GetCurrentLocationSussesState());
    });
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Geolocator.openLocationSettings().then((value) {
        if (!value) {
          return Future.error('Location services are disabled.');
        }
      });
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // List<SearchLocationPrediction> searchLocationPredictions = [];
  // searchLocation(String searchKey) {
  //   searchLocationPredictions = [];
  //   DioHelper.getData(
  //       url: "https://maps.googleapis.com/maps/api/place/autocomplete/json",
  //       queryParameters: {
  //         "input": searchKey,
  //         "location":
  //         "${currentPosition.latitude}%2C${currentPosition.longitude}",
  //         "radius": 500,
  //         "components": "country:eg",
  //         "types": "establishment",
  //         "key": mapAndroidKey,
  //       }).then((value) {
  //     for (var element in value.data["predictions"]) {
  //       searchLocationPredictions
  //           .add(SearchLocationPrediction.fromJson(element));
  //     }
  //     emit(SearchLocationSussesState());
  //   }).catchError((onError) {
  //     debugPrint(onError.toString());
  //     emit(SearchLocationErrorState());
  //   });
  // }
  // MapsRepository? mapsRepository;
  // void emitPlaceSuggestions(String place, String sessionToken) {
  //   mapsRepository?.fetchSuggestions(place, sessionToken).then((suggestions) {
  //     emit(PlacesLoaded(suggestions));
  //   });
  // }

  // void emitPlaceLocation(String placeId, String sessionToken) {
  //   mapsRepository?.getPlaceLocation(placeId, sessionToken).then((place) {
  //     emit(PlaceLocationLoaded(place));
  //   });
  // }

  // void emitPlaceDirections(LatLng origin, LatLng destination) {
  //   mapsRepository?.getDirections(origin, destination).then((directions) {
  //     emit(DirectionsLoaded(directions));
  //   });
  // }
}

class SliderModel {
  String? image;
  SliderModel({this.image});
}

List<SliderModel> slider = [
  SliderModel(image: 'assets/images/onBoarding_images/onBoard1.png'),
  SliderModel(image: 'assets/images/onBoarding_images/onBoard1.png'),
  SliderModel(image: 'assets/images/onBoarding_images/onBoard1.png'),
];
