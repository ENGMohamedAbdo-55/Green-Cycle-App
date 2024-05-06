// import 'package:flutter/material.dart';

// class DrpoDownMenu extends StatefulWidget {
//   const DrpoDownMenu({super.key});

//   @override
//   State<DrpoDownMenu> createState() => _DrpoDownMenuState();
// }

// class _DrpoDownMenuState extends State<DrpoDownMenu> {
//    List<String> Dplist = <String>['One', 'Two', 'Three', 'Four'];
//   String dropdownValue = ;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownMenu<String>(
//       initialSelection: list.first,
//       onSelected: (String? value) {
//         // This is called when the user selects an item.
//         setState(() {
//           dropdownValue = value!;
//         });
//       },
//       dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
//         return DropdownMenuEntry<String>(value: value, label: value);
//       }).toList(),
//     );
//   }
// }
