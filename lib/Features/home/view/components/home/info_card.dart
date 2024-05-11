import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/core/colors.dart';
import 'package:green_cycle_app/core/text_styles.dart';

class Info_Card extends StatelessWidget {
  Info_Card({super.key, required this.name, required this.icon});
  final String name;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
        size: 25.sp,
      ),
      trailing: CircleAvatar(
        backgroundColor: Colors.green,
        child: icon,
      ),
      title: Text(
        name,
        style: TextStyle(fontSize: 17.sp, color: Colors.white),
      ),
    );
  }
}
