import 'package:movegui/models/model.dart';
import 'package:movegui/models/pressing/pressing_model.dart';
import 'package:movegui/models/pressing/pressing_order_item.dart';
import 'package:movegui/models/user_model.dart';

class PressingOrder extends Model {
  final List<PressingOrderItem> items;
  final DateTime? pickupDate;
  final DateTime? deliveryDate;
  final PressingModel pressing;
  final UserModel user;
  final double total;

  PressingOrder({
    required this.items,
    required this.pickupDate,
    required this.deliveryDate,
    required this.pressing,
    required this.user,
    required this.total,
    required super.id,
    required super.name,
    required super.createdAt,
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'items': items.map((e) => e.toJson()).toList(),
    'pickupDate': pickupDate?.toIso8601String(),
    'deliveryDate': deliveryDate?.toIso8601String(),
    'pressing': pressing.toJson(),
    'user': user.toJson(),
    'total': total,
  };

  factory PressingOrder.fromJson(Map<String, dynamic> json) => PressingOrder(
    items:
        (json['items'] as List? ?? [])
            .map((e) => PressingOrderItem.fromJson(e))
            .toList(),
    pickupDate:
        json['pickupDate'] != null ? DateTime.parse(json['pickupDate']) : null,
    deliveryDate:
        json['deliveryDate'] != null
            ? DateTime.parse(json['deliveryDate'])
            : null,
    pressing: PressingModel.fromJson(json['pressing']),
    user: UserModel.fromJson(json['user']),
    total: json['total'],
    id: json['id'],
    name: json['name'],
    createdAt:
        json['createdAt'] != null ? json['createdAt'].toDate() : DateTime.now(),
  );
}
