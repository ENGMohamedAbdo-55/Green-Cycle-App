import 'package:flutter/material.dart';
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
      cursorColor: Colors.black,
      readOnly: readOnly,
      textAlign: TextAlign.end,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        prefixIcon: prefixIcon,
        suffixIcon:suffixIcon,
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
        suffixIcon:suffixIcon,
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
  const OTPTextField({this.onSaved,super.key});
   final FormFieldSetter<String>? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      onChanged: (value){
        if(value.length==1)
        {
          FocusScope.of(context).nextFocus();
        }
      },

      onSaved: onSaved,
      keyboardType: TextInputType.number,
      maxLength:1 ,
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
