import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui/models/adress_model.dart';
import 'package:movegui/models/model.dart';
import 'package:movegui/services/api_service.dart';
import 'package:movegui/services/service_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

abstract class ModelService<T extends Model> {
  final ApiService api;

  ModelService({required this.api});
  Future<T> addModel(T model);
  Future<List<T>> allModels();
  Future<List<T>> getByName(String name);
  String getCollectionName();
  Future<T> getModelById(String id);

  Future<void> callNumber(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      /*
        MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.deactivate_button_title,
        AppLocalizations.of(context)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
      */
      throw Exception('Could not launch $uri');
    }
  }

  String getCureency() {
    return api.currency;
  }

  Future<double> getTotal(List<ServiceModel> services, List<int> qtys) async {
    double sum = 0;
    for (var i = 0; i < services.length; i++) {
      final service = services[i];
      final qty = i < qtys.length ? qtys[i] : 0;
      final pricePerUnit = (service.basePrice ?? 0);
      sum += (pricePerUnit * qty);
    }
    return sum;
  }

  Future<AdressModel> addAdress(String id, AdressModel adress) async {
    await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(id)
        .collection(AdressModel.getCollectionName())
        .doc(adress.id)
        .set(adress.toJson());

    return adress;
  }

  Future<AdressModel> updateAddress(String userId, AdressModel address) async {
    await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(userId)
        .collection(AdressModel.getCollectionName())
        .doc(address.id)
        .set(address.toJson(), SetOptions(merge: true));

    return address;
  }

  Future<void> updateAddresses(
    String userId,
    List<AdressModel?>? addresses,
  ) async {
    for (final address in addresses!) {
      await updateAddress(userId, address!);
    }
  }

  Future<Map<String, dynamic>> loadConfig() async {
  final jsonString = await rootBundle.loadString('assets/config/info.json');
  return json.decode(jsonString);
}

Future<String> generateOrderNumber() async {
  final firestore = FirebaseFirestore.instance;

  return firestore.runTransaction((transaction) async {
    final counterRef =
        firestore.collection('counters').doc('pressing_orders');

    final snapshot = await transaction.get(counterRef);

    int current = snapshot.data()?['lastNumber'] ?? 0;
    current++;

    transaction.set(
      counterRef,
      {'lastNumber': current},
      SetOptions(merge: true),
    );

    final now = DateTime.now();

    return 'PRS-'
        '${now.year}'
        '${now.month.toString().padLeft(2, '0')}'
        '${now.day.toString().padLeft(2, '0')}-'
        '${current.toString().padLeft(4, '0')}';
  });
}

}
