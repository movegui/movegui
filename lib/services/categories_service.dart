import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui/models/categories_model.dart';
import 'package:movegui/services/interfaces/i_categories.dart';
import 'package:movegui/services/model_service.dart';


class CategoriesService extends ModelService<CategoriesModel> implements ICategories {


  @override
  Future<void> addModel(CategoriesModel ingredient) async {
    await FirebaseFirestore.instance
          .collection(getCollectionName())
          .doc(ingredient.id)
          .set(ingredient.toJson());
  }
  
@override
Future<List<CategoriesModel>> allModels() async {
  final snapshot = await FirebaseFirestore.instance
      .collection(getCollectionName())
      .get();

  return snapshot.docs.map((doc) => CategoriesModel.fromJson(doc.data())).toList();
}
  
  @override
  String getCollectionName() {
   return "categories_model";
  }
  
  @override
  Future<List<CategoriesModel>> getByName(String name) async {
      final snapshot = await FirebaseFirestore.instance
      .collection(getCollectionName())
      .where('name', isEqualTo: name) 
      .get();

  return snapshot.docs
      .map((doc) => CategoriesModel.fromJson(doc.data()))
      .toList();
  }
  
  @override
  Future<List<CategoriesModel>> getAllCommandCategories() async {
    return await CategoriesModel.getCommandCategories();
  }
  
  @override
  Future<List<CategoriesModel>> getCourseCategories() async {
     return await CategoriesModel.getCourseCategories();
  }

  


  
}