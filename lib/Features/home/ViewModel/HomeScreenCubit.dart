import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/cart/view/screens/cartScreen.dart';
import '../view/layouts/Home_Layout.dart';
import '../view/layouts/post_screen.dart';
import 'HomeScreenState.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(homeScreenInitState());
  static HomeScreenCubit get(context) => BlocProvider.of(context);
  int currentindex = 0;

  void changecurrentindex(index) {
    currentindex = index;
    emit(changeindex());
  }

  final items = <Widget>[
    Icon(
      Icons.home,
      size: 20.sp,
      color: Colors.white,
    ),
    Icon(
      Icons.medication,
      size: 30.sp,
      color: Colors.white,
    ),
    Icon(
      Icons.add,
      size: 30.sp,
      color: Colors.white,
    ),
    Icon(
      Icons.card_travel,
      size: 30.sp,
      color: Colors.white,
    ),

    Icon(
      Icons.access_time,
      size: 30.sp,
      color: Colors.white,
    ),
    Icon(
      Icons.person_2_outlined,
      size: 30.sp,
      color: Colors.white,
    ),
  ];

  List<Widget> layouts = [
    const HomeLayoutScreen(),
    const HomeLayoutScreen(),
    const Post_Screen(),
    const CartScreen(),
    const HomeLayoutScreen(),
    // HomeLayout(),
    // DoctorsScreen(),
    // Search(),
    // History(),
    // UserProfileScreen()
  ];
  ///////////////add//////////////////
  // void addTaskToFireBase(){
//     TaskModelFireBase task = TaskModelFireBase(
//       title: titleController.text,
//       description: descriptionController.text,
//       startDate: startDateController.text,
//       endDate: endDateController.text,
//     );
//     emit(AddTaskLoadingState());
//     FirebaseFirestore.instance.collection('tasks').add(task.toJson()).then((value){
//       print('Add Task Successfully');
//       emit(AddTaskSuccessState());
//     }).catchError((onError){
//       print('Add Task Error $onError');
//       emit(AddTaskErrorState());
//     });
  // }
/////////////////////////////$Get????????//////////
  // List<PostModelFireBase> PostsFireBase = [];

  // void getAllPostsFromFireBase(){
  //   emit(GetAllPostsLoadingState());
  //   FirebaseFirestore.instance.collection(kareem.task).where('title',isGreaterThan: 100).orderBy('score').snapshots().listen((value) {
  //     tasksFireBase = [];
  //     value.docs.forEach((element) {
  //      PostsModelFireBase currentTask =PostsModelFireBase.fromJson(element.data());
  //       currentTask.id = element.id;
  //       PostsFireBase.add(currentTask);
  //       print(element.data());
  //     });
  //     emit(GetAllPostsSuccessState());
  //   }).onError((error){
  //     print('Get All Posts FireBase Error $error');
  //     emit(GetAllPostsErrorState());
  //   });
  // }
}
