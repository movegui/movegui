import 'package:movegui/models/adress_model.dart';
import 'package:movegui/models/order_item_model.dart';
import 'package:movegui/models/order_model.dart';
import 'package:movegui/models/store/store_model.dart';
import 'package:movegui/models/user_model.dart';

abstract class StoreOrderModel<
  S extends StoreModel,
  U extends UserModel,
  T extends OrderItemModel
>
    extends OrderModel<U, T> {
  final S store;
   DateTime? pickupDate;
   DateTime? deliveryDate;
   AdressModel? pickupAdress;
   AdressModel? deliveryAdress;
  StoreOrderModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.user,
    required super.total,
    required super.items,
    required this.store,
    required this.deliveryDate,
    required this.pickupDate,
    required this.pickupAdress,
    required this.deliveryAdress, 
    required super.status, required super.currency,
    
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'store': store.toJson(),
    'pickupDate': pickupDate != null ? pickupDate!.toIso8601String() : null,
    'deliveryDate': deliveryDate != null ? deliveryDate!.toIso8601String() : null,
    'pickupAdress': pickupAdress != null ? pickupAdress!.toJson() : null,
    'deliveryAdress': deliveryAdress != null ? deliveryAdress!.toJson() : null,
    'status': status,
  };
}
