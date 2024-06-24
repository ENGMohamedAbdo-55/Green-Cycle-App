import 'dart:io';

import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';



import '../../model/report_model.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(AddReportInitial());
  static ReportCubit get(context) => BlocProvider.of(context);
  var addReportKey = GlobalKey<FormState>();

  var countryController = TextEditingController();
  var descriptionController = TextEditingController();
  var cityController = TextEditingController();
  var addressController = TextEditingController();

  int currentReportIndex = 0;

  void changeCurrentTask(int indexx) {
    currentReportIndex = indexx;
  }
  void clearReportController()
  {
    countryController.clear();
    descriptionController.clear();
    cityController.clear();
    addressController.clear();
  }
  File? reportCameraFile;
  String? reportCameraUrl;
  cameraImage() async {
// Capture a photo.
    emit(TakePhotoLoading());
    try {
      final ImagePicker reportPicker = ImagePicker();
      final XFile? reportImageCamera =
          await reportPicker.pickImage(source: ImageSource.camera);
      if (reportImageCamera != null) {
        reportCameraFile = File(reportImageCamera.path);
        var reportCameraImageName = basename(reportImageCamera.path);
        var cameraFileReference = FirebaseStorage.instance.ref(reportCameraImageName);
        await cameraFileReference.putFile(reportCameraFile!);
        reportCameraUrl = await cameraFileReference.getDownloadURL();
      }
      emit(TakePhotoSuccess());
    } catch (e) {
      print('Error while capturing photo: $e');
      
    }
  }
  void addReportToFireBase() {
    ReportModel post = ReportModel(
      country: countryController.text,
      description: descriptionController.text,
      city: cityController.text,
      address: addressController.text,
      reportCameraUrl: reportCameraUrl
    );
    emit(AddReportLoadingState());
    FirebaseFirestore.instance
        .collection('reports')
        .add(post.toJson())
        .then((value) {
      print('Add Report Successfully');
      emit(AddReportSuccessState());
    }).catchError((onError) {
      print('Add Report Error $onError');
      emit(AddReportErrorState());
    });
  }

  List<ReportModel> firebaseReports = [];

  void getAllReportsFromFireBase() {
    emit(GetReportLoadingState());
    FirebaseFirestore.instance
        .collection('reports')
        .snapshots()
        .listen((value) {
      firebaseReports = [];
      for (var element in value.docs) {
        ReportModel currentReport =
            ReportModel.fromJson(element.data());
        currentReport.id = element.id;
        firebaseReports.add(
          currentReport,
        );
        // print(element.data());
      }
      emit(GetReportSuccessState());
    }).onError((error) {
      print('Get All Reports FireBase Error $error');
      emit(GetReportErrorState());
    });
  }
}

