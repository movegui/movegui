
import 'package:flutter/material.dart';
import 'package:movegui/models/adress_model.dart';

class AddressProvider extends ChangeNotifier {
  AdressModel? _address;

  AdressModel? get address => _address;

  void setAdress(AdressModel address) {
    _address = address;
    notifyListeners();
  }

  void clearAdress() {
    _address = null;
    notifyListeners();
  }

}