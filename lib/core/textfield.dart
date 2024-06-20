import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool obsecure;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onEditingCompleted;
  final ValueChanged<String>? onFieldSubmitted;
  final bool readOnly;

 

  const DefaultTextField({
    super.key,
    required this.controller,
    this.validator,
    this.obsecure = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.onEditingCompleted,
    this.onFieldSubmitted,
    this.readOnly = false,

  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obsecure,
      onChanged: onChanged,
      onEditingComplete: onEditingCompleted,
      cursorColor: Colors.black,
      readOnly: readOnly,
      textAlign: TextAlign.end,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        suffixIconColor: MyColors.greyColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0).r),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0.r),
            borderSide: BorderSide(
              color: MyColors.greenColor,
              
            )),
        hintText: hintText,
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final bool obsecure;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onEditingCompleted;
  final ValueChanged<String>? onFieldSubmitted;
  final bool readOnly;

  const SearchTextField({
    super.key,
    required this.controller,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.obsecure = false,
    this.readOnly = false,
    this.suffixIcon,
    this.prefixIcon,
    this.hintText,
    this.labelText,
    this.onChanged,
    this.onEditingCompleted,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obsecure,
      onChanged: onChanged,
      onEditingComplete: onEditingCompleted,
      cursorColor: Colors.grey,
      readOnly: readOnly,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: MyColors.greenColor,
        )),
        hintText: hintText,
      ),
    );
  }
}

class OTPTextField extends StatelessWidget {
  const OTPTextField({this.onSaved, super.key});
  final FormFieldSetter<String>? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
        }
      },
      onSaved: onSaved,
      keyboardType: TextInputType.number,
      maxLength: 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        counterText: "",
      ),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}

class PostTxtField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final onTap;
  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? height;
  final int? lines;
  const PostTxtField(
      {this.hintText,
      this.height,
      this.onTap,
      this.lines,
      this.prefixIcon,
      this.keyboardType = TextInputType.text,
      required this.controller,
      this.labelText,
      this.onChanged,
      this.suffixIcon,
      this.validator,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 55.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: MyColors.textFieldColor,
          borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.all(8.0.r),
        child: TextFormField(
          onTap: onTap,
          maxLines: lines ?? 1,
          controller: controller,
          validator: validator,
          textAlign: TextAlign.end,
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: MyColors.blackColor,
            fontSize: 16.sp,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? 'post Title',
            hintStyle: TextStyle(
              color: MyColors.blackColor,
              fontSize: 16.sp,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}

class DateTime_TxtField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final onTap;
  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? height;
  final int? lines;
  const DateTime_TxtField(
      {this.hintText,
      this.height,
      this.onTap,
      this.lines,
      this.prefixIcon,
      this.keyboardType = TextInputType.none,
      required this.controller,
      this.labelText,
      this.onChanged,
      this.suffixIcon,
      this.validator,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 55.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: MyColors.textFieldColor,
          borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.all(8.0.r),
        child: TextFormField(
          keyboardType: TextInputType.none,
          onTap: onTap,
          maxLines: lines ?? 1,
          controller: controller,
          validator: validator,
          textAlign: TextAlign.end,
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: MyColors.blackColor,
            fontSize: 16.sp,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? 'post Title',
            hintStyle: TextStyle(
              color: MyColors.blackColor,
              fontSize: 16.sp,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}

class ChatTextField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool obsecure;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onEditingCompleted;
  final ValueChanged<String>? onFieldSubmitted;
  final bool readOnly;




  const ChatTextField({
    super.key,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obsecure = false,
    this.readOnly = false,
    this.suffixIcon,
    this.prefixIcon,
    this.hintText,
    this.labelText,
    this.onChanged,
    this.onEditingCompleted,
    this.onFieldSubmitted,

  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 5,
      minLines: 1,
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obsecure,
      onChanged: onChanged,
      onEditingComplete: onEditingCompleted,
      cursorColor: Colors.black,
      readOnly: readOnly,
      textAlign: TextAlign.end,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        prefixIcon: prefixIcon,
        suffixIcon:suffixIcon,
        suffixIconColor: MyColors.greyColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0).r),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0.r),
            borderSide: BorderSide(
              color: MyColors.greenColor,
            )),
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 20.0.w), // Adjust the padding here
      ),
    );
  }
}

