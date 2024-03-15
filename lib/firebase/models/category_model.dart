import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel{
  String id;
  String name;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    this.parentId='',
    required this.isFeatured,

  });

  static CategoryModel empty()=>CategoryModel(id: '', name: '', isFeatured: false);

  //Convert The Model toJson

  Map<String,dynamic>toJson(){
    return{
      'name':name ,
      'isFeatured':isFeatured ,
      'parentId':parentId ,
    };
  }

  factory CategoryModel.fromSnapShot(DocumentSnapshot<Map<String,dynamic>> document){
    if (document.data() != null) {
      final data = document.data()!;

      //Map Json record to the model
      return CategoryModel(
          id: document.id,
          name: data['name'] ?? '',
          parentId: data['parentId'] ?? '',
          isFeatured:data['isFeatured'] ?? false,
      );
    }else
      {
        return CategoryModel.empty();
      }

  }


}