import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui/models/supplier_model.dart';
import 'package:movegui/services/model_service.dart';

class SuppliersService extends ModelService<SupplierModel> {
  SuppliersService({required super.api});

  @override
  Future<SupplierModel> addModel(SupplierModel model) async {
    await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(model.id)
        .set(model.toJson());
    return model;
  }

  @override
  Future<List<SupplierModel>> allModels() async {
    final snapshot =
        await FirebaseFirestore.instance.collection(getCollectionName()).get();

    return snapshot.docs
        .map((doc) => SupplierModel.fromJson(doc.data()))
        .toList();
  }

  @override
  String getCollectionName() {
    return "suppliers_model";
  }

  @override
  Future<List<SupplierModel>> getByName(String name) async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection(getCollectionName())
            .where('name', isEqualTo: name)
            .get();

    return snapshot.docs
        .map((doc) => SupplierModel.fromJson(doc.data()))
        .toList();
  }

  Future<SupplierModel> getById(String id) async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection(getCollectionName())
            .doc(id)
            .get();

    if (!snapshot.exists || snapshot.data() == null) {
      throw Exception("Supplier not found");
    }

    return SupplierModel.fromJson(snapshot.data()!);
  }
  
  @override
  Future<SupplierModel> getModelById(String id) async {
        final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(id)
        .get();
    return SupplierModel.fromJson(snapshot.data()!);
  }
}
