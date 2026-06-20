import 'package:movegui/models/model.dart';

abstract class ServiceModel extends Model {
  final double? minPrice;
  final double? maxPrice;
  final double? basePrice;
    final bool? active;
  final Duration? estimatedDuration;

  ServiceModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required this.minPrice,
    required this.maxPrice,
    required this.basePrice,
    required this.active,
    required this.estimatedDuration
  });

  String getCollectionName();

}
