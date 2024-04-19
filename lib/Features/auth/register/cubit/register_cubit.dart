import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  bool isSecured = true;
  Widget togglePass() {
    return IconButton(
      onPressed: () {
        isSecured = !isSecured;
        emit(TogglePasswordState(isSecured));
      },
      icon: isSecured
          ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off),
      color: Colors.grey,
    );
  }

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update user's display name
      await userCredential.user!.updateDisplayName(name);

      // Save user data to Firestore
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set({
        'name': name,
        'phone': phone,
        'email': email,
        // Add fields as needed
      });

      emit(RegisterSuccessState(userCredential.user!));
      // addUserToFireStore();
    } catch (error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    }
  }

  // void addUserToFireStore() {
  //   FirebaseFirestore.instance
  //       .collection('Users')
  //       .add(
  //         {
  //           'uid': FirebaseAuth.instance.currentUser?.uid,
  //           'email': FirebaseAuth.instance.currentUser?.email,
  //         },
  //       )
  //       .then(
  //         (value) => print('Add User To FireStore Successfully'),
  //       )
  //       .catchError(
  //         (onError) {
  //           print('Add User To FireStore Error $onError');
  //         },
  //       );
  // }
}
