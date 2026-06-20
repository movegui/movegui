

import 'package:firebase_remote_config/firebase_remote_config.dart';

class PricingConfigModel {
  final double baseFee;
  final double pricePerKm;
  final double pricePerItem;
  final double expressFee;
  final double freeThreshold;

  PricingConfigModel({
    required this.baseFee,
    required this.pricePerKm,
    required this.pricePerItem,
    required this.expressFee,
    required this.freeThreshold,
  });

  factory PricingConfigModel.fromRemote() {
    final rc = FirebaseRemoteConfig.instance;
    return PricingConfigModel(
      baseFee: rc.getDouble("base_fee"),
      pricePerKm: rc.getDouble("price_per_km"),
      pricePerItem: rc.getDouble("price_per_item"),
      expressFee: rc.getDouble("express_fee"),
      freeThreshold: rc.getDouble("free_delivery_threshold"),
    );
  }
}