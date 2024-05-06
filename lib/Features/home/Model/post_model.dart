import 'package:flutter/material.dart';

class PostModelFireBase {
  String? id;
  String? title;
  String? description;
  String? date;
  String? time;

  PostModelFireBase({
    this.id,
    this.title,
    this.description,
    this.date,
    this.time,
  });

  PostModelFireBase.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'time': time,
    };
  }
}
