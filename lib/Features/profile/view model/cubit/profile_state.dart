import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final String name;
  final String email;
  final String phone;

  UserProfileLoaded({required this.name, required this.email, required this.phone});
}

class UserProfileError extends UserProfileState {
  final String message;

  UserProfileError({required this.message});
}
