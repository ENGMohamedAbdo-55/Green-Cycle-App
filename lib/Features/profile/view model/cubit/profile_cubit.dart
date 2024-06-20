import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'profile_state.dart';



class UserProfileCubit extends Cubit<UserProfileState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  UserProfileCubit() : super(UserProfileInitial());

  Future<void> loadUserProfile() async {
    emit(UserProfileLoading());
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userProfile = await _firestore.collection('Users').doc(user.uid).get();
        emit(UserProfileLoaded(
          phone: userProfile['phone'],
          name: userProfile['name'],
          email: userProfile['email'],
         
        ));
      }
    } catch (e) {
      emit(UserProfileError(message: e.toString()));
    }
  }

  Future<void> updateUserProfile(String name, String phone,) async {
    try {
      emit(UserProfileLoading());
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('Users').doc(user.uid).update({
       'phone': phone,
          'name': name,
        

        });
        loadUserProfile();
      }
    } catch (e) {
      emit(UserProfileError(message: e.toString()));
    }
  }

  Future<void> updateProfileImage(File imageFile) async {
    try {
      emit(UserProfileLoading());
      User? user = _auth.currentUser;
      if (user != null) {
        String fileName = '${user.uid}.jpg';
        UploadTask uploadTask = _storage.ref().child('profile_images/$fileName').putFile(imageFile);
        TaskSnapshot snapshot = await uploadTask;
        String photoUrl = await snapshot.ref.getDownloadURL();
        await _firestore.collection('Users').doc(user.uid).update({
          'photoUrl': photoUrl,
        });
        loadUserProfile();
      }
    } catch (e) {
      emit(UserProfileError(message: e.toString()));
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      updateProfileImage(File(pickedFile.path));
    }
  }
}
