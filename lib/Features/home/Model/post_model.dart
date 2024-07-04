

import '../../auth/model/user_model.dart';


class PostModelFireBase extends UserModel{
  String? id;
  String? title;
  String? description;
  String? date;
  String? time;
  String? cameraUrl;
String?galleryUrl;


  PostModelFireBase({
    this.id,
    this.title,
    this.description,
    this.date,
    this.time, 
    this.cameraUrl ,
    this.galleryUrl,
    required super.uId,
    required super.name,
    required super.phone,
    required super.email,
    required super.image ,



  });

  factory PostModelFireBase.fromJson(Map<String, dynamic> json) {
    return PostModelFireBase(
      cameraUrl:json['cameraUrl'] ,
      galleryUrl:json['galleryUrl'] ,
      date:json['date'],
      description:json['description'] ,
      time:json['time'],
      title:json['title'],

      //UserModel

      uId: json['uId'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      image: json['image'],


    );

  }

  get isEmpty => null;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'cameraUrl': cameraUrl,
      'galleryUrl': galleryUrl,


      //UserModel
      'uId': uId,
      'name': name,
      'phone': phone,
      'email': email,
      'image' :image,
    };
  }
}
