import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PostModelFireBase {
  String? id;
  String? title;
  String? description;
  String? date;
  String? time;
  String? cameraUrl;
  String? galleryUrl;

  PostModelFireBase({
    this.id,
    this.title,
    this.description,
    this.date,
    this.time, 
    this.cameraUrl ,
    this.galleryUrl ,
  });

  PostModelFireBase.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    date = json['date'];
    time = json['time'];
    cameraUrl = json['cameraUrl'];
    galleryUrl = json['galleryUrl'];
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
    };
  }
}
