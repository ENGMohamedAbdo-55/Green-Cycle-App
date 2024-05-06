import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../cart/view/screens/cartScreen.dart';
import '../../Model/post_model.dart';
import '../../view/layouts/Home_Layout.dart';
import '../../view/layouts/post_screen.dart';
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
  int currentTaskIndex = 0;

  void changeCurrentTask(int indexx) {
    currentTaskIndex = indexx;
  }

  int currentindex = 0;

  void changecurrentindex(index) {
    currentindex = index;
    emit(changeindex());
  }

  int groupValue = 0;

  void changeGroupValue({required int newValue}) {
    groupValue = newValue;
    emit(ChangeGroupValue());
  }

  File? cameraFile;
  cameraImage() async {
// Capture a photo.
    emit(TakePhotoLoading());
    final ImagePicker picker = ImagePicker();
    final XFile? imageCamera =
        await picker.pickImage(source: ImageSource.camera);
    cameraFile = File(imageCamera!.path);
    emit(TakePhotoSuccess());
  }

  File? galleryFile;
  galleryImage() async {
    // Pick an image.
    emit(PickPhotoLoading());
    final ImagePicker picker = ImagePicker();
    final XFile? imageGallery =
        await picker.pickImage(source: ImageSource.gallery);
    galleryFile = File(imageGallery!.path);
    emit(PickPhotoSuccess());
  }

  int activeindex = 0;
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
    HomeLayoutScreen(),
    HomeLayoutScreen(),
    Post_Screen(),
   const CartScreen(),
    HomeLayoutScreen(),

    // DoctorsScreen(),
    // Search(),
    // History(),
    // UserProfileScreen()
  ];
  ///////////////add//////////////////
  void addPostToFireBase() {
    PostModelFireBase post = PostModelFireBase(
      title: titleController.text,
      description: descriptionController.text,
      date: dateController.text,
      time: timeController.text,
    );
    emit(AddPostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .add(post.toJson())
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
    FirebaseFirestore.instance.collection(col.posts).snapshots().listen((value) {
      PostsFireBase = [];
      value.docs.forEach((element) {
        PostModelFireBase currentPost =
            PostModelFireBase.fromJson(element.data());
        currentPost.id = element.id;
        PostsFireBase.add(currentPost);
        print(element.data());
      });
      emit(GetPostSuccess());
    }).onError((error) {
      print('Get All Posts FireBase Error $error');
      emit(GetPostError());
    });
  }
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
