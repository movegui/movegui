import 'package:movegui/models/adress_model.dart';
import 'package:movegui/models/pressing/pressing_model.dart';
import 'package:movegui/models/pressing/pressing_order_item.dart';
import 'package:movegui/models/store/store_order_model.dart';
import 'package:movegui/models/user_model.dart';

class PressingOrderModel
    extends StoreOrderModel<PressingModel, UserModel, PressingOrderItem> {
  PressingOrderModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.user,
    required super.total,
    required super.items,
    required super.store,
    required super.deliveryDate,
    required super.pickupDate,
    required super.pickupAdress,
    required super.deliveryAdress,
    required super.status,
    required super.currency,
  });

  @override
  Map<String, dynamic> toJson() => {...super.toJson()};

  factory PressingOrderModel.fromJson(
    Map<String, dynamic> json,
  ) => PressingOrderModel(
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
    store: PressingModel.fromJson(json['store']),
    user: UserModel.fromJson(json['user']),
    total: json['total'],
    id: json['id'],
    name: json['name'],
    createdAt:
        json['createdAt'] != null ? json['createdAt'].toDate() : DateTime.now(),
    pickupAdress: AdressModel.fromJson(json['pickupAdress']),
    deliveryAdress: AdressModel.fromJson(json['deliveryAdress']),
    status: json['status'], 
    currency: 'GNF',
  );
}
