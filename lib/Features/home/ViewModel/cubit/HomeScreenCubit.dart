import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_cycle_app/Features/profile/view/screens/profile_screen.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../auth/model/user_model.dart';
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
  UserModel? userModel;

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var locationController = TextEditingController();

  void initControllerFireBase() {
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

  int groupValue = 0;
  void changeGroupValue({required int newValue}) {
    groupValue = newValue;
    emit(ChangeGroupValue());
  }

  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
    timeController.clear();
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

  File? cameraFile;
  String? cameraUrl;
  cameraImage() async {
// Capture a photo.
    emit(TakePhotoLoading());
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? imageCamera =
          await picker.pickImage(source: ImageSource.camera);
      if (imageCamera != null) {
        cameraFile = File(imageCamera.path);
        var cameraImageName = basename(imageCamera.path);
        var camerafilerefrence = FirebaseStorage.instance.ref(cameraImageName);
        await camerafilerefrence.putFile(cameraFile!);
        cameraUrl = await camerafilerefrence.getDownloadURL();
      }
      emit(TakePhotoSuccess());
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
    const HomeLayoutScreen(),
    const Post_Screen(),
    const CartScreen(),
    UserProfileScreen(),

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
        cameraUrl: cameraUrl,
        galleryUrl: galleryUrl);
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
