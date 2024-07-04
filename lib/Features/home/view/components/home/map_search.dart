// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:green_cycle_app/Features/home/ViewModel/cubit/HomeScreenCubit.dart';
// import 'package:green_cycle_app/Features/home/ViewModel/cubit/HomeScreenState.dart';
// import 'package:green_cycle_app/Features/home/view/components/home/place_item.dart';
// import 'package:green_cycle_app/Features/home/view/layouts/Home_Layout.dart';
// import 'package:green_cycle_app/core/colors.dart';
// import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
// import 'package:uuid/uuid.dart';

// import '../../../Model/placeSuggestion.dart';

// class Map_Search_Bar extends StatefulWidget {
//   Map_Search_Bar({super.key});

//   @override
//   State<Map_Search_Bar> createState() => _Map_Search_BarState();
// }

// class _Map_Search_BarState extends State<Map_Search_Bar> {
//   FloatingSearchBarController controller = FloatingSearchBarController();

//   // List<PlaceSuggestion> places = [];
//   // void getPlacesSuggestions(String query) {
//   //   final sessionToken = Uuid().v4();
//   //   BlocProvider.of<HomeScreenCubit>(context)
//   //       .emitPlaceSuggestions(query, sessionToken);
//   // }

//   Widget buildSuggestionsBloc() {
//     return BlocBuilder<HomeScreenCubit, HomeScreenState>(
//       builder: (context, state) {
//         if (state is PlacesLoaded) {
//           places = (state).places;
//           if (places.length != 0) {
//             return buildPlacesList();
//           } else {
//             return Container();
//           }
//         } else {
//           return Container();
//         }
//       },
//     );
//   }

//   Widget buildPlacesList() {
//     return ListView.builder(
//         itemBuilder: (ctx, index) {
//           return InkWell(
//             onTap: () async {
//               // placeSuggestion = places[index];
//               controller.close();
//               // getSelectedPlaceLocation();
//               // polylinePoints.clear();
//               // removeAllMarkersAndUpdateUI();
//             },
//             child: PlaceItem(
//               suggestion: places[index],
//             ),
//           );
//         },
//         itemCount: places.length,
//         shrinkWrap: true,
//         physics: const ClampingScrollPhysics());
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;

//     return FloatingSearchBar(
//         builder: (context, transition) {
//           return ClipRRect(
//             borderRadius: BorderRadius.circular(8.r),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [],
//             ),
//           );
//         },
//         controller: controller,
//         elevation: 6,
//         hintStyle: TextStyle(fontSize: 18.sp),
//         queryStyle: TextStyle(fontSize: 18.sp),
//         hint: 'ابحث عن مكان...',
//         border: BorderSide(style: BorderStyle.none),
//         margins: EdgeInsets.fromLTRB(20, 70, 20, 0),
//         padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
//         height: 52.h,
//         iconColor: MyColors.greenColor,
//         scrollPadding: EdgeInsets.only(top: 16.h, bottom: 56.h),
//         transitionDuration: const Duration(milliseconds: 600),
//         transitionCurve: Curves.easeInOut,
//         physics: const BouncingScrollPhysics(),
//         axisAlignment: isPortrait ? 0.0 : -1.0,
//         openAxisAlignment: 0.0,
//         width: isPortrait ? 600 : 500,
//         debounceDelay: const Duration(milliseconds: 500),
//         // progress: progressIndicator,
//         onQueryChanged: (query) {
//           getPlacesSuggestions(query);
//         },

//         // onFocusChanged: (_) {
//         //   // hide distance and time row
//         //   setState(() {
//         //     isTimeAndDistanceVisible = false;
//         //   });
//         // },
//         transition: CircularFloatingSearchBarTransition(),
//         actions: [
//           FloatingSearchBarAction(
//             showIfOpened: false,
//             child: CircularButton(
//                 icon: Icon(Icons.place,
//                     color: MyColors.blackColor.withOpacity(0.6)),
//                 onPressed: () {}),
//           )
//         ]);
//   }
// }

import 'package:flutter/material.dart';

// class Map_Search_Bar extends StatelessWidget {
//   const Map_Search_Bar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class Map_Search_Bar extends StatelessWidget {
  const Map_Search_Bar({
    super.key,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        hintText: 'Search here',
        fillColor: Colors.white,
        filled: true,
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ));
  }
}
