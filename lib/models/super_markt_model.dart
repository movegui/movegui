import 'package:movegui/models/categories_model.dart';
import 'package:movegui/models/open_hours_model.dart';
import 'package:movegui/models/person_model.dart';
import 'package:movegui/models/restaurant_model.dart';
import 'package:movegui/models/store_model.dart';

class SuperMarktModel extends StoreModel {
  final CategoriesModel category;
  SuperMarktModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.description,
    required super.adresse,
    required super.contacts,
    required super.email,
    required super.imageUrl,
    required super.telephon,
    required super.weeklyHours,
    required super.storeType,
    required this.category,
    super.longitude,
    super.latitude

  });

  @override
  Map<String, dynamic> toJson() => {...super.toJson()};

  factory SuperMarktModel.fromJson(Map<String, dynamic> json) =>
      SuperMarktModel(
        id: json['id'],
        name: json['name'],
        createdAt: json['createdAt'] != null ? json['createdAt'].toDate() : DateTime.now(),
        description: json['description'],
        imageUrl: json['imageUrl'],
        adresse: json['adresse'],
        email: json['email'],
        telephon: json['telephon'],
        contacts: (json['contacts'] as List? ?? [])
            .map((e) => PersonModel.fromJson(e))
            .toList(),
                        weeklyHours: (json['weeklyHours'] as List? ?? [])
            .map(
              (e) => (e != null && e['openTime'] != null && e['closeTime'] != null && e['day'] != null)
                  ? OpenHours.fromJson(e)
                  : null,
            )
            .where((e) => e != null)
            .cast<OpenHours>()
            .toList(),
         storeType: RestaurantTypeModel.fromJson(json['storeType']),
          category: json['category'] != null ? CategoriesModel.fromJson(json['category']) : CategoriesModel(id: '0', name: 'name', createdAt: DateTime.now()),
      );
}
