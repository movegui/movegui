

import 'package:movegui/models/model.dart';

abstract class ModelService<T extends Model> {
  Future<void> addModel(T model);
  Future<List<T>> allModels();
  Future<List<T>> getByName(String name);
  String getCollectionName();
  Future<T> getById(String id);
}