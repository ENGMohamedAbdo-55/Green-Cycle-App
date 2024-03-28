import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_cycle_app/firebase/models/category_model.dart';

class CategoryRepo{
  final db =FirebaseFirestore.instance;

  Future<List<CategoryModel>> getAllCategories()async
  {
    try {
      final snapshot=await db.collection('Categories').get();
      final list=snapshot.docs.map((document) => CategoryModel.fromSnapShot(document)).toList();
      return list;
    }on FirebaseException  catch(e) {
      throw 'Something Went Wrong';
    }
  }
}