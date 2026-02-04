import 'package:movegui/models/categories_model.dart';

abstract class ICategories {
  Future<List<CategoriesModel>> getAllCommandCategories();
  Future<List<CategoriesModel>> getCourseCategories();
}
