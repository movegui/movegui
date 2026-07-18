import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui/models/pressing/pressing_model.dart';
import 'package:movegui/models/pressing/pressing_service_model.dart';
import 'package:movegui/models/pressing/pressing_service_type_model.dart';
import 'package:movegui/services/interfaces/i_pressing_services.dart';
import 'package:movegui/services/model_service.dart';

class PressingService extends ModelService<PressingModel>
    implements IPressingServices {
  PressingService({required super.api});

  @override
  Future<PressingModel> addModel(PressingModel pressing) async {
    await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(pressing.id)
        .set(pressing.toJson());
    return pressing;
  }

  @override
  Future<List<PressingModel>> allModels() async {
    final snapshot =
        await FirebaseFirestore.instance.collection(getCollectionName()).get();

    return snapshot.docs
        .map((doc) => PressingModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<PressingModel>> getByName(String name) async {
    final snapshot =
        await FirebaseFirestore.instance
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
    final snapshot =
        await FirebaseFirestore.instance
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
    final snapshot =
        await FirebaseFirestore.instance
            .collection(getCollectionName())
            .doc(id)
            .get();
    return PressingModel.fromJson(snapshot.data()!);
  }

  @override
  Future<List<PressingServiceModel>> getAllServices(String id) async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection(getCollectionName())
            .doc(id)
            .collection('services')
            .get();
    return snapshot.docs
        .map((doc) => PressingServiceModel.fromJson(doc.data()))
        .toList();
  }

  /*
  Future<double> getOrderedServices(
    Map<String, List<ServiceModel>> listServices,
    List<int> qtys,
  ) async {
    double total = 0;

    for (var entry in listServices.entries) {
      double value = await getTotal(entry.value, qtys); // ✅ await
      total += value; // ✅ now it's double
    }

    return total;
  }
  */

  List<PressingServiceModel> getServicesByType(
    List<PressingServiceModel> services,
    PressingServiceTypeModel? selectedServiceType,
  ) {
    return services
        .where((service) => service.serviceType.id == selectedServiceType?.id)
        .toList();
  }

}
