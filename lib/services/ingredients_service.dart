import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui/models/ingredient_model.dart';
import 'package:movegui/services/model_service.dart';

class IngredientsService  extends ModelService<IngredientModel>{

  
  @override
  Future<void> addModel(IngredientModel ingredient) async {
    await FirebaseFirestore.instance
    .collection(getCollectionName())
    .doc(ingredient.id)
    .set(ingredient.toJson());
  }

  @override
  Future<List<IngredientModel>> allModels() async {
    final snapshot = await FirebaseFirestore.instance
                              .collection(getCollectionName())
                              .get();
    return snapshot.docs.map((doc) => IngredientModel.fromJson(doc.data())).toList();
  }

  @override
  String getCollectionName() {
    return "ingredients_model";
  }

    @override
  Future<List<IngredientModel>> getByName(String name) async {
      final snapshot = await FirebaseFirestore.instance
      .collection(getCollectionName())
      .where('name', isEqualTo: name) 
      .get();

  return snapshot.docs
      .map((doc) => IngredientModel.fromJson(doc.data()))
      .toList();
  }

   Future<IngredientModel> getById(String id) async {
  final snapshot = await FirebaseFirestore.instance
      .collection(getCollectionName())
      .doc(id)
      .get();

  if (!snapshot.exists || snapshot.data() == null) {
     throw Exception("Ingredient not found");
  }

  return IngredientModel.fromJson(snapshot.data()!);
}
  
}