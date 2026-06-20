import 'package:movegui/models/pricing_config_model.dart';
import 'package:movegui/services/api_service.dart';

class PricingService {
  final PricingConfigModel config;
  final ApiService api;

  PricingService({required this.api , required this.config, });

  double calculate({
    required double distanceKm,
    required int items,
    required double orderAmount,
    bool isExpress = false,
  }) {
    // Free delivery
    if (orderAmount >= config.freeThreshold) {
      return 0;
    }

    double price =
        config.baseFee +
        (distanceKm * config.pricePerKm) +
        (items * config.pricePerItem);

    if (isExpress) {
      price += config.expressFee;
    }

    return price;
  }
}