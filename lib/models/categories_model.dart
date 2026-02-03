

import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/models/model.dart';

 class CategoriesModel extends Model{
  CategoriesModel({  required super.id, required super.name, required super.createdAt,}) ;
 
  
@override
  Map<String, dynamic> toJson() => {
  'id':id,
  'name': name,
  'createdAt': createdAt
};

factory CategoriesModel.fromJson(Map<String, dynamic> json)  {
  return CategoriesModel(
     id: json['id'],
   name: json['name'], 
   createdAt: json['createdAt'].toDate()
   );
}

String toString(){
  return id+' '+name+' '+createdAt.toString();
}

static List<CategoriesModel> getCommandCategories(){
   final restaurantConstants  = RestaurantConstants();
   final patisserieConstants =  PatisserieConstants();
   final superMarktConstants = SuperMarktConstants();
   final supplierConstants = SupplierConstants();
  return[
    CategoriesModel(id: "001", name: restaurantConstants.getTitleName(), createdAt: DateTime.now()),
    CategoriesModel(id: "002", name: patisserieConstants.getTitleName(), createdAt: DateTime.now()),
    CategoriesModel(id: "003", name: superMarktConstants.getTitleName(), createdAt: DateTime.now()),
    CategoriesModel(id: "004", name: supplierConstants.getTitleName(), createdAt: DateTime.now())
  ];
}
  
}


class CategoryIngredient extends CategoriesModel{
  CategoryIngredient({required super.id, required super.name, required super.createdAt});

  
factory CategoryIngredient.fromJson(Map<String, dynamic> json)  {
  return CategoryIngredient(
     id: json['id'],
   name: json['name'], 
   createdAt: json['createdAt'].toDate()
   );
}

@override
  Map<String, dynamic> toJson() {
    return super.toJson();
  }
  
}

class Categoryrecipe extends Model {
  Categoryrecipe({required super.id, required super.name, required super.createdAt});

  Map<String, dynamic> toJson() => {
  'id':id,
  'name': name,
};

factory Categoryrecipe.fromJson(Map<String, dynamic> json) => Categoryrecipe (
  id: json['id'],
  name: json['name'],
  createdAt: json['createdAt'].toDate()
  );
}

class CategoryRestaurant extends Model {
  final String imageUrl;
   final String description;

  CategoryRestaurant({
    required super.id,
     required super.name,
     required super.createdAt,
     required this.imageUrl,
     required this.description,
     });


  Map<String, dynamic> toJson() => {
    'id':id,
    'name': name,
};

factory CategoryRestaurant.fromJson(Map<String, dynamic> json) => CategoryRestaurant (
  id: json['id'],
  name: json['name'],
  imageUrl: json['imageurl'],
  description: json['description'],
  createdAt: json['createdAt'] != null ? json['createdAt'].toDate() : DateTime.now()
  );
  
}