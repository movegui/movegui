
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui/models/pressing/pressing_model.dart';
import 'package:movegui/services/model_service.dart';

class PressingService extends ModelService<PressingModel>{
  PressingService({required super.api});

  
  @override
  Future<PressingModel> addModel(PressingModel pressing) async{
        await FirebaseFirestore.instance
          .collection(getCollectionName())
          .doc(pressing.id)
          .set(pressing.toJson());
          return pressing;
  }

  @override
  Future<List<PressingModel>> allModels() async {
    final snapshot = await FirebaseFirestore.instance
      .collection(getCollectionName())
      .get();

  return snapshot.docs.map((doc) => PressingModel.fromJson(doc.data())).toList();
  }

  @override
  Future<List<PressingModel>> getByName(String name) async {
              final snapshot = await FirebaseFirestore.instance
      .collection(getCollectionName())
      .where('name', isEqualTo: name) 
      .get();

  return snapshot.docs
      .map((doc) => PressingModel.fromJson(doc.data()))
      .toList();
  }

  @override
  String getCollectionName() {
    return "pressings_model";
  }

    
  Future<PressingModel> getById(String id) async {
  final snapshot = await FirebaseFirestore.instance
      .collection(getCollectionName())
      .doc(id)
      .get();

  if (!snapshot.exists || snapshot.data() == null) {
     throw Exception("Pressing not found");
  }

  return PressingModel.fromJson(snapshot.data()!);
}

  @override
  Future<PressingModel> getModelById(String id) async {
           final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(id)
        .get();
    return PressingModel.fromJson(snapshot.data()!);
  }
}