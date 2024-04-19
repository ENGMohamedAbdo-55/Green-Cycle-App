import 'package:flutter/material.dart';
import 'package:green_cycle_app/core/components/text_styles.dart';

class Post_Screen extends StatelessWidget {
  const Post_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('data',style: AppStyles.textStyle30,),
    );
  }
}