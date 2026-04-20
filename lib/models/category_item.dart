import 'package:movegui/models/categories_model.dart';

class CategoryItem extends CategoriesModel {
  final String imageUrl;
  final String routeName;
  final bool enabled;

  CategoryItem({required super.id, required super.name, required super.createdAt, required this.imageUrl, required this.routeName, required this.enabled});
}