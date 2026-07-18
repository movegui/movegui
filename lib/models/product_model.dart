import 'package:movegui/models/company_model.dart';
import 'package:movegui/models/model.dart';

abstract class ProductModel extends Model {
  final double price;
  final CompanyModel? supplier;
  final bool isAvailable;
  final String? imageUrl;
  final String? category;
  final String currency;

  ProductModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required this.price,
    required this.supplier,
    required this.imageUrl,
    required this.category,
    required this.isAvailable,
    required this.currency
  });

  @override
  Map<String, dynamic> toJson() => {...super.toJson(),
   'supplier': supplier != null ? supplier!.toJson() : null,
   'price': price,
   'isAvailable': isAvailable,
   'imageUrl': imageUrl != null ? imageUrl : '',
   'category': category != null? category : '',
   'currency': currency

  };
}


/*

class ProductModel extends Model {
final String imageUrl;
final double price;
final List<RecipeModel> recipes;

  ProductModel({
    required super.id, 
    required super.name,
    required super.createdAt,
    required this.imageUrl,
    required this.price,
    required this.recipes
    });

    Map<String, dynamic> toJson() => {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'recipes': recipes,

    };

    factory ProductModel.fromJson(Map<String, dynamic> json) =>  ProductModel(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      recipes: json['recipes']
    );

  
}
*/